<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Model;
use Faker\Generator as Faker;
use Faker\Factory;
use App\Models\UserPost;
use Illuminate\Support\Carbon;

//$faker = Faker\Factory::create('en_US');


$factory->define(UserPost::class, function (Faker $faker) {
    return [
        'user_account_id'=>17,
        'post_type' => 'classified',
        'category_id' => 1,
        'sub_category_id' => 2,
        'post_title' => $faker->title,
        'post_detail' => $faker->realText($maxNbChars = 200, $indexSize = 2),
        'is_active'=>0,
        'created_at' => Carbon::now(),
        'updated_at' => Carbon::now(),
        //
    ];
});
