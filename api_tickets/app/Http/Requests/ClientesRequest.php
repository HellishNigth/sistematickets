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
            'email'=>['unique:clientes,email','required']
        ];
    }

    public function messages(){
        return [
            'email.required'=>'El correo del comprador es necesario.',
            'email.unique'=>'El correo ya esta registrado en la base de datos.'
        ];
    }

}
