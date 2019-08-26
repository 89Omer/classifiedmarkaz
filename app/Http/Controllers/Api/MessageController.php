<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Message;
use App\Models\MessageThread;
use App\Models\MessageThreadData;
use App\Models\UserPost;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class MessageController extends Controller
{
    /**
     * Display a listing of the resource.
     * 
     * @return \Illuminate\Http\Response
     */   
     public function index(){

    }
    /**
     * @param  \Illuminate\Http\Request  $request
     * 
     */
    public function store(Request $request){
        $query = UserPost::select('user_account_id')
        ->where('id',$request->post_id)->first();
        try {
            //New Message save
            $message = new Message();
            $message->message_text = $request->message;
            $message->save();

            
            //Pivot table save
            $bridge_data = new MessageThreadData();
            $bridge_data->message_id = $message->id;
            $bridge_data->post_id = $request->post_id;
        
            //Find for postid in message
            if($request->message_id){
                $is_thread = MessageThreadData::where('message_id',$request->message_id)->first();
                $bridge_data->thread_id = $is_thread->thread_id;
                $bridge_data->sender_id = $query->user_account_id;
                $bridge_data->receiver_id = Auth::id();
                $bridge_data->updated_at = Carbon::now();
                $bridge_data->created_at = Carbon::now();
            }
            else{
                //New thread save
                $thread = new MessageThread();
                $thread->save();

                $bridge_data->thread_id = $thread->id;
                $bridge_data->sender_id = Auth::id();
                $bridge_data->receiver_id = $query->user_account_id;
                $bridge_data->updated_at = Carbon::now();
                $bridge_data->created_at = Carbon::now();
            }
                $bridge_data->save();

                $message_data = DB::table('messages')
                ->select('message_id','thread_id','sender_id','receiver_id','message_text')
                ->join('messages_threads_data','messages.id','=','messages_threads_data.message_id')
                ->join('messages_thread','messages_threads_data.thread_id','=','messages_thread.id')
                ->where('post_id',$request->post_id)
                ->get();

                $data['success'] = 'true';
                $data['message'] =  '';
                $data['data'][] = $message_data;
                $data['error'] = 'false';

            return response()->json(['success'=>$data],200); 
         }
            catch(Exception $ex){
                $data['success'] = 'false';
                $data['message'] =  '';
                $data['data'] =  $ex->getMessage();
                $data['error'] = 'true';    
                return response()->json(['error'=>$data],401); 
            }
    }
}
