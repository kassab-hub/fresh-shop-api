<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('image');
            $table->decimal('price', 8, 2);
            $table->string('unit');
            
            // 🎯 إضافة حقل الربط مع جدول التصنيفات
            $table->foreignId('category_id')
                ->nullable()
                ->constrained('categories')
                ->onDelete('set null'); // إذا حُذف القسم، لا تحذف المنتج بل يرجع قيمته null أو عام
                
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
