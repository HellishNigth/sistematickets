<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ClientesController;
use App\Http\Controllers\EventosController;
use App\Http\Controllers\TicketsController;


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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('/clientes',ClientesController::class);
Route::apiResource('/eventos',EventosController::class);
Route::apiResource('/tickets',TicketsController::class);

Route::get('/tickets/{cliente}/cliente', [TicketsController::class, 'ticketsPorCliente']);

Route::get('/tickets/{ticket}/detalle', [TicketsController::class, 'detalleTickets']);

Route::put('/eventos/{evento}/estado',[EventosController::class, 'editarEstado']);

Route::post('/clientes/rol/{cliente}', [ClientesController::class, 'verRol']);