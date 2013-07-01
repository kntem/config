# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

#export PATH=/usr/local/share/python:$PATH
export PATH="$(brew --prefix)/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH"
#export ACLOCAL_FLAGS="-I `brew gettext`Cellar/automake/1.13.1/share/aclocal $ACLOCAL_FLAGS"
export ACLOCAL_FLAGS="-I $(brew --prefix)/share/aclocal" 
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
#$(brew --prefix)/share/aclocal
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/xport PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export WORKON_HOME=$HOME/envs
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

# some custom aliases
alias grep="grep --color=auto"

# Change the ls colors

# 1. directory
# 2. symbolic link
# 3. socket
# 4. pipe
# 5. executable
# 6. block special
# 7. character special
# 8. executable with setuid bit set
# 9. executable with setgid bit set
# 10. directory writable to others, with sticky bit
# 11. directory writable to others, without sticky bit

# a black
# b red
# c green
# d brown
# e blue
# f magenta
# g cyan
# h light grey
# A bold black, usually shows up as dark grey
# B bold red
# C bold green
# D bold brown, usually shows up as yellow
# E bold blue
# F bold magenta
# G bold cyan
# H bold light grey; looks like bright white
# x default foreground or background

export LSCOLORS=ExFxCxDxBxegedabagaced

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
use_color=true
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
if [[ -f /etc/DIR_COLORS ]] ; then
        match_lhs=$(</etc/DIR_COLORS)
elif type -p dircolors >/dev/null ; then
        match_lhs=$(dircolors --print-database)
else
        match_lhs=""
fi
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
. `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
    . `brew --prefix`/etc/bash_completion.d/git-prompt.sh
fi

function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
  }

function update_current_branch {
  branch_name="$(git symbolic-ref HEAD 2>/dev/null)" || branch_name="unamed_branch";
  export CURRENT_BRANCH="${branch_name##refs/heads/}";
}


if ${use_color} ; then
        if [[ ${EUID} == 0 ]] ; then
#               PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
                PS1='\[\033[01;34m\]`date +%d\/%m\/%g\ %H:%M` \[\033[01;31m\]\u @ \h \[\033[01;34m\]\W \$ \[\033[00m\]'
        else
#               PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
                #PS1='\[\033[01;34m\]`date +%d\/%m\/%g\ %H:%M` \[\033[01;32m\]\u @ \h \[\033[01;34m\]\w \$ \[\033[00m\]'
                PS1='\[\033[01;34m\]`date +%d\/%m\/%g\ %H:%M` \[\033[01;32m\]\u @ $(scutil --get ComputerName) \[\033[01;34m\]\w\[\033[01;33m\]`__git_ps1`\[\033[01;34m\] \$ \[\033[00m\]'
        fi

else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\u@\h \W \$ '
        else
                PS1='\u@\h \w \$ '
        fi
fi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#PS1='\h:\W \u\$ '
#PS1='\[\033[01;34m\]`date +%d\/%m\/%g\ %H:%M` \[\033[01;32m\]\u @ \h \[\033[01;34m\]\w\[\033[01;33m\]`__git_ps1`\[\033[01;34m\] \$ \[\033[00m\]'

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi
								    
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f /etc/bash_aliases ]; then
    . /etc/bash_aliases
fi

###### greeting
# from Jonathan's .bashrc file (by ~71KR117)
# get current hour (24 clock format i.e. 0-23)
hour=$(date +"%H")
# if it is midnight to midafternoon will say G'morning
if [ $hour -ge 0 -a $hour -lt 12 ]
then
  greet="Good Morning, $USER. Welcome back."
# if it is midafternoon to evening ( before 6 pm) will say G'noon
elif [ $hour -ge 12 -a $hour -lt 18 ]
then
  greet="Good Afternoon, $USER. Welcome back."
else # it is good evening till midnight
  greet="Good Evening, $USER. Welcome back."
fi
# display greeting
echo $greet


workon(){

export CFG_ENV_NAME=$1
export CFG_ENV_DIR=~/envs
export CFG_TMP=/tmp/deploy.$$
export CFG_INVENIO_SRCDIR_ORIG=~/src/invenio
export CFG_INVENIO_PREFIX=${CFG_ENV_DIR}/${CFG_ENV_NAME}
export CFG_INVENIO_SRCDIR=${CFG_INVENIO_PREFIX}/invenio

source $CFG_INVENIO_PREFIX/bin/activate
}

## Open manpages with different programs

pman () {
man -t "${1}" | open -f -a /Applications/Preview.app
}

sman() {
man "${1}" | col -b | open -f -a /Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2
}

repeat() {
n=$1
shift
while [ $(( n -= 1 )) -ge 0 ]
do
"$@"
done
}

up() {
repeat ${1-1} cd ..
}

## Git scripts

git_lines_per_author() {
git ls-files | xargs -n1 git blame | perl -n -e '/\s\((.*?)\s[0-9]{4}/ && print "$1\n"'     | sort -f | uniq -c | sort -r
}


function err_handle {
status=$?
echo status was $status

if [[ $status -eq 127 ]]; then
    lastcmd=$(history | tail -1 | sed 's/^ *[0-9]* * //')
    cd $lastcmd
fi
}

trap 'err_handle' ERR

