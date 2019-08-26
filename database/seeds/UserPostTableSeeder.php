<?php

use App\Models\UserPost;
use Illuminate\Database\Seeder;

class UserPostTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $count = 5;
        factory(UserPost::class, $count)->create()->each(function ($attributes) {
            $attributes->post_attribute()->save(factory(App\Models\UserPostAttribute::class)->make());
            $attributes->post_image()->save(factory(App\Models\UserPostImage::class)->make());
        });
        
//         $person = Person::create($personData);
// $person->employee()->create($employeeData);
    }
}
