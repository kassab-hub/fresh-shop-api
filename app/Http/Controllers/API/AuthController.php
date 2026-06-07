<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // 1. API تسجيل حساب جديد
    public function register(Request $request)
    {
        // التحقق من البيانات القادمة للـ API
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
            'phone' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'فشل في التحقق من البيانات',
                'errors' => $validator->errors()
            ], 422);
        }

        // إنشاء المستخدم وتشفير كلمة المرور بـ Hash
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'password' => Hash::make($request->password),
        ]);

        // توليد توكن بسيط للمستخدم (يمكنك استخدام Sanctum لاحقاً إذا قمت بتثبيته)
        // حالياً سنرجع التوكن كقيمة عشوائية مشفرة أو نصية لتشغيل الدورة الأساسية
        $token = bin2hex(random_bytes(32)); 

        return response()->json([
            'status' => true,
            'message' => 'تم إنشاء الحساب بنجاح في MySQL 🎉',
            'token' => $token,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'phone' => $user->phone
            ]
        ], 201);
    }

    // 2. API تسجيل الدخول
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'الحقول المطلوبة غير مكتملة',
                'errors' => $validator->errors()
            ], 422);
        }

        // البحث عن المستخدم بالإيميل
        $user = User::where('email', $request->email)->first();

        // التحقق من وجود المستخدم وصحة كلمة المرور المشفرة
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'status' => false,
                'message' => '❌ عذراً، البريد الإلكتروني أو كلمة المرور غير صحيحة'
            ], 401);
        }

        // توليد توكن دخول للجلسة الحالية
        $token = bin2hex(random_bytes(32));

        return response()->json([
            'status' => true,
            'message' => 'تم تسجيل الدخول بنجاح 👋',
            'token' => $token,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email
            ]
        ], 200);
    }
}