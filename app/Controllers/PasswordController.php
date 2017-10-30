<?php

namespace App\Controllers;

use App\Models\User;
use App\Models\PasswordReset;
use App\Services\Password;
use App\Utils\Hash;

/***
 * Class Password
 * @package App\Controllers
 * パスワードをリセットする
 */

class PasswordController extends BaseController
{
    public function reset()
    {
        return $this->view()->display('password/reset.tpl');
    }

    public function handleReset($request, $response, $args)
    {
        $email =  $request->getParam('email');
        // check limit

        // send email
        $user = User::where('email', $email)->first();
        if ($user == null) {
            $rs['ret'] = 0;
            $rs['msg'] = 'このメールアドレスは存在しません。';
            return $response->getBody()->write(json_encode($rs));
        }
        Password::sendResetEmail($email);
        $rs['ret'] = 1;
        $rs['msg'] = 'リセットのためのEメールを送信したので、ご確認下さい。';
        return $response->getBody()->write(json_encode($rs));
    }

    public function token($request, $response, $args)
    {
        $token = $args['token'];
        return $this->view()->assign('token', $token)->display('password/token.tpl');
    }

    public function handleToken($request, $response, $args)
    {
        $tokenStr = $args['token'];
        $password =  $request->getParam('password');
        $repasswd =  $request->getParam('repasswd');
        
        if ($password != $repasswd) {
            $res['ret'] = 0;
            $res['msg'] = "入力を2度間違えています";
            return $response->getBody()->write(json_encode($res));
        }

        if (strlen($password) < 8) {
            $res['ret'] = 0;
            $res['msg'] = "パスワードが短すぎます";
            return $response->getBody()->write(json_encode($res));
        }
        
        // check token
        $token = PasswordReset::where('token', $tokenStr)->first();
        if ($token == null || $token->expire_time < time()) {
            $rs['ret'] = 0;
            $rs['msg'] = 'リンクの有効期限切れです。もう一度取得して下さい';
            return $response->getBody()->write(json_encode($rs));
        }

        $user = User::where('email', $token->email)->first();
        if ($user == null) {
            $rs['ret'] = 0;
            $rs['msg'] = 'リンクの有効期限切れです。もう一度取得して下さい';
            return $response->getBody()->write(json_encode($rs));
        }

        // reset password
        $hashPassword = Hash::passwordHash($password);
        $user->pass = $hashPassword;
        $user->ga_enable = 0;
        if (!$user->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = 'リセットに失敗しました。もう一度試して下さい';
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = 'リセットされました';
        
        $user->clean_link();
        
        return $response->getBody()->write(json_encode($rs));
    }
}
