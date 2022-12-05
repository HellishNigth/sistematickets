<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ClientesRequest extends FormRequest
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
            'rutClie'=>['unique:clientes,rutClie','required'],
            'nombreClie'=>'required',
            'apellidoClie'=>'required',
            'email'=>'required'
        ];
    }

    public function messages(){
        return [
            'rutClie.required'=>'El rut del comprador es necesario.',
            'rutClie.unique'=>'El rut ya esta registrado en la base de datos.',
            'nombreClie.required'=>'El nombre del comprador es necesario.',
            'apellidoClie.required'=>'El apellido del comprador es necesario.',
            'email.required'=>'El correo del comprador es necesario'

        ];
    }

}
