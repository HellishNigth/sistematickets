<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EventosRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'nombreEve'=>['unique:eventos,nombreEve','required'],
            'detalleEve'=>'required',
            'ubicacionEve'=>'required',
            'precioEve'=>'required|gte:1',
            'cantidadTicket'=>'required|gte:1',
            'estado'=>'required',
            'fechaEve'=>'required|date'
        ];
    }

    public function messages(){
        return [
            'nombreEve.required'=>'El nombre del evento es necesario.',
            'nombreEve.unique'=>'El evento ya esta registrado en la base de datos.',
            'detalleEve.required'=>'El detalle del evento es necesario.',
            'ubicacionEve.required'=>'La ubicacion del evento es necesaria.',
            'precioEve.required'=>'El precio del evento es necesario.',
            'precioEve.gte'=>'El precio debe ser mayor a 0.',
            'cantidadTicket.required'=>'La cantidad de tickets del evento son necesario.',
            'cantidadTicket.gte'=>'La cantidad de tickets debe ser mayor a 0.',
            'estado.required'=>'El estado del evento es necesario.',
            'fechaEve.required'=>'Fecha del evento es necesario'

        ];
    }
}
