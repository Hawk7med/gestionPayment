<?php

use Illuminate\Support\Facades\Route;
Route::get('/a', function () {
    return 'Hello World';
});

Route::get('/', function () {
    return view('welcome');
});
