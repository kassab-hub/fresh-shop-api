<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    // 🎯 تحديث الحقول المسموح بحفظها لتشمل user_id
    protected $fillable = ['user_id', 'total_price', 'status'];

    // 1. علاقة الطلب مع عناصره (الطلب الواحد يحتوي على عدة عناصر)
    public function items() {
        return $this->hasMany(OrderItem::class);
    }

    // 2. العلاقة العكسية: الطلب ينتمي إلى مستخدم محدد (User)
    public function user() {
        return $this->belongsTo(User::class);
    }
}