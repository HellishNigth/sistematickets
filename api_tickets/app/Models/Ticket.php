<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Ticket extends Model
{
    use HasFactory,SoftDeletes;
    protected $table = 'tickets';

    public function cliente(){
        return $this->belongsTo(Cliente::class);
    }

    public function eventos(){
        return $this->belongsToMany('App\Models\Evento');
    }
}
