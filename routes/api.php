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
    
    //Guest Routes
    Route::get('search', 'Api\SearchController@home');

    //All middleware routes start from here
    Route::group(['middleware' => 'auth:api'], function(){
        Route::post('logout', 'Api\AuthController@logout');
        Route::post('user/edit', 'Api\AuthController@edit');
        //Post AD Routes
        Route::apiResource('user/post', 'Api\UserPostController');
        //User Search Routes
        Route::get('user/search', 'Api\SearchController@index');
        Route::get('user/search/history', 'Api\SearchController@view');
        //User Messages
        Route::post('user/message/compose', 'Api\MessageController@store');
        //User Point System
        Route::apiResource('user/point', 'Api\UserLoyaltyPointController');
        //User Submit on Ads
        Route::post('user/post/action', 'Api\UserPostController@submit');
        Route::get('user/review', 'Api\UserPostController@myRating');
        Route::get('user/favourite', 'Api\UserPostController@myFavourite');
        //User Payment Routes
        Route::get('user/payment', 'Api\UserPostController@myTransactions');
        Route::post('user/post/payme', 'Api\UserPostController@postPayment');


        Route::post('getUser', 'Api\AuthController@getUser');
    });
});
