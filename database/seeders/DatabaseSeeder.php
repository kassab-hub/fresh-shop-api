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
        // 1. تنظيف الجداول أولاً لتجنب تكرار البيانات أو أخطاء القيود (اختياري)
        // DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        // Product::truncate();
        // Category::truncate();
        // DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // 2. إنشاء التصنيفات الأساسية أولاً (إذا لم تكن موجودة)
        $categories = ['خضروات', 'فواكه', 'ورقيات'];
        
        foreach ($categories as $categoryName) {
            Category::firstOrCreate(['name' => $categoryName]);
        }

        // 3. 🎯 الأمر السحري: توليد 50 منتج وهمي وتوزيعهم على التصنيفات تلقائياً
        Product::factory()->count(50)->create();
    }
}