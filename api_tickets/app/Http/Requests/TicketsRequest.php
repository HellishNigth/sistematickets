<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class TicketsRequest extends FormRequest
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
            'nombreCliente'=>'required',
            'rutCliente'=>'required',
            'evento'=>'required',
            'cliente'=>'required',
            'fechaEve'=>'required|date',
            'cantidad'=>'required|gte:1'
        ];
    }
    public function messages()
    {
        return [
            'nombreCliente.required'=>'Se requiere nombre de cliente',
            'rutCliente.required'=>'Se requiere rut de cliente',
            'evento.required'=>'Se requiere evento para el ticket',
            'cliente.required'=>'Seleccione email del cliente',
            'fechaEve.required'=>'Se requiere fecha',
            'cantidad.required'=>'Se requiere cantidad de entradas',
            'cantidad.gte'=>'La cantidad debe ser mayor que 0'
        ];
    }
}
