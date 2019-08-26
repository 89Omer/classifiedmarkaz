<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserLatestSearch extends Model
{
    //
    protected $table = 'user_latest_searches';

    protected $fillable = ['user_account_id','search_value'];
}
