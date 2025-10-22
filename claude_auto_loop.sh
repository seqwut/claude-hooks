#!/bin/bash

# Always ensure we're in the project directory
PROJECT_DIR="/home/$User_name/$Project_Name"

while true; do
    # Reset terminal state
    stty sane 2>/dev/null
    clear
    
    # Always cd to project directory before starting
    cd "$PROJECT_DIR"
    echo "Working in: $(pwd)"
    
    if [ -f /tmp/claude_next_command ]; then
        COMMAND=$(cat /tmp/claude_next_command)
        rm /tmp/claude_next_command
        
        echo "Restarting with command injection..."
        
        # Write command to temp file (without newline)
        echo -n "$COMMAND" > /tmp/claude_cmd_temp
        
        # Expect script with different Enter attempts
        expect -c '
            set timeout 30
            spawn claude code --dangerously-skip-permissions
            
            # Wait for prompt
            expect {
                ">" {
                    # Wait for full initialization
                    sleep 12
                    
                    # Read command
                    set fp [open "/tmp/claude_cmd_temp" r]
                    set cmd [gets $fp]
                    close $fp
                    
                    # Send command
                    send -- "$cmd"
                    
                    # Wait a moment
                    sleep 1
                    
                    # Try different Enter sequences
                    send "\015"  ;# Octal for CR (Carriage Return)
                    sleep 0.5
                    send "\012"  ;# Octal for LF (Line Feed)
                }
            }
            
            # Hand over control
            interact
        '
        
        # Cleanup
        rm -f /tmp/claude_cmd_temp
    else
        # Normal start
        claude code --dangerously-skip-permissions
    fi
    
    # Reset terminal after Claude exits
    stty sane 2>/dev/null
    
    if [ -f /tmp/claude_stop_now ]; then
        rm /tmp/claude_stop_now
        echo "Stopping auto-loop"
        break
    fi
    
    echo "Claude exited, restarting in 2 seconds..."
    sleep 2
done

# Final cleanup
reset
echo "Claude auto-loop ended. Terminal restored."
