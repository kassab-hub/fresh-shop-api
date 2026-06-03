<?php

namespace Database\Factories;

use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Category>
 */
class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $categories = ['خضار طازجة', 'فواكه موسمية', 'ورقيات', 'تمور ومجففات', 'عروض مميزة'];

        return [
            'name' => $this->faker->unique()->randomElement($categories),
            // 'image' => $this->faker->imageUrl(), // أضف حقل الصورة هنا إذا كان جدول الأقسام يحتوي على صور
        ];
    }
}
