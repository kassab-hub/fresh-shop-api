<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\OrderController;
use App\Http\Controllers\API\CategoryController;
use App\Http\Controllers\Api\AuthController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


Route::get('/products', [ProductController::class, 'index']);
Route::post('/checkout', [OrderController::class, 'checkout']);
Route::get('/categories', [CategoryController::class, 'index']);

// مسارات الحسابات والهوية للويب وفلاتر
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);