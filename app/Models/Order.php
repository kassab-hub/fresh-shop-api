<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = ['total_price', 'status'];

    // علاقة الطلب مع عناصره (الطلب الواحد يحتوي على عدة عناصر)
    public function items() {
        return $this->hasMany(OrderItem::class);
    }
}
