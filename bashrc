# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022
#
# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window

# Text Colors 

red='\e[91m'
green='\e[0;3;92m'
Orange='\e[93m'
#Navy='\e[94m'
purple='\e[95m'
aqua='\e[96m'
white='\e[97m'
gray='\e[38;5;239m'

# Text formats
dim='\e[2m'
bold='\e[1m'
and='\e[0m'

_activity(){
  if [ "$(git branch 2> /dev/null)" ]
  then
    branch="$(printf $(git branch | grep '*' | cut -d ' ' -f 2))"
    printf "$white$branch$and"
  elif [ -e ./make* ]
  then
    printf 'Makefile'
  elif [ -e readme* ]
  then
    printf "(See: $(ls readme* || printf 'README'))"
  else
    printf " No Activity"
  fi
}

_my_ip() # Get IP adress on ethernet.                                                                                                                         
{                                                                                                                                                                     
    MY_IP=$(ip route get 1.2.3.4 | awk '{print $7}' |                                                                                                        
      sed -e s/addr://)                                                                                                                                               
    echo ${MY_IP:-"Disconnected"}                                                                                                                                    
}

_my_public_ip4() # Get IP adress on ethernet.                                                                                                                         
{                                                                                                                                                                     
    MY_IP=$(wget -qO- ipv4.icanhazip.com |                                                                                                        
      sed -e s/addr://)                                                                                                                                               
    echo ${MY_IP:-"Disconnected"}                                                                                                                                    
}                                                                                                                                                                     
                                                                                                                                                                         
_my_public_ip6() # Get IP adress on ethernet.                                                                                                                         
{                                                                                                                                                                     
    MY_IP=$(wget -qO- ipv6.icanhazip.com |                                                                                                        
      sed -e s/addr://)                                                                                                                                               
    echo ${MY_IP:-"Disconnected"}                                                                                                                                    
}                                                                                                                                                                     
                                                                                                                                                                            
export note="$red$(_activity)$and"
_note_color (){

  local status_code="$?"
  if [ "$status_code" != "0" ]
  then
     status_ascii="$red ✘$and"
    printf "$status_ascii$lred╦═➤[$and$dim\033[03;91m$(_activity)$and$lred] ➤[$and\033[03;91m$(date +%r)$lred]$and $dim$gray# $status_code$and"
  else
     status_ascii="$green ✔$and"
     printf "$status_ascii$Orange╦═➤[Activity $and$dim\033[03;96m$( _activity )$and$Orange] ➤[Time $and\033[03;96m$( date +%r )$Orange] ➤[Private Ip $and\033[03;96m$( _my_ip )$Orange] $and"
   fi
}

# ➤[Private Ip:- $and\033[03;36m$( _my_ip )$yello]

# ➤[Public Ipv4 $and\033[03;36m$(_my_public_ip4)$yello Ipv6:- $and\033[03;36m$(_my_public_ip6)$yello]

# should be on the output of commands, not on the prompt

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then

PS1='''\
$(_note_color)
$(printf $aqua)╚═╩═╦═➤[${debian_chroot:+($debian_chroot)}\[\033[03;91m\]\u$(printf $)@\h\[\033[00m\]$(printf $aqua)] ➤ {\[\033[03;93m\]\w\[\033[00m\]$(printf $aqua)}$(printf $and)
 $(printf $red)☣⚔╚═══  ≧◉ᴥ◉≦  ✍ ➤ $(printf $and$green) '''
echo='''\n'''

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

man() {
        LESS_TERMCAP_md=$'\e[02;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;32;91m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




#============================================================                                                                                                         
#                                                                                                                                                                     
#  ALIASES AND FUNCTIONS                                                                                                                                              
#                                                                                                                                                                     
#  Arguably, some functions defined here are quite big.                                                                                                               
#  If you want to make this file smaller, these functions can                                                                                                         
#+ be converted into scripts and removed from here.                                                                                                                   
#                                                                                                                                                                     
#============================================================                                                                                                         

# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# ~/.bashrc: executed by bash(1) for non-login shells.

                                                                                                                                                                                                                                                                                                                                
# some more ls aliases
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias dd='dd status=progress'

#-------------------                                                                                                                                                  
# Personnal Aliases                                                                                                                                                   
#-------------------                                                                                                                                                  
                                                                                                                                                                      
alias rm='rm -i'                                                                                                                                                      
alias cp='cp -i'                                                                                                                                                      
alias mv='mv -i'   
                                                                                                                                                   
# -> Prevents accidentally clobbering files.                                                                                                                          
alias mkdir='mkdir -p'                                                                                                                                                
                                                                                                                                                                      
alias h='history'                                                                                                                                                     
alias j='jobs -l'                                                                                                                                                     
alias which='type -a'                                                                                                                                                 
alias ..='cd ..'
alias c='clear'                                                                                                                                                      
alias cls='clear'                                                                                                                                                      
                                                                                                                                                                  
# Pretty-print of some PATH variables:                                                                                                                                
alias path='echo -e ${PATH//:/\\n}'                                                                                                                                   
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'                                                                                                                     
                                                                                                                                                                      
# Makes a more readable output.                                                                                                                                                                      
alias du='du -kh'                                                                                                                     
alias df='df -kTh'                                                                                                                                                    
                                                                                                                                                                      
#-------------------------------------------------------------                                                                                                        
# The 'ls' family (this assumes you use a recent GNU ls).                                                                                                             
#-------------------------------------------------------------                                                                                                        
# Add colors for filetype and  human-readable sizes by default on 'ls':                                                                                               
alias ls='ls -h --color'                                                                                                                                              
alias lx='ls -lXB'         #  Sort by extension.                                                                                                                      
alias lk='ls -lSr'         #  Sort by size, biggest last.                                                                                                             
alias lt='ls -ltr'         #  Sort by date, most recent last.                                                                                                         
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.                                                                                              
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.                                                                                              
                                                                                                                                                                      
# The ubiquitous 'll': directories first, with alphanumeric sorting:                                                                                                  
alias ll="ls -lv --group-directories-first"                                                                                                                           
alias lm='ll |more'        #  Pipe through 'more'                                                                                                                     
alias lr='ll -R'           #  Recursive ls.                                                                                                                           
alias la='ll -A'           #  Show hidden files.                                                                                                                      
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...                                                                                                  
                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                         
#-------------------------------------------------------------                                                                                                        
# Personnal and keyboard-dependent :-)                                                                                                        
#-------------------------------------------------------------                                                                                                        

alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias spell='enchant -a -l' 
alias killme='cd ~/;rm -rf ~/.safe & cleanme;mkdir ~/.safe;changeme'    
alias cleanme='killall firefor-esr;sync; echo 1> /proc/sys/vm/drop_caches;sync; echo 2 > /proc/sys/vm/drop_cache;sync; echo 3 > /proc/sys/vm/drop_caches;history -c;bleachbit -c --preset;clear'
alias hideme='killall firefox-esr;firefox-esr http://www/whaitismyipaddress.com http://www.google.com;clear'
alias powerstart='dpkg --configure -a;apt -f install;apt update;apt upgrade -y;apt dist-upgrade -y;apt autoremove -y;apt autoclean;apt purge -y;cd /usr/share/exploitpack;git pull;cd /usr/share/TheFatRat;git pull;sniper update;openvas-feed-update;freshclam;cd ~/'


                                                                                                                                                    
# Banner
banner='''
	        乂⍲‿⍲乂 (◑‿◑)ɔ   ℂ𝕪𝕓𝕖𝕣 𝕃𝕒𝕪𝕖𝕣   ✍(◔◡◔)  乂⍲‿⍲乂 
'''  

echo ""
echo "$banner" | while read line
  do
          echo -en "$yellow\t$line$end\r"
          sleep 0.0
          echo -e "\e[94m"
  done
  printf '''\e[91m                                             ッ   シ  シ  シ  ヅ   ツ  ッ  シ  シ  ヅ 
   		\n'''




