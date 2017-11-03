<?php

namespace App\Controllers;

use App\Models\Relay;
use App\Models\Node;
use App\Models\User;
use App\Services\Auth;
use App\Controllers\UserController;
use App\Utils\Tools;
use App\Services\Config;

class RelayController extends UserController
{
    public function index($request, $response, $args)
    {
        $pageNum = 1;
        $user = Auth::getUser();
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $logs = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->paginate(15, ['*'], 'page', $pageNum);
        $logs->setPath('/user/relay');

        $is_relay_able = Tools::is_protocol_relay($user);

        //链路表部分

        $nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                      ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where("sort", "=", 10)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $pathset = new \ArrayObject();

        $relay_rules = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->get();
        $mu_nodes = Node::where('sort', 9)->where('node_class', '<=', $user->class)->where("type", "1")->where(
            function ($query) use ($user) {
                $query->where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->get();

        foreach ($nodes as $node) {
            if ($node->mu_only == 0) {
                $relay_rule = Tools::pick_out_relay_rule($node->id, $user->port, $relay_rules);

                if ($relay_rule != null) {
                    $pathset = Tools::insertPathRule($relay_rule, $pathset, $user->port);
                }
            }

            if ($node->custom_rss == 1) {
                foreach ($mu_nodes as $mu_node) {
                    $mu_user = User::where('port', '=', $mu_node->server)->first();

                    if ($mu_user == null) {
                        continue;
                    }

                    if (!($mu_user->class >= $node->node_class && ($node->node_group == 0 || $node->node_group == $mu_user->node_group))) {
                        continue;
                    }

                    if ($mu_user->is_multi_user != 2) {
                        $relay_rule = Tools::pick_out_relay_rule($node->id, $mu_user->port, $relay_rules);

                        if ($relay_rule != null) {
                            $pathset = Tools::insertPathRule($relay_rule, $pathset, $mu_user->port);
                        }
                    }
                }
            }
        }

        foreach ($pathset as $path) {
            foreach ($pathset as $index => $single_path) {
                if ($path != $single_path && $path->port == $single_path->port) {
                    if ($single_path->end_node->id == $path->begin_node->id) {
                        $path->begin_node = $single_path->begin_node;
                        if ($path->begin_node->isNodeAccessable() == false) {
                            $path->path = '<font color="#FF0000">'.$single_path->begin_node->name.'</font>'." → ".$path->path;
                            $path->status = "阻断";
                        } else {
                            $path->path = $single_path->begin_node->name." → ".$path->path;
                            $path->status = "通畅";
                        }

                        $pathset->offsetUnset($index);
                        continue;
                    }

                    if ($path->end_node->id == $single_path->begin_node->id) {
                        $path->end_node = $single_path->end_node;
                        if ($single_path->end_node->isNodeAccessable() == false) {
                            $path->path = $path->path." → ".'<font color="#FF0000">'.$single_path->end_node->name.'</font>';
                            $path->status = "阻断";
                        } else {
                            $path->path = $path->path." → ".$single_path->end_node->name;
                        }

                        $pathset->offsetUnset($index);
                        continue;
                    }
                }
            }
        }

        return $this->view()->assign('rules', $logs)->assign('relay_able_protocol_list', Config::getSupportParam('relay_able_protocol'))->assign('is_relay_able', $is_relay_able)->assign('pathset', $pathset)->display('user/relay/index.tpl');
    }

    public function create($request, $response, $args)
    {
        $user = Auth::getUser();
        $source_nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $dist_nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $ports_raw = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $ports = array();
        foreach ($ports_raw as $port_raw) {
            $mu_user = User::where('port', $port_raw->server)->first();
            if ($mu_user->is_multi_user == 1) {
                array_push($ports, $port_raw->server);
            }
        }

        array_push($ports, $user->port);

        return $this->view()->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->assign('ports', $ports)->display('user/relay/add.tpl');
    }

    public function add($request, $response, $args)
    {
        $user = Auth::getUser();

        $dist_node_id = $request->getParam('dist_node');
        $source_node_id = $request->getParam('source_node');
        $port = $request->getParam('port');
        $priority = $request->getParam('priority');

        $source_node = Node::where('id', $source_node_id)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->first();
        if ($source_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        $dist_node = Node::where('id', $dist_node_id)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->where("node_class", "<=", $user->class)->first();

        if ($dist_node_id == -1) {
            $dist_node = new Node();
            $dist_node->id = -1;
            $dist_node->node_ip = "0.0.0.0";
            $dist_node->sort = 10;
        }

        if ($dist_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        $port_raw = Node::where('server', $port)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->first();
        if ($port_raw == null && $port != $user->port) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        if (!Tools::is_protocol_relay($user)) {
            $rs['ret'] = 0;
            $rs['msg'] = "In order to stabilize the transfer, you need to be in<a href='/user/edit'>Information editor</a> set the agreement for the auth_aes128_md5 or auth_aes128_sha1 set up after the transfer rules!";
            return $response->getBody()->write(json_encode($rs));
        }

        $rule = new Relay();
        $rule->user_id = $user->id;
        $rule->dist_node_id = $dist_node_id;

        $dist_node_ip = Tools::getRelayNodeIp($source_node, $dist_node);
        $rule->dist_ip = $dist_node_ip;

        $rule->source_node_id = $source_node_id;
        $rule->port = $port;
        $rule->priority = min($priority, 99998);

        $ruleset = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->get();
        $maybe_rule_id = Tools::has_conflict_rule($rule, $ruleset, 0, $rule->source_node_id);
        if ($maybe_rule_id != 0) {
            $rs['ret'] = 0;
            $rs['msg'] = "You are about to add rules and rules ID:".$maybe_rule_id." conflict!";
            if ($maybe_rule_id == -1) {
                $rs['msg'] = "The rules you are about to add may cause conflicts!";
            }
            return $response->getBody()->write(json_encode($rs));
        }

        if (!$rule->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "add failed";
            return $response->getBody()->write(json_encode($rs));
        }

        $rs['ret'] = 1;
        $rs['msg'] = "Added successfully";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];

        $user = Auth::getUser();
        $rule = Relay::where('id', $id)->where('user_id', $user->id)->first();

        if ($rule == null) {
            exit(0);
        }

        $user = Auth::getUser();
        $source_nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $dist_nodes = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $ports_raw = Node::where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->orderBy('name')->get();

        $ports = array();
        foreach ($ports_raw as $port_raw) {
            $mu_user = User::where('port', $port_raw->server)->first();
            if ($mu_user->is_multi_user == 1) {
                array_push($ports, $port_raw->server);
            }
        }

        array_push($ports, $user->port);

        return $this->view()->assign('rule', $rule)->assign('source_nodes', $source_nodes)->assign('dist_nodes', $dist_nodes)->assign('ports', $ports)->display('user/relay/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $user = Auth::getUser();
        $rule = Relay::where('id', $id)->where('user_id', $user->id)->first();

        if ($rule == null) {
            exit(0);
        }

        $dist_node_id = $request->getParam('dist_node');
        $source_node_id = $request->getParam('source_node');
        $port = $request->getParam('port');
        $priority = $request->getParam('priority');

        $source_node = Node::where('id', $source_node_id)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 10)->where("node_class", "<=", $user->class)->first();
        if ($source_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        $dist_node = Node::where('id', $dist_node_id)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where(
            function ($query) {
                $query->Where('sort', 0)
                    ->orWhere('sort', 10);
            }
        )->where("node_class", "<=", $user->class)->first();

        if ($dist_node_id == -1) {
            $dist_node = new Node();
            $dist_node->id = -1;
            $dist_node->node_ip = "0.0.0.0";
            $dist_node->sort = 10;
        }

        if ($dist_node == null) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        $port_raw = Node::where('server', $port)->where(
            function ($query) use ($user) {
                $query->Where("node_group", "=", $user->node_group)
                    ->orWhere("node_group", "=", 0);
            }
        )->where('type', 1)->where('sort', 9)->where("node_class", "<=", $user->class)->first();
        if ($port_raw == null && $port != $user->port) {
            $rs['ret'] = 0;
            $rs['msg'] = "ok";
            return $response->getBody()->write(json_encode($rs));
        }

        if (!Tools::is_protocol_relay($user)) {
            $rs['ret'] = 0;
            $rs['msg'] = "In order to stabilize the transfer, you need to be in<a href='/user/edit'>Information editor</a>Set the agreement for the auth_aes128_md5 or auth_aes128_sha1 set up after the transfer rules!";
            return $response->getBody()->write(json_encode($rs));
        }

        $rule->user_id = $user->id;
        $rule->dist_node_id = $dist_node_id;

        $dist_node_ip = Tools::getRelayNodeIp($source_node, $dist_node);
        $rule->dist_ip = $dist_node_ip;

        $rule->source_node_id = $source_node_id;
        $rule->port = $port;
        $rule->priority = min($priority, 99998);

        $ruleset = Relay::where('user_id', $user->id)->orwhere('user_id', 0)->get();
        $maybe_rule_id = Tools::has_conflict_rule($rule, $ruleset, $rule->id, $rule->source_node_id);
        if ($maybe_rule_id != 0) {
            $rs['ret'] = 0;
            $rs['msg'] = "You are about to add rules and rules ID:".$maybe_rule_id." conflict！";
            if ($maybe_rule_id == -1) {
                $rs['msg'] = "The rules you are about to add may cause conflicts!";
            }
            return $response->getBody()->write(json_encode($rs));
        }

        if (!$rule->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "fail to edit";
            return $response->getBody()->write(json_encode($rs));
        }

        $rs['ret'] = 1;
        $rs['msg'] = "Successfully modified";
        return $response->getBody()->write(json_encode($rs));
    }


    public function delete($request, $response, $args)
    {
        $id = $request->getParam('id');
        $user = Auth::getUser();
        $rule = Relay::where('id', $id)->where('user_id', $user->id)->first();

        if ($rule == null) {
            exit(0);
        }

        if (!$rule->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "failed to delete";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "successfully deleted";
        return $response->getBody()->write(json_encode($rs));
    }
}
