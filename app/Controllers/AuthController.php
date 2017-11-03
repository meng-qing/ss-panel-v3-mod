<?php

namespace App\Controllers;

use App\Models\InviteCode;
use App\Services\Config;
use App\Utils\Check;
use App\Utils\Tools;
use App\Utils\Radius;
use voku\helper\AntiXSS;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Message\ResponseInterface;

use App\Utils\Hash;
use App\Utils\Da;
use App\Services\Auth;
use App\Services\Mail;
use App\Models\User;
use App\Models\LoginIp;
use App\Models\EmailVerify;
use App\Utils\Duoshuo;
use App\Utils\GA;
use App\Utils\Wecenter;
use App\Utils\Geetest;
use App\Utils\TelegramSessionManager;

/**
 *  AuthController
 */

class AuthController extends BaseController
{
    public function login()
    {
        $uid = time().rand(1, 10000) ;
        if (Config::get('enable_geetest_login') == 'true') {
            $GtSdk = Geetest::get($uid);
        } else {
            $GtSdk = null;
        }

        if (Config::get('enable_telegram') == 'true') {
            $login_text = TelegramSessionManager::add_login_session();
            $login = explode("|", $login_text);
            $login_token = $login[0];
            $login_number = $login[1];
        } else {
            $login_token = '';
            $login_number = '';
        }

        return $this->view()->assign('geetest_html', $GtSdk)->assign('login_token', $login_token)->assign('login_number', $login_number)->assign('telegram_bot', Config::get('telegram_bot'))->display('auth/login.tpl');
    }

    public function loginHandle($request, $response, $args)
    {
        // $data = $request->post('sdf');
        $email =  $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $code = $request->getParam('code');
        $rememberMe = $request->getParam('remember_me');

        if (Config::get('enable_geetest_login') == 'true') {
            $ret = Geetest::verify($request->getParam('geetest_challenge'), $request->getParam('geetest_validate'), $request->getParam('geetest_seccode'));
            if (!$ret) {
                $res['ret'] = 0;
                $res['msg'] = "We could not verified with a system error. Please refresh the page and try again.";
                return $response->getBody()->write(json_encode($res));
            }
        }

        // Handle Login
        $user = User::where('email', '=', $email)->first();

        if ($user == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "401 E-mail address or password is wrong";
            return $response->getBody()->write(json_encode($rs));
        }

        if (!Hash::checkPassword($user->pass, $passwd)) {
            $rs['ret'] = 0;
            $rs['msg'] = "402 E-mail address or password is wrong";


            $loginip=new LoginIp();
            $loginip->ip=$_SERVER["REMOTE_ADDR"];
            $loginip->userid=$user->id;
            $loginip->datetime=time();
            $loginip->type=1;
            $loginip->save();

            return $response->getBody()->write(json_encode($rs));
        }
        // @todo
        $time =  3600*24;
        if ($rememberMe) {
            $time = 3600*24*7;
        }

        if ($user->ga_enable==1) {
            $ga = new GA();
            $rcode = $ga->verifyCode($user->ga_token, $code);

            if (!$rcode) {
                $res['ret'] = 0;
                $res['msg'] = "403 Two-step verification code error, if you are missing the generator or set this option incorrectly, you can try resetting the password to cancel this option.";
                return $response->getBody()->write(json_encode($res));
            }
        }

        Auth::login($user->id, $time);
        $rs['ret'] = 1;
        $rs['msg'] = "Welcome back.";

        $loginip=new LoginIp();
        $loginip->ip=$_SERVER["REMOTE_ADDR"];
        $loginip->userid=$user->id;
        $loginip->datetime=time();
        $loginip->type=0;
        $loginip->save();

        Wecenter::add($user, $passwd);
        Wecenter::Login($user, $passwd, $time);

        return $response->getBody()->write(json_encode($rs));
    }

    public function qrcode_loginHandle($request, $response, $args)
    {
        // $data = $request->post('sdf');
        $token =  $request->getParam('token');
        $number =  $request->getParam('number');

        $ret = TelegramSessionManager::step2_verify_login_session($token, $number);
        if (!$ret) {
            $res['ret'] = 0;
            $res['msg'] = "This token can not be used.";
            return $response->getBody()->write(json_encode($res));
        }


        // Handle Login
        $user = User::where('id', '=', $ret)->first();
        // @todo
        $time =  3600*24;

        Auth::login($user->id, $time);
        $rs['ret'] = 1;
        $rs['msg'] = "Welcome back.";

        $loginip=new LoginIp();
        $loginip->ip=$_SERVER["REMOTE_ADDR"];
        $loginip->userid=$user->id;
        $loginip->datetime=time();
        $loginip->type=0;
        $loginip->save();

        return $response->getBody()->write(json_encode($rs));
    }

