<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class UserPostResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
      //print_r($this);die;
      // return [
      //   'id' => $this->id,
      //   'post_category'=>$this->post_category,
      //   'post_subcategory'=>$this->post_subcategory,
      //   'post_title' => $this->post_title,
      //   'post_detail' => $this->post_detail,
      //   'posted_data'=> [
      //       'post_alert' => $this->post_alert,
      //       'post_attribute' => $this->post_attribute,
      //       'post_image' => $this->post_image,
      //   ],
      //   'created_at' => (string) $this->created_at,
      //   'updated_at' => (string) $this->updated_at,
      // ];

      if (empty($request->all())) {          
        //return response()->json(['error'=>$validator->errors()], 401);     
          $data['success'] = 'false';
          $data['message'] =  'Something went wrong!';
          $data['error'] = 'true';    
          return response()->json(['error'=>$data],401); 
        }  
      $data = [
        'post_type'=>$request->post_type,
        'post_category'=>$request->category,
        'post_subcategory'=>$request->subcategory,
        'post_title' => $request->post_title,
        'post_detail' => $request->post_detail,
        'post_data'=> [
            'post_alert' => $request->post_alert,
            'post_attribute' => $request->post_attribute,
            'post_image' => $request->image,
        ],
        'is_active'=>'no',
        'is_favourtie'=>'no',
        'created_at' => (string) $this->created_at,
        'updated_at' => (string) $this->updated_at,
      ];
      $success['success'] = 'true';
      $success['message'] =  'Your ad has been recieved. It under process of reveiwing';
      $success['data'][] = $data;
      $success['error'] = 'false';    
      return ['success'=>$success]; 
    
    }
}
