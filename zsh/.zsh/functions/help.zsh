# A quick globbing reference, stolen from GRML (and modified).
help-glob() {
zle -M "
/      directories
.      plain files
@      symbolic links
=      sockets
p      named pipes (FIFOs)
*      executable plain files (0100)
%      device files (character or block special)
%b     block special files
%c     character special files
r      owner-readable files (0400)
w      owner-writable files (0200)
x      owner-executable files (0100)
A      group-readable files (0040)
I      group-writable files (0020)
E      group-executable files (0010)
R      world-readable files (0004)
W      world-writable files (0002)
X      world-executable files (0001)
s      setuid files (04000)
S      setgid files (02000)
t      files with the sticky bit (01000)
print *(m-1)          # Dateien, die vor bis zu einem Tag modifiziert wurden.
print *(a1)           # Dateien, auf die vor einem Tag zugegriffen wurde.
print *(@)            # Nur Links
print *(Lk+50)        # Dateien die ueber 50 Kilobytes grosz sind
print *(Lk-50)        # Dateien die kleiner als 50 Kilobytes sind
print **/*.c          # Alle *.c - Dateien unterhalb von \$PWD
print **/*.c~file.c   # Alle *.c - Dateien, aber nicht 'file.c'
print (foo|bar).*     # Alle Dateien mit 'foo' und / oder 'bar' am Anfang
print *~*.*           # Nur Dateien ohne '.' in Namen
chmod 644 *(.^x)      # make all non-executable files publically readable
print -l *(.c|.h)     # Nur Dateien mit dem Suffix '.c' und / oder '.h'
print **/*(g:users:)  # Alle Dateien/Verzeichnisse der Gruppe >users<
echo /proc/*/cwd(:h:t:s/self//) # Analog zu >ps ax | awk '{print $1}'<"
}

help-conf() {
  zle -M "
    Klonen nach ~/.configs.git:
    conf clone --bare smserver:configs.git .configs.git
    conf config core.bare false
    conf config core.worktree $HOME
    conf remote rm origin
    conf remote add origin smserver:configs.git
    conf reset master

    Lokale Änderungen übernehmen:
    conf checkout -b local
    conf diff
    conf add/commit/...

    Änderungen nach Master übernehmen:
    conf checkout master 
    conf cherrry-pick ...
    conf rebase master local
    conf push origin master

    gitk -all"
}

zle -N help-glob
zle -N help-conf

