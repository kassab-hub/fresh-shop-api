<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Http\Resources\ProductResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Exception;

class ProductController extends Controller
{
    /**
     * جلب المنتجات بشكل آمن ومنظم مع تصنيفاتها لتطبيق فلاتر وللموقع (تدعم الفلترة بالقسم والبحث)
     */
    public function index(Request $request): JsonResponse
    {
        try {
            // 1. بدء بناء الاستعلام مع الحقول المطلوبة فقط
            $query = Product::select(['id', 'name', 'image', 'price', 'unit', 'category_id'])
                ->with(['category' => function($query) {
                    $query->select(['id', 'name']);
                }]);

            // 2. الفلترة بالقسم: إذا أرسل العميل اسم القسم
            if ($request->has('category') && $request->category != null) {
                $query->whereHas('category', function($q) use ($request) {
                    $q->where('name', $request->category);
                });
            }

            // 🎯 3. إضافة منطق البحث النصي: إذا كتب المستخدم نصاً في حقل البحث
            if ($request->filled('search')) {
                $query->where(function($q) use ($request) {
                    $q->where('name', 'like', '%' . $request->search . '%')
                      ->orWhere('unit', 'like', '%' . $request->search . '%'); // يمكنك إضافة أوصاف أخرى هنا
                });
            }

            // 4. تطبيق الترتيب التنازلي والـ Pagination (10 منتجات في الصفحة)
            $products = $query->latest()->paginate(10);

            // 5. هيكلة الرد الموحد
            return response()->json([
                'status'  => true,
                'message' => 'تم جلب المنتجات بنجاح',
                'data'    => ProductResource::collection($products->items()), 
                'meta'    => [
                    'current_page' => $products->currentPage(),
                    'last_page'    => $products->lastPage(),
                    'has_more'     => $products->hasMorePages(),
                ]
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'status'  => false,
                'message' => 'حدث خطأ غير متوقع في السيرفر',
                'error'   => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }
}