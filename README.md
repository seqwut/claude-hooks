# claude-hooks
collection of hooks

This one hook "ecosystem" (re)starts your claude with --dangerously-skip-permissions in tmux session, pastes your prompt of choice into a new session and takes it from there.  
Ideal for orchestrator based multi-agent workflows. 

Pre-requisites: 

CC runs in tmux session  
tested on ubuntu 22.04 LTS  



For usage: 


1. adapt `PROJECT_DIR` in https://github.com/seqwut/claude-hooks/blob/b57487437168cd78cdfeb2281e3930c2c63de4bd/claude_auto_loop.sh#L4
1.1 put `claude_auto_loop.sh` in your /home/ or /root/ folder.

2. adapt `https://github.com/seqwut/claude-hooks/blob/cadc3d3b51d8f9bbb60239f025e7bf2a0ace5d90/.claude/settings.json#L7`  
2.1 Add hooks snippet to your settings.json

3. adapt https://github.com/seqwut/claude-hooks/blob/cadc3d3b51d8f9bbb60239f025e7bf2a0ace5d90/.claude/hooks/stop_blocker.py#L21
   3.1 put `stop_blocker.py` in .claude/hooks/  
   3.2 chmod +x `stop_blocker.py`


## To start the loop
`sudo bash claude_auto_loop.sh`  

## To stop the loop 

`touch /tmp/claude_stop_now` or `CTRL+C` when script is attempting to restart claude when you stopped it. 
   



