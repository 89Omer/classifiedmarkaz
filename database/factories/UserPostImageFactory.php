<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Model;
use App\Models\UserPostImage;
use Carbon\Carbon;
use Faker\Generator as Faker;

$factory->define(UserPostImage::class, function (Faker $faker) {
    return [
        'image' => base64_encode($faker->image('public/storage/user_posts',640,480, null, false)),
        'created_at' => Carbon::now(),
        'updated_at' => Carbon::now(),
        //
    ];
});
