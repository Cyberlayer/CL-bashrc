#How to Install

git clone https://github.com/Cyberlayer/cyberlayer-bashrc.git

cd cyberlayer-bashrc

chmod +x install.sh

./install.sh

#How to use (They are list of alies you can do this )



#============================================================                                                                                                         
#                                                                                                                                                                     
#  ALIASES AND FUNCTIONS                                                                                                                                                                                                                                                              
#                                                                                                                                                                     
#============================================================                                                                                                         

# Some more alias to avoid making mistakes:
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'
                                                                                                                                                                                                                                                                                                                                 
# some more ls aliases
 alias ll='ls -lh'
 alias la='ls -lha'
 alias l='ls -CF'
 alias dd='dd status=progress'
                                                                                                                                                  
# Personnal Aliases                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
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
                                                                                                      
# The 'ls' family (this assumes you use a recent GNU ls).                                                                                                                                                                                                                                                                                                                 
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
# Personnal and keyboard-dependent :-)                                                                                                                                                                                                                

 alias ports='netstat -tulanp' #show open ports
 alias meminfo='free -m -l -t' 
 alias spell='enchant -a -l' 
 alias killme='cd ~/;rm -rf ~/.safe & cleanme;mkdir ~/.safe;changeme'    
 alias cleanme='killall firefor-esr;sync; echo 1> /proc/sys/vm/drop_caches;sync; echo 2 > /proc/sys/vm/drop_cache;sync; echo 3 > /proc/sys/vm/drop_caches;history -c;bleachbit -c --preset;clear'
 alias powerstart='dpkg --configure -a;apt -f install;apt update;apt upgrade -y;apt dist-upgrade -y;apt autoremove -y;apt autoclean;apt purge -y;cd /usr/share/exploitpack;git pull;cd /usr/share/TheFatRat;git pull;sniper update;openvas-feed-update;freshclam;cd ~/'


