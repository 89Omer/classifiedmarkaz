<?php
namespace App\Http\Controllers\Api;
use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 
use App\Models\User; 
use App\Models\UserOtp;
use Exception;
use Illuminate\Support\Facades\Auth; 
use Validator;
class AuthController extends Controller 
{
 public $successStatus = 200;
 public $success_bit = 'true';
 public $error_bit = 'false';

  
 public function register(Request $request) {    
    $validator = Validator::make($request->all(), [ 
                'mobile_number' => 'required'
                //'email' => 'required|email',
                //'password' => 'required',  
                //'c_password' => 'required|same:password', 
        ]);   
    if ($validator->fails()) {          
        //return response()->json(['error'=>$validator->errors()], 401);     
        $data['success'] = 'false';
        $data['message'] =  '';
        $data['error'] =  $validator->errors();
        $data['error'] = 'true';    
        return response()->json(['error'=>$data],401); 
        }    
        $input = $request->all();  
        //$input['password'] = bcrypt($input['mobile_number']);
        //$user = User::create($input); 
        $data['success'] = 'true';
        $data['message'] =  'An OTP is sent to your '.$input['mobile_number'];
        $data['data'] = '';
        $data['error'] = 'false';
    return response()->json(['success'=>$data], 200); 
}

public function sendOtp(Request $request) {    
    $validator = Validator::make($request->all(), [ 
                'mobile_number' => 'required'
        ]);   
    $data['data']['verification_code'] = mt_rand(1000, 9999);

    if ($validator->fails()) {          
        //return response()->json(['error'=>$validator->errors()], 401);
                $data['success'] = 'false';
                $data['message'] =  '';
                $data['error'] =  $validator->errors();
                $data['error'] = 'true';     
            return response()->json(['data'=>$data],401); 
        }    
            $input = $request->all();  
           
            $otp_save = UserOtp::updateOrCreate(['mobile_number' => $input['mobile_number']],
            [
            'verification_code' => $data['data']['verification_code'],
            'mobile_number' => $input['mobile_number']
        ]);
            
            if($otp_save){
                $data['success'] = 'true';
                $data['message'] =  'Your OTP code';
                $data['data']['verification_code'] = $data['data']['verification_code'];
                $data['error'] = 'false';
                return response()->json(['success'=>$data],200); 
            }
            else{
                $data['success'] = 'true';
                $data['message'] =  'REsend OTP code';
                $data['data']['verification_code'] = '';
                $data['error'] = 'false';
                return response()->json(['error'=>$data],204); 
            }
       
}

public function verifyOtp() {     
            $otp_data = UserOtp::where('verification_code',$_GET['verification_code'])->count();
            if($otp_data == '0'){
                $error['success'] = 'false';
                $error['message'] = 'OTP Code not verified';
                $error['data']['token'] = '';
                $error['error'] = 'true';
                return response()->json(['error'=>$error], 401);  
                 
            }else{
                $input['password'] = bcrypt($_GET['mobile_number']);
                $input['mobile_number'] = $_GET['mobile_number'];
                $user = User::create($input); 
                $data['success'] = 'true';
                $data['message'] =  'OTP code sucessful, you have registered';
                $data['data']['token'] =  $user->createToken('AppName')->accessToken;
                $data['error'] = 'false';
                return response()->json(['data'=>$data], 200);  

            }

}
  /**
   * User Login Controller
   * 
   */
    public function login(){ 
        if(Auth::attempt(['mobile_number' => request('mobile_number'), 'password' => request('mobile_number')])){ 
            $user = Auth::user();
            $success['success'] = 'true';
            $success['message'] =  'Login Successful.';
            $success['data']['token'] =  $user->createToken('AppName')->accessToken;
            $success['error'] = 'false';
                return response()->json(['success' => $success], $this-> successStatus); 
            } else{ 
            $error['success'] = 'false';
            $error['message'] =  'Unauthorised';
            $error['data']['token'] =  '';
            $error['error'] = 'true';
            return response()->json(['error'=> $error], 401); 
        } 
    }
    /**
     * User Edit profile
     */
    public function edit(Request $request){
        try{
            $user = User::find(Auth::id());
           // print_r(Auth::id());die;

            $input = $request->all();
            $user->fill($input)->save();

            $success['success'] = 'true';
            $success['message'] =  'User Profile updated successfully';
            $success['data'][] = $user;
            $success['error'] = 'false';
            return response()->json(['success'=> $success], 200);
        }
        catch(Exception $ex){
            $error['success'] = 'false';
            $error['message'] =  $ex->getMessage();
            $error['data']['token'] =  '';
            $error['error'] = 'true';
            return response()->json(['error'=> $error], 401);
        }

    }

    /**
     * Logout user (Revoke the token)
     *
     * @return [string] message
     */
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        $success['success'] = 'true';
        $success['message'] =  'Successfully logged out';
        $success['data'][] = '';
        $success['error'] = 'false';
        return response()->json(['data'=>$success], 200);  
    }

    public function getUser() {
    $user = Auth::user();
    return response()->json(['success' => $user], $this->successStatus); 
    }
} 