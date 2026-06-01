<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product; // 🎯 استيراد موديل المنتج للتحقق من الأسعار الحقيقية
use Illuminate\Support\Facades\DB;
use Illuminate\Http\JsonResponse;
use Exception;

class OrderController extends Controller
{
    public function checkout(Request $request): JsonResponse
    {
        // 1. التحقق من الهيكل فقط (قمنا بإزالة حقل السعر لأنه سيؤخذ من السيرفر حصراً)
        $request->validate([
            'total_price'        => 'required|numeric',
            'items'              => 'required|array',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity'   => 'required|integer|min:1',
        ]);

        DB::beginTransaction();

        try {
            $calculatedTotalPrice = 0; // متغير لحساب الإجمالي الفعلي بالسيرفر
            $orderItemsData = []; // مصفوفة مؤقتة لتجهيز العناصر قبل حفظها

            // 2. التحقق من الأسعار الحقيقية من قاعدة البيانات
            foreach ($request->items as $item) {
                // جلب المنتج من قاعدة البيانات لقراءة سعره الأصلي الحقيقي
                $product = Product::find($item['product_id']);
                
                $dbPrice = $product->price;
                $quantity = $item['quantity'];
                $itemSubtotal = $dbPrice * $quantity;

                // إضافة السعر الإجمالي لهذا العنصر للإجمالي الكلي للسيرفر
                $calculatedTotalPrice += $itemSubtotal;

                // تجهيز بيانات العنصر للحفظ بالسعر الحقيقي من الـ Database
                $orderItemsData[] = [
                    'product_id' => $item['product_id'],
                    'quantity'   => $quantity,
                    'price'      => $dbPrice, // 🎯 السعر الآمن من السيرفر وليس من فلاتر
                ];
            }

            // 3. حماية إضافية: مقارنة الحسابات (مع التغاضي عن فروق الكسور الطفيفة)
            if (abs($calculatedTotalPrice - $request->total_price) > 0.01) {
                return response()->json([
                    'status'  => false,
                    'message' => 'عذراً، حدث خطأ في احتساب إجمالي الطلب، يرجى تحديث السلة.'
                ], 400);
            }

            // 4. حفظ الطلب الرئيسي بالإجمالي المحسوب بأمان
            $order = Order::create([
                'total_price' => $calculatedTotalPrice,
                'status'      => 'pending',
            ]);

            // 5. حفظ عناصر السلة
            foreach ($orderItemsData as $itemData) {
                $itemData['order_id'] = $order->id; // ربط العنصر برقم الطلب
                OrderItem::create($itemData);
            }

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