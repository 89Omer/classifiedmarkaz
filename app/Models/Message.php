<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    //
    protected $fillable = ['seller_id','buyer_id','post_id','message_text','category_id'];

    protected $table = 'messages';

}
