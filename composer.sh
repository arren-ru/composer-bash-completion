# Composer completion

_composer()
{
    local cur prev words cword
    _init_completion || return

    local special i
    for (( i=0; i < ${#words[@]}-1; i++ )); do
        if [[ ${words[i]} == @(require) ]]; then
            special=${words[i]}
        fi
    done

    if [[ -n $special ]]; then
        if [[ $prev != $special ]]; then
            # assume $prev is a package name
            COMPREPLY=( $( composer show $prev 2>/dev/null | \
                sed -r -e 's/\x1b\[[0-9]+m//g' | grep ^versions | \
                sed -r -e 's/^versions : //' -e 's/, /\n/g' | grep "^$cur" | sort -u ) )
        fi
        if [[ -z $COMPREPLY ]]; then
            # if $prev was not a package
            COMPREPLY=( $( composer show -a 2>/dev/null | \
                grep -v '^No composer' | grep "^$cur" | sort -u ) )
        fi
        return 0
    fi

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-h -q -v -V -n -d \
            --help --quiet --verbose --version --ansi --no-ansi \
            --no-interaction --profile --working-dir' -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W 'about archive config create-project \
            depends diagnose dump-autoload dumpautoload \
            help init install list require search \
            self-update selfupdate show status update validate' -- "$cur" ) )
    fi

    return 0
} &&
complete -F _composer composer
