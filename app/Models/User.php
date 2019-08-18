<?php

namespace App\Models;
use Laravel\Passport\HasApiTokens;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Auth\Authenticatable as AuthenticableTrait;
use UserPost;

class User extends \TCG\Voyager\Models\User implements Authenticatable
{
    //
    use HasApiTokens, Notifiable , AuthenticableTrait;

    //Adding custom guard for apis
    protected $guard = 'apiusers';

    /**
* The attributes that are mass assignable.
*
* @var array
*/
protected $fillable = [
    'name', 'email', 'password','mobile_number'
    ];
    /**
    * The attributes that should be hidden for arrays.
    *
    * @var array
    */
    protected $hidden = [
    'password', 'remember_token',
    ];
    
    /**
     * 
     * Adding user relations
     * 
     */

    public function posts()
    {
      return $this->hasMany(UserPost::class);
    }
}
