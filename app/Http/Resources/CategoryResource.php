<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CategoryResource extends JsonResource
{
    /**
     * تحويل الـ Model إلى مصفوفة تناسب الـ API.
     */
    public function toArray(Request $request): array
    {
        return [
            'id'   => $this->id,
            'name' => $this->name,
            // يمكنك إضافة count للمنتجات التابعة للقسم مستقبلاً هنا إن أردت
        ];
    }
}