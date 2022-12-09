<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Evento extends Model
{
    use HasFactory,SoftDeletes;
    protected $table = 'eventos';
    public $timestamps = false;
    protected $fillable = ['cantidadTicket'];

    public function tickets(){
        return $this->belongsToMany('App\Models\Ticket');
    }

    public function ticketsConPivot(){
        return $this->belongsToMany(Ticket::class,'evento_ticket','ticket_id','evento_id')->withPivot('cantidadTickets','totalTickets');
    }

    public function ticket_evento(){
        return $this->hasMany(Ticket::class, 'evento_id');
    }
}
