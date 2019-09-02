<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPostAttribute extends Model
{
    protected $table = 'user_post_attribute';

    protected $fillable = ['post_attribute','user_post_id'];

    protected $casts = [
        'post_attribute' => 'array',
    ];

    //
    public function post_attribute()
    {
        return $this->belongsToMany('App\Models\UserPost');
    }
}
