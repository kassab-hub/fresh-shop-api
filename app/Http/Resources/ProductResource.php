<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * تحويل المنتج إلى مصفوفة آمنة ومطابقة لـ فلاتر
     */
    public function toArray(Request $request): array
    {
        return [
            'id'       => $this->id,
            'name'     => $this->name,
            'image'    => $this->image,
            'price'    => $this->price,
            'unit'     => $this->unit,
            // 🎯 جلب اسم التصنيف بأمان وبأعلى كفاءة
            'category' => $this->relationLoaded('category') && $this->category 
                            ? $this->category->name 
                            : 'عام',
        ];
    }
}