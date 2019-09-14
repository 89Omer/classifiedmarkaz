<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Model\UserLatestSearch;
use App\Models\SubCategory;
use App\Models\User;
use App\Models\UserLatestSearch as AppUserLatestSearch;
use App\Models\UserPost;
use App\Models\UserPostAlert;
use Exception;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use TCG\Voyager\Models\Category;

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
        $q = Input::get('text');
        $q_upper = strtoupper($q);
        $q_lower = strtolower($q);
        
        if (Auth::check()){
            self::addUserSearchIndex($q);
        }
        try {
            $posts = DB::table('user_posts')
            ->select('first_name','last_name','name','subcategory_name','user_account_id','post_type','post_title','post_detail','post_attribute','image','is_favourite')
            ->join('user_post_attribute', 'user_posts.id', '=', 'user_post_attribute.user_post_id')
            ->join('user_post_image', 'user_posts.id', '=', 'user_post_image.user_post_id')
            ->join('user_post_view', 'user_posts.id', '=', 'user_post_view.user_post_id')
            ->join('categories', 'user_posts.category_id', '=', 'categories.id')
            ->join('sub_categories', 'user_posts.sub_category_id', '=', 'sub_categories.id')
            ->join('users', 'user_posts.user_account_id', '=', 'users.id')
            ->whereRaw("MATCH (post_attribute) AGAINST(? IN NATURAL LANGUAGE MODE)", array($q))
            ->orWhereRaw("MATCH(post_title,post_detail) AGAINST(? IN NATURAL LANGUAGE MODE)", array($q))
            ->paginate(25);
            
              // //Customize query result
            $posts->getCollection()->transform(function ($value) {
                $result =[
                        'post_type'=>$value->post_type,
                        'post_title'=>$value->post_title,
                        'post_detail'=>$value->post_detail,
                        'category'=>$value->name,
                        'sub_category'=>$value->subcategory_name,
                        'post_attribute'=>json_decode($value->post_attribute),
                        'image'=>$value->image,
                        'is_favourite'=>$value->is_favourite,
                        'user'=>$value->first_name .' '.$value->last_name,
                    ];
                return $result;
            });

            $data['success'] = 'true';
            $data['message'] =  '';
            $data['data'] = $posts->toArray();
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
      //
    /**
     * Display a listing for the guest user .
     * 
     * Home Page
     * 
     * @return \Illuminate\Http\Response
     */
    public function home()
    {
        $q = Input::get('text');
        try {
            $posts = DB::table('user_posts')
            ->select('first_name','last_name','name','subcategory_name','user_account_id','post_type','post_title','post_detail','post_attribute','image','is_favourite')
            ->join('user_post_attribute', 'user_posts.id', '=', 'user_post_attribute.user_post_id')
            ->join('user_post_image', 'user_posts.id', '=', 'user_post_image.user_post_id')
            ->join('user_post_view', 'user_posts.id', '=', 'user_post_view.user_post_id')
            ->join('categories', 'user_posts.category_id', '=', 'categories.id')
            ->join('sub_categories', 'user_posts.sub_category_id', '=', 'sub_categories.id')
            ->join('users', 'user_posts.user_account_id', '=', 'users.id')
            ->whereRaw("MATCH (post_attribute) AGAINST(? IN NATURAL LANGUAGE MODE)", array($q))
            ->orWhereRaw("MATCH(post_title,post_detail) AGAINST(? IN NATURAL LANGUAGE MODE)", array($q))
            ->paginate(25);
            
              // //Customize query result
            $posts->getCollection()->transform(function ($value) {
                $result =[
                        'post_type'=>$value->post_type,
                        'post_title'=>$value->post_title,
                        'post_detail'=>$value->post_detail,
                        'category'=>$value->name,
                        'sub_category'=>$value->subcategory_name,
                        'post_attribute'=>json_decode($value->post_attribute),
                        'image'=>$value->image,
                        'is_favourite'=>$value->is_favourite,
                        'user'=>$value->first_name .' '.$value->last_name,
                    ];
                return $result;
            });

            $data['success'] = 'true';
            $data['message'] =  '';
            $data['data'] = $posts->toArray();
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
    
    /**
     * Fetch user post add search listings
     * 
     */
    public function view(){
        $posts = DB::table('user_latest_searches')
        ->where('user_account_id',Auth::id())
        ->get();
        $count = $posts->count();
        if($posts->isEmpty()){
            $data['success'] = 'false';
            $data['message'] =  'You have got '.$count.' search history';
            $data['data'][] = '';
            $data['error'] = 'true';

        return response()->json(['success'=>$data],401); 
        }
        else{
            $data['success'] = 'true';
            $data['message'] =   'You have got '.$count.' search history';
            $data['data'] = $posts;
            $data['error'] = 'false';

        return response()->json(['success'=>$data],200); 
        }

    }
    /**
     * 
     * Add user search history 
     * For authenticated users
     */
    public static function addUserSearchIndex($text){
       
           $post = new AppUserLatestSearch();
           $post->user_account_id = Auth::id();
           $post->search_value = $text;
           $post->created_at = Carbon::now();
           $post->save();
    }

    /**
     * Get records based on user searches
     * 
     */
    public function getPostByUserSearch(){
        try{
            $posts = DB::table('user_posts')
            ->select('name','subcategory_name','post_type','post_title','post_detail','post_attribute','image','is_favourite')
            ->join('user_post_attribute', 'user_posts.id', '=', 'user_post_attribute.user_post_id')
            ->join('user_post_image', 'user_posts.id', '=', 'user_post_image.user_post_id')
            ->join('user_post_view', 'user_posts.id', '=', 'user_post_view.user_post_id')
            ->join('categories', 'user_posts.category_id', '=', 'categories.id')
            ->join('sub_categories', 'user_posts.sub_category_id', '=', 'sub_categories.id')
            ->join('user_latest_searches', 'user_posts.user_account_id', '=', 'user_latest_searches.user_account_id')
            ->groupBy('user_latest_searches.user_account_id')
            ->orderBy('user_latest_searches.search_value','DESC')
            ->paginate(25);
            $data['success'] = 'true';
            $data['message'] =   'Based on your last search';
            $data['data'] = $posts;
            $data['error'] = 'false';
            return response()->json(['success'=>$data],200); 

        }
        catch(Exception $ex){
            $data['success'] = 'false';
            $data['message'] =   $ex->getMessage();
            $data['data'][] = '';
            $data['error'] = 'false';
            return response()->json(['error'=>$data],401); 

        }
        
       
   
    }

    public static function addCustomCollection($posts){
        
              // //Customize query result
              $posts->getCollection()->transform(function ($value) {
                $result =[
                        'post_type'=>$value->post_type,
                        'post_title'=>$value->post_title,
                        'post_detail'=>$value->post_detail,
                        'category'=>$value->name,
                        'sub_category'=>$value->subcategory_name,
                        'post_attribute'=>json_decode($value->post_attribute),
                        'image'=>$value->image,
                        'is_favourite'=>$value->is_favourite,
                        'user'=>$value->first_name .' '.$value->last_name,
                    ];
                return $result;
            });
    }

}
