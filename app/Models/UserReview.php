<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserReview extends Model
{
    //
    protected $table = 'user_reviews';
    protected $fillable = ['given_to','given_by','rating','review'];
}
