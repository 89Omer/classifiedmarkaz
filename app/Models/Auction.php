<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Auction extends Model
{
    //
    protected $fillable = ['user_post_id','auction_item_actual_selling_price','status'];
}
