<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Http\Resources\ProductResource; // 🎯 استيراد الـ Resource الجديد
use Illuminate\Http\JsonResponse;
use Exception;

class ProductController extends Controller
{
    /**
     * جلب المنتجات بشكل آمن ومنظم مع تصنيفاتها لتطبيق فلاتر
     */
    public function index(): JsonResponse
    {
        try {
            // 1. جلب البيانات مع العلاقات بكفاءة عالية
            $products = Product::select(['id', 'name', 'image', 'price', 'unit', 'category_id'])
                ->with(['category' => function($query) {
                    $query->select(['id', 'name']);
                }])
                ->latest()
                ->paginate(10);

            // 2. هيكلة الرد الموحد باستخدام الـ Resource دون كسر الـ Pagination
            return response()->json([
                'status'  => true,
                'message' => 'تم جلب المنتجات بنجاح',
                // 🎯 تحويل مصفوفة المنتجات داخل الـ Paginator بأمان دون نسخ الذاكرة
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