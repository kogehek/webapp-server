<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Requests\Api\Auth\RegisterFormRequest;
use App\Notifications\SignupActivate;
use App\Http\Controllers\Controller;
use Illuminate\Support\Str;
use App\User;

class RegisterController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */

    public function __invoke(RegisterFormRequest $request)
    {
        $user = User::create(array_merge(
            $request->only('name', 'email'),
            ['password' => bcrypt($request->password)],
            ['activation_token' => Str::random(60)]
        ));

        $user->notify(new SignupActivate());

        return response()->json([
            'message' => 'Please check email for activation account.',
        ], 200);
    }
}
