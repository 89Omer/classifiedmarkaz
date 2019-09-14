<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use TCG\Voyager\Models\Category;
use App\Http\Controllers\Api\SearchController;
use Exception;
use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{
    //
    public function index(){
        try {
            $category = Category::all();

            $data['success'] = 'true';
            $data['message'] =  '';
            $data['data'] = $category;
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

    public function filter(Request $request){
        try {
            $posts = DB::table('user_posts')
            ->select('first_name','last_name','name','subcategory_name','user_account_id','post_type','post_title','post_detail','post_attribute','image','is_favourite')
            ->join('user_post_attribute', 'user_posts.id', '=', 'user_post_attribute.user_post_id')
            ->leftjoin('user_post_image', 'user_posts.id', '=', 'user_post_image.user_post_id')
            ->leftjoin('user_post_view', 'user_posts.id', '=', 'user_post_view.user_post_id')
            ->join('categories', 'user_posts.category_id', '=', 'categories.id')
            ->join('sub_categories', 'user_posts.sub_category_id', '=', 'sub_categories.id')
            ->join('users', 'user_posts.user_account_id', '=', 'users.id')
            ->where('user_posts.category_id',$request->category_id)
            ->where('user_posts.is_active',1)
            ->get();
            if($posts->isEmpty()){
                $count = 0;
            }
            else{
                $count = $posts->count();
            }
            $custom = [];
            $custom['recent'] = $count;
            $custom['posts'] = $posts;

            $data['success'] = 'true';
            $data['message'] =  '';
            $data['data'] = $custom;
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
