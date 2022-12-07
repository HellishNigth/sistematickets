<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ticket_evento', function (Blueprint $table) {
             $table->unsignedInteger('ticket_id');
             $table->unsignedInteger('evento_id');
             $table->primary(['ticket_id','evento_id']);
            
             $table->integer('cantidadTickets');
             $table->integer('totalTickets');
             
             $table->foreign('ticket_id')->references('id')->on('tickets');
             $table->foreign('evento_id')->references('id')->on('eventos');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ticket_evento');
    }
};
