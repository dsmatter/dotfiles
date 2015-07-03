Useful substitutions:
FLAC_FILES = $(shell find flac/ -type f -name '*.flac')
MP3_FILES = $(patsubst flac/%.flac, mp3/%.mp3, $(FLAC_FILES))

Variables:
$@  The name of the target.
$%  The target member name, when the target is an archive member.
$<  The name of the first (or only) prerequisite.
$?  The names of all the prerequisites that are newer than the target, with spaces between them.
$^
$+  The names of all the prerequisites, with spaces between them. The value of $^ omits duplicate prerequisites, while $+ retains them and preserves their order.
$*  The stem with which an implicit rule matches.
$(@D)
$(@F)   The directory part and the file-within-directory part of $@
$(*D)
$(*F)   The directory part and the file-within-directory part of $*
$(%D)
$(%F)   The directory part and the file-within-directory part of $%
$(<D)
$(<F)   The directory part and the file-within-directory part of $<
$(^D)
$(^F)   The directory part and the file-within-directory part of $^
$(+D)
$(+F)   The directory part and the file-within-directory part of $+
$(?D)
$(?F)   The directory part and the file-within-directory part of $?
