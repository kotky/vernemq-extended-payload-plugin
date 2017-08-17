extendedPayload
=====

Vernemq extended payload plugin

Build
-----

    $ rebar3 compile

Enable in Vernemq
-----

    $ vmq-admin plugin enable --name=extendedPayload --path=PARENT_FOLDER_FULL_PATH/extendedPayload/_build/default/lib/extendedPayload
    
IMPORTANT NOTICES
-----

  - The plugin assumes that the payload is json string and it will force json string if the user has sent nothing in payload
  - Currently I don't know how to set plugin to run with Vernemq start, I was folowing the way in the documentation but I wasn't successful, so if anyone knows feel free to share.
