<?php

namespace Tests\Unit;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Tests\TestCase;
use App\User;

class AuthTest extends TestCase
{
    /** @test */
    public function registerTest()
    {
        $response = $this->json('POST', '/api/auth/register', [
            'email' => 'Register@mail.com',
            'name' => 'User',
            'password' => '123456',
            'password_confirmation' => '123456',
        ]);

        $response->assertStatus(200);
    }

    /** @test */
    public function activateTest()
    {
        $activation_token = Str::random(60);

        User::create(array_merge(
            ['email' => 'activate@mail.com'],
            ['name' => 'Activate'],
            ['password' => bcrypt(123456)],
            ['activation_token' => $activation_token]
        ));

        $url = route('auth.activate', ['token' => $activation_token]);
        $response = $this->json('GET', $url);
        $this->assertTrue(Auth::attempt(['email' => 'activate@mail.com', 'password' => 123456, 'active' => 1]));
        $response->assertStatus(200);
    }

    /** @test */
    public function loginTest()
    {
        User::create(array_merge(
            ['email' => 'login@mail.com'],
            ['name' => 'Login'],
            ['password' => bcrypt(123456)],
            ['activation_token' => ''],
            ['active' => true]
        ));

        $response = $this->json('POST', '/api/auth/login', [
            'email' => 'login@mail.com',
            'password' => '123456',
        ]);

        $response->assertStatus(200);
    }

    /** @test */
    public function logoutTest()
    {
        User::create(array_merge(
            ['email' => 'Logout@mail.com'],
            ['name' => 'Login'],
            ['password' => bcrypt(123456)],
            ['activation_token' => ''],
            ['active' => true]
        ));

        $response = $this->json('POST', '/api/auth/login', [
            'email' => 'Logout@mail.com',
            'password' => '123456',
        ]);

        $response = json_decode($response->getContent());
        $header = [
            'Authorization' => $response->token_type.' '.$response->token
        ];

        $res = $this->post('/api/auth/logout', [], $header);
        $res->assertStatus(200);
    }
}
