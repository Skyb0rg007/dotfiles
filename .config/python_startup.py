import atexit
import os
import readline
import sys

# Prevent creation of ~/.python_history
if hasattr(sys, '__interactivehook__'):
    del sys.__interactivehook__

# Calculate the history file path
state_dir = os.getenv('XDG_STATE_HOME')
if state_dir is None:
    state_dir = os.path.join(os.path.expanduser('~'), '.local', 'state')
histfile = os.path.join(state_dir, 'python_history')

try:
    readline.read_history_file(histfile)
    hist_len = readline.get_current_history_length()
except FileNotFoundError:
    open(histfile, 'wb').close()
    hist_len = 0

def save(histfile, prev_len):
    new_len = readline.get_current_history_length()
    readline.set_history_length(1000)
    try:
        readline.append_history_file(new_len - prev_len, histfile)
    except AttributeError:
        readline.write_history_file(histfile)

atexit.register(save, histfile, hist_len)
