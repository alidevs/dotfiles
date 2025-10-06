function push-line
    set cl (commandline)
    commandline -f repaint
    if test -n (string join $cl)
        set -g fish_buffer_stack $cl
        commandline ''
        commandline -f repaint

        function restore_line -e fish_postexec
            commandline $fish_buffer_stack
            functions -e restore_line
            set -e fish_buffer_stack
        end
    end
end
