<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Support\Facades\DB;

class AuctionBidController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
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
            ->where('user_posts.post_type','auction')
            ->where('user_posts.is_active',1)
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
                        'auction_lowest_bid'=>'',
                        'auction_current_bid'=>'',
                        'status'=>'',
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
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
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
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
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
