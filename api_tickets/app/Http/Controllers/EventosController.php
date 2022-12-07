<?php

namespace App\Http\Controllers;

use App\Models\Evento;
use Illuminate\Http\Request;
use App\Http\Requests\EventosRequest;

class EventosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Evento::all();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(EventosRequest $request)
    {
        $evento = new Evento();
        $evento->nombreEve = $request->nombreEve;
        $evento->detalleEve = $request->detalleEve;
        $evento->ubicacionEve = $request->ubicacionEve;
        $evento->precioEve = $request->precioEve;
        $evento->cantidadTicket = $request->cantidadTicket;
        $evento->estado = $request->estado;
        $evento->fechaEve = $request->fechaEve;
        $evento->save();
        return $evento;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
    public function show(Evento $evento)
    {
        return $evento->makeVisible(['ticketsConPivot']);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Evento $evento)
    {
        $evento->nombreEve = $request->nombreEve;
        $evento->detalleEve = $request->detalleEve;
        $evento->ubicacionEve = $request->ubicacionEve;
        $evento->precioEve = $request->precioEve;
        $evento->cantidadTicket = $request->cantidadTicket;
        $evento->estado = $request->estado;
        $evento->fechaEve = $request->fechaEve;
        $evento->save();
        return $evento;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Evento  $evento
     * @return \Illuminate\Http\Response
     */
    public function destroy(Evento $evento)
    {
        $evento->delete();
    }

    public function editarEstado(Request $request, Evento $evento){
        $evento->estado = $request->estado;
        $evento->save();
        return $evento;
    }
}
