<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MessageThreadData extends Model
{
    //
    protected $table = 'messages_threads_data';

    protected $fillable = ['message_id','thread_id','sender_id','reciever_id','post_id'];
}
