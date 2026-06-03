<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ImageController extends Controller
{

public function uploadImage(Request $request) 
{
    // 1. التحقق من الملف
    $request->validate([
        'image' => 'required|image|mimes:jpeg,png,jpg,webp|max:2048', // حد أقصى 2 ميجا
    ]);

    if ($request->hasFile('image')) {
        $file = $request->file('image');
        
        // 2. توليد اسم فريد للصورة لمنع التكرار
        $fileName = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
        
        // 3. حفظ الصورة في مجلد public/uploads داخل السيرفر
        $path = $file->storeAs('uploads', $fileName, 'public');

        // 4. حفظ $path في قاعدة البيانات (مثال: uploads/filename.jpg)
        // $user->update(['avatar' => $path]);

        // 5. إرجاع الرابط الكامل لتطبيق Flutter والموقع
        return response()->json([
            'success' => true,
            'image_url' => asset('storage/' . $path) // سيولد رابط مثل: https://api.yourdomain.com/storage/uploads/filename.jpg
        ]);
    }
}

}
