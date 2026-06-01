<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{ // 👍 القوس يجب أن يُفتح هنا أولاً
    use HasFactory; // 🎯 الـ use مكانها الصحيح داخل الكلاس هنا

    // تحديد اسم الجدول في قاعدة البيانات
    protected $table = 'categories';

    // الأعمدة المسموح تعبئتها
    protected $fillable = ['name'];

    /**
     * العلاقة العكسية: القسم الواحد يحتوي على العديد من المنتجات
     */
    public function products()
    {
        return $this->hasMany(Product::class, 'category_id');
    }
}