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
        Schema::create('tickets', function (Blueprint $table) {
            $table->unsignedInteger('id')->autoIncrement();
            $table->string('nombreCliente',50);
            $table->string('rutCliente',20);
            $table->string('cliente_id');
            $table->integer('precioTicket');
            $table->integer('cantidad');
            $table->dateTime('fechaEve');
            $table->softDeletes();

            $table->foreign('cliente_id')->references('email')->on('clientes');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tickets');
    }
};
