<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\UserLoyaltyPoint;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserLoyaltyPointController extends Controller
{
    //
    public function index(){
        $result = DB::table('user_points')
        ->select('post_title','post_type',DB::raw('SUM(point_earned) as total_earned'))
        ->join('users','user_points.user_account_id','=','users.id')
        ->join('user_posts','user_points.post_id','=','user_posts.id')
        ->where('is_active',1)
        ->groupBy('point_earned')
        ->orderBy('total_earned')
        ->get();
        
        $data['success'] = 'true';
        $data['message'] =  'My Loyalty points added';
        $data['data'] =  $result;
        $data['error'] = 'false';    
        return response()->json(['error'=>$data],200); 
    }

    public function store(Request $request){
        try{
        $point = new UserLoyaltyPoint();
        $point->post_id = $request->post_id;
        $point->user_account_id = Auth::id();
        $point->point_earned = $request->point_earned;
        $point->created_at = Carbon::now();
        $point->updated_at = Carbon::now();
        $point->save();

        $result = DB::table('user_points')
        ->select('post_title','post_type',DB::raw('count(post_title) as ads_posted'),'point_earned')
        ->join('users','user_points.user_account_id','=','users.id')
        ->join('user_posts','user_points.post_id','=','user_posts.id')
        ->where('is_active',1)
        ->where('post_id',$request->post_id)
        ->groupBy('post_title')
        ->get();

        
        $data['success'] = 'true';
        $data['message'] =  'User points added successfully';
        $data['data'] =  $result;
        $data['error'] = 'false';    
        return response()->json(['error'=>$data],200); 

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
