<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class City extends Model
{
    //

    public function country()
    {
        return $this->hasOne('App\Models\Country','country_id');
    }


    public function city()
    {
        return $this->belongsTo('App\Models\Country','city_id');
    }

    
}
