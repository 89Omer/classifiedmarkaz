<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserOTP extends Model
{
    //
    protected $table = 'user_otp';
    
    protected $fillable = [
        'mobile_number', 'verification_code'
        ];
}
