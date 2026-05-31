<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Product;

class ProductController extends Controller
{
    public function index()
    {
        // جلب جميع المنتجات من قاعدة بيانات MySQL
        $products = Product::all();
        
        // إرسالها لتطبيق فلاتر كـ JSON مع كود الحالة 200 (ناجح)
        return response()->json($products, 200);
    }
}
