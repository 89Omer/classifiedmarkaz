<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPostImage extends Model
{
    //
    protected $table = 'user_post_image';

    protected $fillable = ['image','post_id'];

    public function post_image()
    {
        return $this->belongsTo('App\Models\UserPost');
    }
}
