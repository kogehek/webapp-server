<?php

namespace App\Http\Controllers\Api\auth;

use App\Http\Controllers\Controller;
use App\User;

class ActivateController extends Controller
{
    public function __invoke($token)
    {
        $user = User::where('activation_token', $token)->first();
        if (!$user) {
            return response()->json([
                'message' => 'This email activation token is invalid.'
            ], 404);
        } else {
            $user->active = true;
            $user->activation_token = '';
            $user->save();
            return response()->json([
                'message' => 'Successfully activated by email.'
            ], 200);
        }

    }
}
