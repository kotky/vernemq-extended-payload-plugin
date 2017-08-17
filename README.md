extendedPayload
=====

Vernemq extended payload plugin

Build
-----

    $ rebar3 compile

Enable in Vernemq
-----

    Manually enable
    vmq-admin plugin enable --name=extendedPayload --path=PARENT_FOLDER_FULL_PATH/extendedPayload/_build/default/lib/extendedPayload
    
    On Vernemq start
    Add the following to the vernemq.conf file:
  
    ## custom plugin
    plugins.extendedPayload = on
    plugins.extendedPayload.path = PARENT_FOLDER_FULL_PATH/extendedPayload/_build/default/lib/extendedPayload
    
IMPORTANT NOTICES
-----

  - The plugin assumes that the payload is json string and it will force json string if the user has sent nothing in payload
  - If you have multiple plugins that uses same hooks as this plugin it won't work (I am not certain if this is fixed in newer versions)
