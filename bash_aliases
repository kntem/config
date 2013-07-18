alias update_bash_aliases='sudo vim /private/etc/bash_aliases &&
                          cp /private/etc/bash_aliases /Users/ntem/my_repos/config/bash_aliases &&
                          cd ~/my_repos/config &&
                          sudo git add bash_aliases &&
                          sudo git commit &&
                          cd - &&
                          refresh'

alias install_bash_aliases='sudo cp /Users/ntem/my_repos/config/bash_aliases /private/etc/bash_aliases'

alias echo_bash_aliases='less /private/etc/bash_aliases'

alias update_bashrc='sudo vim /private/etc/bashrc &&
                          cp /private/etc/bashrc /Users/ntem/my_repos/config/bashrc &&
                          cd ~/my_repos/config &&
                          sudo git add bashrc &&
                          sudo git commit &&
                          cd - &&
                          refresh'

alias install_bashrc='sudo cp /Users/ntem/my_repos/config/bashrc /private/etc/bashrc'

alias echo_bashrc='less /private/etc/bashrc'


alias update_vimrc='sudo vim /usr/share/vim/vimrc &&
                    cd ~/my_repos/config &&
                    sudo cp /usr/share/vim/vimrc ~/my_repos/config/vimrc &&
                    sudo git add vimrc &&
                    sudo git commit &&
                    cd - &&
                    refresh'
alias echo_vimrc='less /usr/share/vim/vimrc'

alias install_vimrc='sudo cp /Users/ntem/my_repos/config/vimrc /usr/share/vim/vimrc'

alias push_config='cd ~/my_repos/config &&
                git push &&
                cd -'
alias refresh='source /private/etc/bashrc'

alias mvim="open -a MacVim.app"

#alias update='sudo apt-get update'

alias clr='clear'
alias grep='grep --colour=auto'
alias ls='ls -lG'
alias ll='ls -lG'
alias ks='ls -lG'
alias la='ls -la'
alias lstree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias rm='rm -i'
alias hg='history | grep'
alias bigfiles='find . -ls | sort -n -k 7 | tail -n 20'

## Navigation

alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdenv='cd $CFG_INVENIO_PREFIX'
alias go_back='cd -'

alias invenio='cd ~/src/invenio/'
alias bibfield='cd ~/src/invenio/modules/bibfield/'
alias bibworkflow='cd ~/src/invenio/modules/bibworkflow/'
alias miscutil='cd ~/src/invenio/modules/miscutil/'
alias webdeposit='cd ~/src/invenio/modules/webdeposit/'

## Misc utils

alias diskprogs='lsof | grep Volumes'
alias calendar='paste <(cal "`date +%Y`")'

## Invenio logs

alias logs='cd $CFG_INVENIO_PREFIX/var/log'
alias inveniolog='tail $CFG_INVENIO_PREFIX/var/log/invenio.err'
alias flasklog='tail $CFG_INVENIO_PREFIX/var/log/flask.log'
alias apachelog='tail $CFG_INVENIO_PREFIX/var/log/apache.log'
alias blueprintslog='tail $CFG_INVENIO_PREFIX/var/log/broken-blueprints.log'
alias broken_depositions_log='tail $CFG_INVENIO_PREFIX/var/log/broken-depositions.log'
alias broken_forms_log='tail $CFG_INVENIO_PREFIX/var/log/broken-deposition-forms.log'
alias broken_fields_log='tail $CFG_INVENIO_PREFIX/var/log/broken-deposition-fields.log'

## Invenio servers

alias flask_server='python ~/src/python-scripts/flask_run.py'
alias redis-server='cd ~/src/redis-stable/src/ && ./redis-server'
alias redis-cli='~/src/redis-stable/src/redis-cli'


## Invenio install

alias invenio-configure='./configure --prefix=$CFG_INVENIO_PREFIX --with-python=$CFG_INVENIO_PREFIX/bin/python'

alias mi='invenio-make-install'
#alias mi='sudo make install'
alias mia='sudo make install && sudo /etc/init.d/apache2 restart'
alias apr='sudo /etc/init.d/apache2 restart'
alias aps='sudo /etc/init.d/apache2 stop'

alias aaa='aclocal && automake -a && autoconf'
alias invenio-configure='~/src/invenio/configure --prefix=$CFG_INVENIO_PREFIX --with-python=$CFG_INVENIO_PREFIX/bin/python'
alias invenio_update_local_conf='vim $CFG_INVENIO_PREFIX/etc/invenio-local.conf && inveniocfg --update-all'

alias kwalitee='python ~/src/invenio/modules/miscutil/lib/kwalitee.py'
alias kwalitee-options='cat ~/src/invenio/modules/miscutil/lib/kwalitee.py | head -n 49 | tail -n 24'


## Git aliases ##

alias gb='git branch'
alias br='git branch'
alias gl='git log'
alias log='git log --decorate'
alias show='git show'
alias glfiles="gl1 --name-only --pretty=format:'%Cred%h %Cgreen %s'"
alias glf='glfiles'

alias gl1='git log --oneline --decorate'
alias glp='git log --pretty=oneline --decorate'
alias brgrep='git branch -a | grep'
alias brd='git branch -d'
alias brD='git branch -D'

alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gdiff='git diff'
alias gch='git checkout'
alias checkout='git checkout'
alias gco='git commit'
alias commit='git commit'
alias rebase-head='git rebase -i HEAD~10'
alias rebase-next='git rebase -i next'
alias push='update_current_branch && echo "Updating kntem-public/"$CURRENT_BRANCH && git push kntem-public $CURRENT_BRANCH'
alias br_recent='git for-each-ref --sort=-committerdate --count=10 --format="%(refname:short)" refs/heads/'

alias git_log_last_week='git log --author="`git config --get user.name`" --format="- %B" --since=-7days --reverse'

## Fun

alias coffee_break='cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'
