<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });
/**
 * Api Routes start from here
 */
Route::prefix('v1')->group(function(){
    Route::post('login', 'Api\AuthController@login');
    Route::post('register', 'Api\AuthController@register');
    Route::post('user/otp', 'Api\AuthController@sendOtp');
    Route::get('user/verify/otp', 'Api\AuthController@verifyOtp');
    //All middleware routes start from here
    Route::group(['middleware' => 'auth:api'], function(){
        Route::resource('user', 'UserController')->only([
            'index', 'show'
        ]);
        Route::post('getUser', 'Api\AuthController@getUser');
    });
});
