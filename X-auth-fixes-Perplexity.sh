1. Clean up stale Xauthority files on login

Add this near the top of your remote host’s ~/.bashrc (before any custom prompts or PATH edits):
bash

# --- X11 forwarding maintenance ---
if [ -n "$SSH_CONNECTION" ]; then
    find "$HOME" -maxdepth 1 -type f -name '.Xauthority-*' -delete 2>/dev/null
    [ -z "$XAUTHORITY" ] && export XAUTHORITY="$HOME/.Xauthority"
fi

What it does:

    Runs only for SSH sessions.

    Deletes leftover .Xauthority-* temporary files created by failed logins.

    Ensures $XAUTHORITY is set properly.

2. Optional: Display a sanity check message

Helps confirm everything’s working when you connect:
bash

if [ -n "$SSH_CONNECTION" ]; then
    echo "X11 forwarding active on DISPLAY=$DISPLAY"
fi

3. Optional: Quick command to test GUI forwarding

You can add this helper function:
bash

xcheck() { xclock >/dev/null 2>&1 & disown; }

Then type xcheck after connecting — if xclock appears locally, you’re good.
4. Reload your .bashrc

After editing, either source it:
bash

source ~/.bashrc

or reconnect via SSH to test a clean login:
bash

ssh -Y theserver.local

With those lines, X11 forwarding should “just work” every time you log in, even if an earlier session left clutter behind.

Would you like me to extend this setup to auto‑detect when DISPLAY is missing and re‑initialize X forwarding via xauth?
