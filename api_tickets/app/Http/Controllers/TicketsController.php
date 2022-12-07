<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\Evento;
use Illuminate\Http\Request;
use App\Http\Requests\TicketsRequest;

class TicketsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tickets = Ticket::orderBy('fechaEve')->get();
        $eventos = Evento::orderBy('nombreEve')->get();
        $clientes = Cliente::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(TicketsRequest $request)
    {
        $ticket = new Ticket();
        $precioTicket = 0;
        $cantidad = 0;
        $evento = Evento::findOrFail($request->evento);
        $ticket->nombreCliente = $request->nombreCliente;
        $ticket->rutCliente = $request->rutCliente;
        $ticket->evento_id = $request->evento;
        $ticket->cliente_id = $request->cliente;
        $ticket->fechaEve = $request->fechaEve;
        $ticket->cantidad = $request->cantidad;
        $precioTicket += $request->cantidad * $evento->precioEve;
        
        $ticket->precioTicket = $precioTicket;
        $ticket->save();
        $venta->eventos()->attach($request->evento);
        $venta->eventos()->sync($request->evento);
        $evento = Evento::findOrFail($request->evento);
        $cantidadVendida = $evento->cantidadTicket - $request->cantidad;
        $evento->update(["cantidadTicket" => $cantidadVendida]);
        return $ticket;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function show(Ticket $ticket)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Ticket $ticket)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Ticket  $ticket
     * @return \Illuminate\Http\Response
     */
    public function destroy(Ticket $ticket)
    {
        $ticket->delete();
    }
}
