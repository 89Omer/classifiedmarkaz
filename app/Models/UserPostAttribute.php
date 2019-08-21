<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPostAttribute extends Model
{
    protected $table = 'user_post_attribute';

    protected $fillable = ['post_attribute','post_id'];

    //
    public function post_attribute()
    {
        return $this->belongsTo('App\Models\UserPost');
    }
}