    public function register($request, $response, $next)
    {
        $ary = $request->getQueryParams();
        $code = "";
        if (isset($ary['code'])) {
            $antiXss = new AntiXSS();
            $code = $antiXss->xss_clean($ary['code']);
        }

        $uid = time().rand(1, 10000) ;

        if (Config::get('enable_geetest_reg') == 'true') {
            $GtSdk = Geetest::get($uid);
        } else {
            $GtSdk = null;
        }



        return $this->view()->assign('enable_invite_code', Config::get('enable_invite_code'))->assign('geetest_html', $GtSdk)->assign('enable_email_verify', Config::get('enable_email_verify'))->assign('code', $code)->display('auth/register.tpl');
    }


    public function sendVerify($request, $response, $next)
    {
        if (Config::get('enable_email_verify')=='true') {
            $email = $request->getParam('email');

            if ($email=="") {
                $res['ret'] = 0;
                $res['msg'] = "Did you get your email address?";
                return $response->getBody()->write(json_encode($res));
            }

            // check email format
            if (!Check::isEmailLegal($email)) {
                $res['ret'] = 0;
                $res['msg'] = "Invalid email address";
                return $response->getBody()->write(json_encode($res));
            }


            $user = User::where('email', '=', $email)->first();
            if ($user!=null) {
                $res['ret'] = 0;
                $res['msg'] = "This e-mail address has already been registered";
                return $response->getBody()->write(json_encode($res));
            }

            $ipcount = EmailVerify::where('ip', '=', $_SERVER["REMOTE_ADDR"])->where('expire_in', '>', time())->count();
            if ($ipcount>=(int)Config::get('email_verify_iplimit')) {
                $res['ret'] = 0;
                $res['msg'] = "Too many requests from this IP";
                return $response->getBody()->write(json_encode($res));
            }


            $mailcount = EmailVerify::where('email', '=', $email)->where('expire_in', '>', time())->count();
            if ($mailcount>=3) {
                $res['ret'] = 0;
                $res['msg'] = "Too many requests from this email address";
                return $response->getBody()->write(json_encode($res));
            }

            $code = Tools::genRandomChar(6);

            $ev = new EmailVerify();
            $ev->expire_in = time() + Config::get('email_verify_ttl');
            $ev->ip = $_SERVER["REMOTE_ADDR"];
            $ev->email = $email;
            $ev->code = $code;
            $ev->save();

            $subject = Config::get('appName')." - Verification email address";

            try {
                Mail::send($email, $subject, 'auth/verify.tpl', [
                    "code" => $code,"expire" => date("Y-m-d H:i:s", time() + Config::get('email_verify_ttl'))
                ], [
                    //BASE_PATH.'/public/assets/email/styles.css'
                ]);
            } catch (Exception $e) {
                return false;
            }

            $res['ret'] = 1;
            $res['msg'] = "We sent an verification code. Please check your mailbox.";
            return $response->getBody()->write(json_encode($res));
        }
    }

