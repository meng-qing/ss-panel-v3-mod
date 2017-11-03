<?php

namespace App\Models;

use App\Services\Config;

class Shop extends Model
{
    protected $connection = "default";
    protected $table = "shop";

    public function content()
    {
        $content = json_decode($this->attributes['content'], true);
        $content_text="";
        $i = 0;
        foreach ($content as $key=>$value) {
            switch ($key) {
                case "bandwidth":
                    $content_text .= "Add traffic ".$value." G ";
                    break;
                case "expire":
                    $content_text .= "Add ".$value." days to your account's validity";
                    break;
                case "class":
                    $content_text .= "Upgrade account to level ".$value." ,Valid period ".$content["class_expire"]." days";
                    break;
                case "reset":
		    $content_text .= "Reset the traffic to ".$content["reset_value"]." G every ".$value." days in ".$content["reset_exp"]." days";
                    break;
                default:
            }

            if ($i<count($content)&&$key!="reset_exp") {
                $content_text .= ",";
            }

            $i++;
        }

        if (substr($content_text, -1, 1)==",") {
            $content_text=substr($content_text, 0, -1);
        }

        return $content_text;
    }

    public function bandwidth()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->bandwidth)) {
            return $content->bandwidth;
        } else {
            return 0;
        }
    }

    public function expire()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->expire)) {
            return $content->expire;
        } else {
            return 0;
        }
    }

    public function reset()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->reset)) {
            return $content->reset;
        } else {
            return 0;
        }
    }

    public function reset_value()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->reset_value)) {
            return $content->reset_value;
        } else {
            return 0;
        }
    }

    public function reset_exp()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->reset_exp)) {
            return $content->reset_exp;
        } else {
            return 0;
        }
    }

    public function user_class()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->class)) {
            return $content->class;
        } else {
            return 0;
        }
    }

    public function class_expire()
    {
        $content =  json_decode($this->attributes['content']);
        if (isset($content->class_expire)) {
            return $content->class_expire;
        } else {
            return 0;
        }
    }

    public function buy($user, $is_renew = 0)
    {
        $content = json_decode($this->attributes['content'], true);
        $content_text="";

        foreach ($content as $key=>$value) {
            switch ($key) {
                case "bandwidth":
                    if ($is_renew == 0) {
                        if (Config::get('enable_bought_reset') == 'true') {
                            $user->transfer_enable=$value*1024*1024*1024;
                            $user->u = 0;
                            $user->d = 0;
                            $user->last_day_t = 0;
                        } else {
                            $user->transfer_enable=$user->transfer_enable+$value*1024*1024*1024;
                        }
                    } else {
                        if ($this->attributes['auto_reset_bandwidth'] == 1) {
                            $user->transfer_enable=$value*1024*1024*1024;
                            $user->u = 0;
                            $user->d = 0;
                            $user->last_day_t = 0;
                        } else {
                            $user->transfer_enable=$user->transfer_enable+$value*1024*1024*1024;
                        }
                    }
                    break;
                case "expire":
                    if (time()>strtotime($user->expire_in)) {
                        $user->expire_in=date("Y-m-d H:i:s", time()+$value*86400);
                    } else {
                        $user->expire_in=date("Y-m-d H:i:s", strtotime($user->expire_in)+$value*86400);
                    }
                    break;
                case "class":
                    if ($user->class==0||$user->class!=$value) {
                        $user->class_expire=date("Y-m-d H:i:s", time());
                    }
                    $user->class_expire=date("Y-m-d H:i:s", strtotime($user->class_expire)+$content["class_expire"]*86400);
                    $user->class=$value;
                    break;
                default:
            }
        }

        $user->save();
    }
}
