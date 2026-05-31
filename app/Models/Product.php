<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    // ⬇️ أضف هذا السطر هنا لتفعيل الحقول المسموحة ⬇️
    protected $fillable = ['name', 'image', 'price', 'unit'];
}