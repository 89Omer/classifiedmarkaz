<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPostAlert extends Model
{
    //
    protected $table = 'user_post_alert';

    protected $fillable = ['image','post_id'];

    public function post_alert()
    {
        return $this->belongsTo('App\Models\UserPost');
    }
}
