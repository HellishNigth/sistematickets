<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\Evento;
use Illuminate\Http\Request;
use App\Http\Requests\TicketsRequest;
use App\Models\Cliente;

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
        return $ticket;
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

    public function ticketsPorCliente(Cliente $cliente){

        $ticket = Ticket::select('tickets.id', 'eventos.nombreEve')->join('ticket_evento', 'ticket_evento.ticket_id', '=', 'tickets.id')->join('eventos', 'ticket_evento.evento_id', '=', 'eventos.id')->where('cliente_id', '=', $cliente->email)->get();
        return $ticket;
    }

    public function detalleTickets(Ticket $ticket){
        $detalleTickets = Ticket::select('tickets.id', 'eventos.nombreEve', 'nombreCliente', 'rutCliente', 'eventos.ubicacionEve', 'eventos.detalleEve', 'eventos.fechaEve', 'ticket_evento.totalTickets', )->join('ticket_evento', 'ticket_evento.ticket_id', '=', 'tickets.id')->join('eventos', 'ticket_evento.evento_id', '=', 'eventos.id')->where('tickets.id', '=', $ticket->id)->get();
        return $detalleTickets;
    }

    public function crearPivot(Evento $evento, Ticket $ticket){
        $eventoId = $evento->id.value('id');
        $eventoSelect = Evento::findOrFail($eventoId);
        $CantidadTicket = 1;
    

        $eventoSelect->tickets()->syncWithoutDetaching([$ticket->id =>['totalTickets'=>$evento->precioEve]]);
        
        return $ticket->id;
    }
}
