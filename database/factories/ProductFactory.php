<?php

namespace Database\Factories;

use App\Models\Product;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductFactory extends Factory
{
    protected $model = Product::class;

    public function definition(): array
    {
        // قوائم لتوليد أسماء منتجات متنوعة جداً وغير مكررة
        $items = ['تفاح', 'موز', 'برتقال', 'فراولة', 'مانجو', 'عنب', 'بندورة', 'خيار', 'بطاطا', 'بصل', 'ثوم', 'بروكلي', 'خس', 'نعنع', 'بقدونس', 'ليمون', 'جزر', 'أفوكادو', 'رمان', 'بطيخ'];
        $types = ['بلدي', 'مستورد', 'طازج', 'عضوي (Organic)', 'نخب أول', 'حقلي', 'صيفي', 'شتوي'];
        
        $units = ['1 كيلو', '500 غرام', 'صندوق', 'سلة', 'ضمة'];
        
        // توليد اسم فريد مثل: "تفاح عضوي (Organic) رقم 42"
        $productName = $this->faker->randomElement($items) . ' ' . $this->faker->randomElement($types) . ' #' . $this->faker->unique()->numberBetween(1, 1000);

        return [
            'name'        => $productName,
            'image'       => 'apple.png', // يمكنك تغييرها لاحقاً بروابط صور حقيقية
            'price'       => $this->faker->randomFloat(2, 0.40, 6.50), // أسعار تتراوح بين 40 قرش و 6.5 دنانير
            'unit'        => $this->faker->randomElement($units),
            'category_id' => Category::inRandomOrder()->first()?->id ?? 1,
        ];
    }
}