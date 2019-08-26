<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPost extends Model
{
    //
    /**
     * The posts that belongs to user
     * 
     */
    public function user()
    {
      return $this->belongsTo(User::class);
    }

    /**
     * The post details relations
     * 
     */
    public function post_alert()
    {
        return $this->hasMany('App\Models\UserPostAlert');
    }
    public function post_attribute()
    {
        return $this->hasMany('App\Models\UserPostAttribute');
    }
    public function post_image()
    {
        return $this->hasMany('App\Models\UserPostImage');
    }
    public function post_view()
    {
        return $this->hasMany('App\Models\UserPostView');
    }
}
