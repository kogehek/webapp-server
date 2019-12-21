<?php


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

Route::group(['namespace' => 'Api'], function() {
    Route::group(['namespace' => 'Auth', 'prefix' => 'auth', 'name' => 'et'], function() {

        Route::post('register', 'RegisterController');
        Route::post('login', 'LoginController');
        Route::get('activate/{token}', 'ActivateController')->name('auth.activate');

        Route::group([
            'middleware' => 'auth:api',
        ], function() {
            Route::post('logout', 'LogoutController');
        });

    });
});
