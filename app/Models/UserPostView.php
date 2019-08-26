<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPostView extends Model
{
    //
    protected $table = 'user_post_view';
    protected $fillable = ['user_post_id','is_favourite','review','rating','given_by'];

    //
    public function post_view()
    {
        return $this->belongsTo('App\Models\UserPost');
    }

}
