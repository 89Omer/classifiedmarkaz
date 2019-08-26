<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\UserPostResource;
use App\Models\SubCategory;
use App\Models\UserPost;
use App\Models\UserPostAttribute;
use App\Models\UserPostImage;
use App\Models\UserPostView;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Models\Category;

class UserPostController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            $posts = UserPost::with('post_attribute')
            ->with('post_image')
            ->with('post_view')
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

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
        //print_r($request->all());exit;

        $category_id = Category::where('name','=' ,$request->category)->first();
        $sub_category_id = SubCategory::where('subcategory_name','=',$request->sub_category)->first();
        $user_posts = new UserPost;
        $user_posts->user_account_id = Auth::user()->id;
        $user_posts->post_title = $request->post_title;
        $user_posts->post_detail= $request->post_detail;
        $user_posts->post_type = $request->post_type;
        $user_posts->category_id = $category_id->id;
        $user_posts->sub_category_id = $sub_category_id->id;
        $user_posts->created_at = Carbon::now();
        $user_posts->save();

        UserPostAttribute::create([
            'user_post_id'=>$user_posts->id,
            'post_attribute'=> $this->json_data($request->post_attribute),
            'created_at' => Carbon::now()
        ]);

        UserPostImage::create([
            'user_post_id'=>$user_posts->id,
            'image'=> $request->post_image,
            'created_at'=> Carbon::now()
        ]);

        $response = [$user_posts,
            'post_attribute'=>$this->json_data($request->post_attribute),
            'post_image'=> $request->post_image
        ];

    
          return new UserPostResource($response);
    }

    protected function json_data($data){
        return json_encode($data);
    }

    /**
     * Custom method submit favourite or 
     * review ads
     * 
     */
    public function submit(Request $request){
        try{
            $query = UserPostView::where('user_post_id',$request->post_id)->where('given_by',Auth::id())->first();
           
            if($request->is_favourite){
                if(!empty($query)){
                    UserPostView::where('user_post_id',$request->post_id)->where('given_by',Auth::id())
                    ->update(['is_favourite'=>$request->is_favourite]);
                }
                else{
                    UserPostView::create([
                        'user_post_id',$request->post_id,
                        'is_favourite'=>$request->is_favourite,
                        'given_by'=> Auth::id()
                        ]);
                }
               
            }
            elseif($request->rating && $request->review ){
                if(!empty($query)){
                    UserPostView::where('user_post_id',$request->post_id)->where('given_by',Auth::id())
                    ->update(['review'=>$request->review,
                    'rating'=>$request->rating]);
                }
                else{
                    UserPostView::create([
                        'user_post_id'=> $request->post_id,
                        'review'=>$request->review,
                        'rating'=>$request->rating,
                        'given_by'=> Auth::id()
                        ]);
                }
            }

            $data['success'] = 'true';
            $data['message'] =  'Submit Successful';
            $data['data'][] =  '';
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

    public function myFavourite(){
        try {
            $posts = DB::table('user_posts')
            ->select('post_title','post_detail','rating','review','image','is_favourite')
            ->join('user_post_attribute','user_posts.id','=','user_post_attribute.user_post_id')
            ->join('user_post_image','user_posts.id','=','user_post_image.user_post_id')
            ->join('user_post_view','user_posts.id','=','user_post_view.user_post_id')
            ->where('is_favourite',1)
            ->where('given_by',Auth::id())
            ->get();

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
    /**
     * Display a listing of the resource.
     * 
     * @return \Illuminate\Http\Response
     */
    public function myRating(){
        try {
            $posts = DB::table('user_posts')
            ->select('post_title','post_detail','rating','review','image','is_favourite')
            ->join('user_post_attribute','user_posts.id','=','user_post_attribute.user_post_id')
            ->join('user_post_image','user_posts.id','=','user_post_image.user_post_id')
            ->join('user_post_view','user_posts.id','=','user_post_view.user_post_id')
            ->where('given_by',Auth::id())
            ->get();
           
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

    /**
     * 
     * 
     */
    public function postPayment(){
        
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
