<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\UserPost;
use Illuminate\Support\Facades\DB;

class SearchController extends Controller
{
    //
    /**
     * Display a listing of the resource.
     * 
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //dd($request->all());
        //
        $searchword = $_GET['text'];
        try {
            $posts = DB::table('user_posts')
            ->join('user_post_attribute', 'user_posts.id', '=', 'user_post_attribute.user_post_id')
            ->join('user_post_image', 'user_posts.id', '=', 'user_post_image.user_post_id')
           // ->where('post_attribute',$_GET['text'])
            //->whereRaw('JSON_CONTAINS(post_attribute, \'{"'.$_GET['text'].'"}\')')
            ->whereRaw('MATCH (post_attribute) AGAINST ("'.$searchword.'")')
            ->paginate(25);

            $data['success'] = 'true';
            $data['message'] =  '';
            $data['data'] = $posts;
            $data['error'] = 'false';

        return response()->json(['success'=>$data],200); 
       
    } catch (Exception $ex) { // Anything that went wrong
            $data['success'] = 'false';
                $data['message'] =  '';
                $data['data'] =  $ex->getMessage();
                $data['error'] = 'true';    
                return response()->json(['error'=>$data],401); 
        }
    }

}
