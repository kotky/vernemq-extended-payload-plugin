-module(extendedPayload).

-behaviour(auth_on_publish_hook).
-behaviour(auth_on_subscribe_hook).

-export([auth_on_publish/6, auth_on_subscribe/3]).

auth_on_subscribe(UserName, ClientId, [{_Topic, _QoS}|_] = Topics) ->
    %% error_logger:info_msg("auth_on_subscribe: ~p ~p ~p", [UserName, ClientId, Topics]),
    %% do whatever you like with the params, all that matters
    %% is the return value of this function
    %%
    %% 1. return 'ok' -> SUBSCRIBE is authorized
    %% 2. return 'next' -> leave it to other plugins to decide
    %% 3. return {error, whatever} -> auth chain is stopped, and no SUBACK is sent

    %% we return 'ok'
    ok.

auth_on_publish(UserName, {_MountPoint, _ClientId} = SubscriberId, QoS, Topic, Payload, IsRetain) ->
    error_logger:info_msg("auth_on_publish: ~p ~p ~p ~p ~p ~p", [UserName, SubscriberId, QoS, Topic, Payload, IsRetain]),
    %% do whatever you like with the params, all that matters
    %% is the return value of this function
    %%
    %% 1. return 'ok' -> PUBLISH is authorized
    %% 2. return 'next' -> leave it to other plugins to decide
    %% 3. return {ok, NewPayload::binary} -> PUBLISH is authorized, but we changed the payload
    %% 4. return {ok, [{ModifierKey, NewVal}...]} -> PUBLISH is authorized, but we might have changed different Publish Options:
    %%     - {topic, NewTopic::string}
    %%     - {payload, NewPayload::binary}
    %%     - {qos, NewQoS::0..2}
    %%     - {retain, NewRetainFlag::boolean}
    %% 5. return {error, whatever} -> auth chain is stopped, and message is silently dropped (unless it is a Last Will message)
    %%
    %% we return 'ok'
    %% AdditionalData = <<"bla">>,
    %% NewPayload= <<AdditionalData/binary, Payload/binary>>,
    %% error_logger:info_msg("extended payload: ~p ", [NewPayload]),
    %% {ok, [{payload, Payload}]}.
    error_logger:info_msg("payload size: ~p ", [byte_size(Payload)]),
    if 
        byte_size(Payload)>2 -> <<FirstChar:1/binary, CleanPayload/binary>> = Payload,
                                ClientId = <<FirstChar/binary, "\"client_id\":\"", UserName/binary, "\",">>,
                                NewPayload = <<ClientId/binary, CleanPayload/binary>>;
        true -> NewPayload = <<"{\"client_id\":\"", UserName/binary, "\"}">>
    end,
    error_logger:info_msg("extended payload: ~p ", [NewPayload]),
    {ok, [{payload, NewPayload}]}.
