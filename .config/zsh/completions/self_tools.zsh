#compdef self_tools

autoload -U is-at-least

_self_tools() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
":: :_self_tools_commands" \
"*::: :->self_tools" \
&& ret=0
    case $state in
    (self_tools)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:self_tools-command-$line[1]:"
        case $line[1] in
            (compress-image)
_arguments "${_arguments_options[@]}" : \
'-d+[image directory]: :_files -/' \
'--dir=[image directory]: :_files -/' \
'-i[if true, ignore cases where the aspect ratio is greater than 1]' \
'--ignore[if true, ignore cases where the aspect ratio is greater than 1]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(rename-image)
_arguments "${_arguments_options[@]}" : \
'-d+[image directory]: :_files -/' \
'--dir=[image directory]: :_files -/' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(filter-image)
_arguments "${_arguments_options[@]}" : \
'-i+[input directory]: :_files -/' \
'--input_dir=[input directory]: :_files -/' \
'-o+[output directory]: :_files -/' \
'--output_dir=[output directory]: :_files -/' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
':SHELL -- shell name:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_self_tools__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:self_tools-help-command-$line[1]:"
        case $line[1] in
            (compress-image)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(rename-image)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(filter-image)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_self_tools_commands] )) ||
_self_tools_commands() {
    local commands; commands=(
'compress-image:compress images in a directory' \
'rename-image:rename images in a directory' \
'filter-image:filter images in a directory, and move them to another directory' \
'completion:shell auto-complete feature' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'self_tools commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__completion_commands] )) ||
_self_tools__subcmd__completion_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools completion commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__compress-image_commands] )) ||
_self_tools__subcmd__compress-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools compress-image commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__filter-image_commands] )) ||
_self_tools__subcmd__filter-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools filter-image commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help_commands] )) ||
_self_tools__subcmd__help_commands() {
    local commands; commands=(
'compress-image:compress images in a directory' \
'rename-image:rename images in a directory' \
'filter-image:filter images in a directory, and move them to another directory' \
'completion:shell auto-complete feature' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'self_tools help commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help__subcmd__completion_commands] )) ||
_self_tools__subcmd__help__subcmd__completion_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools help completion commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help__subcmd__compress-image_commands] )) ||
_self_tools__subcmd__help__subcmd__compress-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools help compress-image commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help__subcmd__filter-image_commands] )) ||
_self_tools__subcmd__help__subcmd__filter-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools help filter-image commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help__subcmd__help_commands] )) ||
_self_tools__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools help help commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__help__subcmd__rename-image_commands] )) ||
_self_tools__subcmd__help__subcmd__rename-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools help rename-image commands' commands "$@"
}
(( $+functions[_self_tools__subcmd__rename-image_commands] )) ||
_self_tools__subcmd__rename-image_commands() {
    local commands; commands=()
    _describe -t commands 'self_tools rename-image commands' commands "$@"
}

if [ "$funcstack[1]" = "_self_tools" ]; then
    _self_tools "$@"
else
    compdef _self_tools self_tools
fi
