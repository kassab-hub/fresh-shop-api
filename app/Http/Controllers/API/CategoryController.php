<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Http\Resources\CategoryResource; // 🎯 استيراد الـ Resource الجديد
use Illuminate\Http\JsonResponse;
use Exception;

class CategoryController extends Controller
{
    /**
     * جلب الأقسام بشكل آمن ومنظم مع خاصية الـ Pagination لتطبيق فلاتر
     */
    public function index(): JsonResponse
    {
        try {
            // 1. جلب البيانات بكفاءة عالية (تحديد الحقول المطلوبة فقط لتقليل استهلاك الذاكرة)
            $categories = Category::select(['id', 'name'])
                ->latest()
                ->paginate(10); // قمنا بعمل Pagination لتطابق أسلوب المنتجات وتدعم القوائم الطويلة

            // 2. هيكلة الرد الموحد باستخدام الـ Resource دون كسر الـ Pagination
            return response()->json([
                'status'  => true,
                'message' => 'تم جلب الأقسام بنجاح',
                // 🎯 تحويل مصفوفة الأقسام داخل الـ Paginator بأمان دون نسخ الذاكرة
                'data'    => CategoryResource::collection($categories->items()), 
                'meta'    => [
                    'current_page' => $categories->currentPage(),
                    'last_page'    => $categories->lastPage(),
                    'has_more'     => $categories->hasMorePages(),
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