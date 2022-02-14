_luarocks-admin() {
    local IFS=$' \t\n'
    local args cur prev cmd opts arg
    args=("${COMP_WORDS[@]}")
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-h --help --version --dev --server --from --only-server --only-from --only-sources --only-sources-from --namespace --lua-dir --lua-version --tree --to --local --global --verbose --timeout --project-tree"

    case "$prev" in
        --server|--from)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --only-server|--only-from)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --only-sources|--only-sources-from)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --namespace)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --lua-dir)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --lua-version)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --tree|--to)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --timeout)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
        --project-tree)
            COMPREPLY=($(compgen -f -- "$cur"))
            return 0
            ;;
    esac

    args=("${args[@]:1}")
    for arg in "${args[@]}"; do
        case "$arg" in
            help)
                cmd="help"
                opts="$opts -h --help"
                break
                ;;
            completion)
                cmd="completion"
                opts="$opts -h --help"
                break
                ;;
            add)
                cmd="add"
                opts="$opts -h --help --server --no-refresh --index"
                break
                ;;
            make_manifest|make-manifest)
                cmd="make_manifest"
                opts="$opts -h --help --local-tree --deps-mode --nodeps"
                break
                ;;
            refresh_cache|refresh-cache)
                cmd="refresh_cache"
                opts="$opts -h --help --from"
                break
                ;;
            remove)
                cmd="remove"
                opts="$opts -h --help --server --no-refresh"
                break
                ;;
        esac
    done

    case "$cmd" in
        '')
            COMPREPLY=($(compgen -W "help completion add make_manifest make-manifest refresh_cache refresh-cache remove" -- "$cur"))
            ;;
        'help')
            COMPREPLY=($(compgen -W "help completion add make_manifest make-manifest refresh_cache refresh-cache remove" -- "$cur"))
            ;;
        'add')
            case "$prev" in
                --server)
                    COMPREPLY=($(compgen -f -- "$cur"))
                    return 0
                    ;;
            esac

            ;;
        'make_manifest')
            case "$prev" in
                --deps-mode)
                    COMPREPLY=($(compgen -W "all one order none" -- "$cur"))
                    return 0
                    ;;
            esac

            ;;
        'refresh_cache')
            case "$prev" in
                --from)
                    COMPREPLY=($(compgen -f -- "$cur"))
                    return 0
                    ;;
            esac

            ;;
        'remove')
            case "$prev" in
                --server)
                    COMPREPLY=($(compgen -f -- "$cur"))
                    return 0
                    ;;
            esac

            ;;
    esac

    if [[ "$cur" = -* ]]; then
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    fi
}

complete -F _luarocks-admin -o bashdefault -o default luarocks-admin