    public function registerHandle($request, $response, $next)
    {
        $name =  $request->getParam('name');
        $email =  $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $repasswd = $request->getParam('repasswd');
        $code = $request->getParam('code');
        $imtype = $request->getParam('imtype');
        $emailcode = $request->getParam('emailcode');
        $wechat = $request->getParam('wechat');
        // check code

        if (Config::get('enable_geetest_reg') == 'true') {
            $ret = Geetest::verify($request->getParam('geetest_challenge'), $request->getParam('geetest_validate'), $request->getParam('geetest_seccode'));
            if (!$ret) {
                $res['ret'] = 0;
                $res['msg'] = "The system can not accept your verification results. Please refresh the page and try again.";
                return $response->getBody()->write(json_encode($res));
            }
        }

        if (Config::get('enable_invite_code')=='true') {
            $c = InviteCode::where('code', $code)->first();
            if ($c == null) {
                $res['ret'] = 0;
                $res['msg'] = "Invitation code is invalid";
                return $response->getBody()->write(json_encode($res));
            }
        }

        // check email format
        if (!Check::isEmailLegal($email)) {
            $res['ret'] = 0;
            $res['msg'] = "Invalid email address";
            return $response->getBody()->write(json_encode($res));
        }

        if (Config::get('enable_email_verify')=='true') {
            $mailcount = EmailVerify::where('email', '=', $email)->where('code', '=', $emailcode)->where('expire_in', '>', time())->first();
            if ($mailcount == null) {
                $res['ret'] = 0;
                $res['msg'] = "The verification code is different.";
                return $response->getBody()->write(json_encode($res));
            }
            EmailVerify::where('email', '=', $email)->delete();
        }

        // check pwd length
        if (strlen($passwd)<8) {
            $res['ret'] = 0;
            $res['msg'] = "Password is too short";
            return $response->getBody()->write(json_encode($res));
        }

        // check pwd re
        if ($passwd != $repasswd) {
            $res['ret'] = 0;
            $res['msg'] = "Mistook the input twice";
            return $response->getBody()->write(json_encode($res));
        }

        // check email
        $user = User::where('email', $email)->first();
        if ($user != null) {
            $res['ret'] = 0;
            $res['msg'] = "This e-mail address has already been registered";
            return $response->getBody()->write(json_encode($res));
        }

       // if ($imtype==""||$wechat=="") {
       //     $res['ret'] = 0;
       //     $res['msg'] = "要填上你的联络方式哦";
       //     return $response->getBody()->write(json_encode($res));
       // }

       // $user = User::where('im_value', $wechat)->where('im_type', $imtype)->first();
       // if ($user != null) {
       //     $res['ret'] = 0;
       //     $res['msg'] = "此联络方式已经被注册了";
       //     return $response->getBody()->write(json_encode($res));
       // }

        // do reg user
        $user = new User();

        $antiXss = new AntiXSS();


        $user->user_name = $antiXss->xss_clean($name);
        $user->email = $email;
        $user->pass = Hash::passwordHash($passwd);
        $user->passwd = Tools::genRandomChar(6);
        $user->port = Tools::getAvPort();
        $user->t = 0;
        $user->u = 0;
        $user->d = 0;
        $user->method = Config::get('reg_method');
        $user->protocol = Config::get('reg_protocol');
        $user->protocol_param = Config::get('reg_protocol_param');
        $user->obfs = Config::get('reg_obfs');
        $user->obfs_param = Config::get('reg_obfs_param');
        $user->forbidden_ip = Config::get('reg_forbidden_ip');
        $user->forbidden_port = Config::get('reg_forbidden_port');
        $user->im_type =  $imtype;
        $user->im_value =  $antiXss->xss_clean($wechat);
        $user->transfer_enable = Tools::toGB(Config::get('defaultTraffic'));
        $user->invite_num = Config::get('inviteNum');
        $user->auto_reset_day = Config::get('reg_auto_reset_day');
        $user->auto_reset_bandwidth = Config::get('reg_auto_reset_bandwidth');
        if (Config::get('enable_invite_code')=='true') {
            $user->ref_by = $c->user_id;
        } else {
            $user->ref_by = 0;
        }
        $user->expire_in=date("Y-m-d H:i:s", time()+Config::get('user_expire_in_default')*86400);
        $user->reg_date=date("Y-m-d H:i:s");
        $user->reg_ip=$_SERVER["REMOTE_ADDR"];
        $user->money=0;
        $user->class=0;
        $user->plan='A';
        $user->node_speedlimit=0;
        $user->theme=Config::get('theme');

        $group=Config::get('ramdom_group');
        $Garray=explode(",", $group);

        $user->node_group=$Garray[rand(0, count($group)-1)];

        $ga = new GA();
        $secret = $ga->createSecret();

        $user->ga_token=$secret;
        $user->ga_enable=0;


        if ($user->save()) {
            $res['ret'] = 1;
            $res['msg'] = "Sign up succeeded";

            Duoshuo::add($user);


            Radius::Add($user, $user->passwd);

            if (Config::get('enable_invite_code')=='true') {
                $c->delete();
            }

            return $response->getBody()->write(json_encode($res));
        }
        $res['ret'] = 0;
        $res['msg'] = "unknown mistake";
        return $response->getBody()->write(json_encode($res));
    }

    public function logout($request, $response, $next)
    {
        Auth::logout();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/auth/login');
        return $newResponse;
    }

    public function qrcode_check($request, $response, $args)
    {
        $token = $request->getQueryParams()["token"];
        $number = $request->getQueryParams()["number"];

        if (Config::get('enable_telegram') == 'true') {
            $ret = TelegramSessionManager::check_login_session($token, $number);
            $res['ret'] = $ret;
            return $response->getBody()->write(json_encode($res));
        } else {
            $res['ret'] = 0;
            return $response->getBody()->write(json_encode($res));
        }
    }
}
