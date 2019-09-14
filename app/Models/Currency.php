<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    //

    public function currency()
    {
        return $this->belongsTo('App\Models\Country','currency_id');
    }
}
