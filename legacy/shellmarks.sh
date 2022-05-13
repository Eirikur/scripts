# Utilities for quickly accessing frequently used directories in bash.

# Usage:
# $ cd /path/to/project/src/
# $ mark code # Will create a new shortcut.
# # Becomes interactive if a shortcut already exists
# # m is an alias for mark. You can also `m code`
#
# $ code # From now on, running this anywhere in the shell
# # will put you in /path/to/project/src/code
#
# $ unmark code # Will remove the symlink and is interactive
# # u is an alias for unmark. You can also `u code`

SHELLMARKSDIR="$HOME/.shellmarks"
mkdir -p $SHELLMARKSDIR
function mark_alias { alias $(basename $1)="cd -P $1"; }

function mark { # Mark a directory
symlink=$SHELLMARKSDIR/$1
ln -ivhs "$(pwd)" $symlink && mark_alias $symlink
}
alias m=mark

function unmark { # Remove a mark
symlink=$SHELLMARKSDIR/$1
rm -iv $symlink
if [ ! -f $symlink ]; then
unalias $1
fi
}
alias u=unmark

function shellmarks { # List all existing marks
LINK_COLOR=$'\e[1;35m'
RESET_COLOR=$'\e[0m'
for symlink in $SHELLMARKSDIR/*; do
echo "${LINK_COLOR} $(basename $symlink) ${RESET_COLOR} -> $(readlink $symlink)"
done
}

for symlink in $SHELLMARKSDIR/*; do # load all existing symlinks as aliases
mark_alias $symlink
test -e $symlink || rm $symlink # remove symlinks if source does not exist
done
