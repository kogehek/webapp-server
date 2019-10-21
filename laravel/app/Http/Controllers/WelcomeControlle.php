<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class WelcomeControlle extends Controller
{
    public function index()
    {
        return view('welcome');
    }
}
