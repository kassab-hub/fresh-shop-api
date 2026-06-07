<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            
            // 🎯 السطر المضاف: ربط الطلب بالمستخدم وجعله nullable 
            // (في حال رغبت مستقبلاً بالسماح بالشراء للزوار بدون تسجيل)
            $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('cascade');
            
            $table->decimal('total_price', 8, 2);
            $table->string('status')->default('pending'); // حالة الطلب: قيد الانتظار، تم التوصيل...
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};