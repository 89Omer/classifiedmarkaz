<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Model;
use App\Models\UserPostAttribute;
use Carbon\Carbon;
use Faker\Generator as Faker;

$factory->define(UserPostAttribute::class, function (Faker $faker) {
    $faker->addProvider(new \Bezhanov\Faker\Provider\Device($faker));
    return [
        'post_attribute' => json_encode([
            "key1" => $faker->deviceBuildNumber(), // 186
            "key2" => $faker->deviceManufacturer(),
            "key3" => $faker->deviceModelName(),
            "key4" => $faker->deviceSerialNumber(),
            "key5" => $faker->deviceVersion()
        ]),
        'created_at' => Carbon::now(),
        'updated_at' => Carbon::now(),
    ];
});
