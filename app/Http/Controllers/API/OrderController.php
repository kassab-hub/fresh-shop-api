<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\JsonResponse;
use Exception;

class OrderController extends Controller
{
    public function checkout(Request $request): JsonResponse
    {
        // 1. التحقق من هيكل البيانات القادمة (تحديث ليشمل رقم المستخدم)
        $request->validate([
            'user_id'            => 'nullable|integer|exists:users,id', // 👈 التأكد من وجود المستخدم في MySQL
            'total_price'        => 'required|numeric',
            'items'              => 'required|array',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity'   => 'required|integer|min:1',
        ]);

        DB::beginTransaction();

        try {
            // 🎯 تحسين الأداء: جمع كل الـ IDs المطلوبة وجلب المنتجات باستعلام واحد فقط!
            $productIds = collect($request->items)->pluck('product_id')->toArray();
            $products = Product::whereIn('id', $productIds)->get()->keyBy('id');

            $calculatedTotalPrice = 0;
            $orderItemsData = [];

            // 2. معالجة العناصر والتحقق من الأسعار الحقيقية من الكولكشن المجلوب
            foreach ($request->items as $item) {
                $product = $products->get($item['product_id']);
                
                // في حال حُذف المنتج فجأة أثناء المعالجة (حماية إضافية)
                if (!$product) {
                    return response()->json([
                        'status'  => false,
                        'message' => 'عذراً، أحد المنتجات في سلتك لم يعد متوفراً.'
                    ], 404);
                }

                $dbPrice = $product->price;
                $quantity = $item['quantity'];
                $itemSubtotal = $dbPrice * $quantity;

                $calculatedTotalPrice += $itemSubtotal;

                // تجهيز البيانات للحفظ اللاحق
                $orderItemsData[] = [
                    'product_id' => $item['product_id'],
                    'quantity'   => $quantity,
                    'price'      => $dbPrice,
                ];
            }

            // 3. حماية إضافية: مقارنة المجموع الكلي مع فلاتر/الويب
            if (abs($calculatedTotalPrice - $request->total_price) > 0.01) {
                return response()->json([
                    'status'  => false,
                    'message' => 'عذراً، حدث خطأ في احتساب إجمالي الطلب، يرجى تحديث السلة.'
                ], 400);
            }

            // 4. حفظ الطلب الرئيسي وتثبيت المستخدم
            $order = Order::create([
                'user_id'     => $request->input('user_id'), // 👈 هنا يتم ربط الطلب بالمستخدم المسجل في قاعدة البيانات
                'total_price' => $calculatedTotalPrice,
                'status'      => 'pending',
            ]);

            // 5. 🎯 تحسين الأداء: حفظ جميع عناصر السلة دفعة واحدة (Bulk Insert)
            $finalOrderItems = array_map(function($itemData) use ($order) {
                $itemData['order_id'] = $order->id;
                $itemData['created_at'] = now();
                $itemData['updated_at'] = now();
                return $itemData;
            }, $orderItemsData);

            OrderItem::insert($finalOrderItems);

            DB::commit();

            return response()->json([
                'status'  => true,
                'message' => 'تم تسجيل طلبك بنجاح! رقم الطلب: #' . $order->id
            ], 201);

        } catch (Exception $e) {
            DB::rollBack();

            return response()->json([
                'status'  => false,
                'message' => 'فشل في إتمام الطلب، جرب مجدداً',
                'error'   => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }
}