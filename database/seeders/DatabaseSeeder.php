<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Product;

class DatabaseSeeder extends Seeder
{
    /**
     * تشغيل بذور قاعدة البيانات (Seed the application's database).
     */
    public function run(): void
    {
        // 1. أنشئ الأقسام أولاً
        Category::factory(5)->create();

        // 2. أنشئ المنتجات ثانياً
        Product::factory(50)->create();
    }
    
}