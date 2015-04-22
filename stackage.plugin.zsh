local WORDS

_stackage ()
{
    WORDS=()
    for w in $words[1,(($CURRENT - 1))]; do
        if [[ $w != -* ]]; then WORDS+=$w; fi
    done
    if (( $#WORDS == 1 )); then
        _arguments \
            '*::command:_stackage_command'
    else
        _arguments '*::command:_stackage_command'
    fi
}

_stackage_command ()
{
    local -a _stackage_cmds
    _stackage_cmds=(
        "init:Get a cabal.config file from Stackage"
        "purge:Delete cabal.config and purge your package database"
        "upgrade:Delete cabal.config file and wipe your package database, then get a new cabal.config from Stackage"
        "update:Updates your package index"
        "sandbox:Manages shared stackage sandboxes"
    )
    if (( CURRENT == 1 )) then
        _describe -t commands 'command' _stackage_cmds || compadd "$@"
    else
      local curcontext="$curcontext"
      cmd="${${_stackage_cmds[(r)$WORDS[2]:*]%%:*}}"
        if (( $#cmd )); then
            _call_function ret _stackage_$cmd
        else
            _message "unknown stackage command: $WORDS[2]"
        fi
    fi
}

_stackage_init ()
{
    _arguments  '--summary[Show commmand summary]'
}

_stackage_purge ()
{
    _arguments  '--summary[Show commmand summary]'
}

_stackage_upgrade ()
{
    _arguments  '--summary[Show commmand summary]'
}

_stackage_update ()
{
    _arguments  '--summary[Show commmand summary]'
}

_stackage_sandbox ()
{
    WORDS=()
    for w in $words[1,(($CURRENT - 1))]; do
        if [[ $w != -* ]]; then WORDS+=$w; fi
    done
    if (( $#WORDS == 1 )); then
        _arguments \
            '--summary[Show commmand summary]' \
            '*::command:_stackage_sandbox_command'
    else
        _arguments '*::command:_stackage_sandbox_command'
    fi
}

_stackage_sandbox_command ()
{
    local -a _stackage_sandbox_cmds
    _stackage_sandbox_cmds=(
        "init:Initialize sandbox"
    )
    if (( CURRENT == 1 )) then
        _describe -t commands 'command' _stackage_sandbox_cmds || compadd "$@"
    fi
}

compdef _stackage stackage
compdef stk='stackage'
