<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    //

    public function country()
    {
        return $this->belongsTo('App\Models\City','city_id');
    }


    
    public function city()
    {
        return $this->hasMany('App\Models\City','city_id');
    }


    
    public function currency()
    {
        return $this->hasOne('App\Models\Currency','currency_id');
    }
}
