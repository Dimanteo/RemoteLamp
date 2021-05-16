AVRASM := /mnt/c/Home/MC/AVR studio/AvrAssembler2/avrasm2.exe

all : receiver transmitter

receiver : receiver.asm

transmitter : transmitter.asm

% : %.asm
	"$(AVRASM)" -S "$@/labels.tmp" -fI -W+ie -C V2 -o "$@.hex" -d "$@.obj" -e "$@.eep" -m "$@.map" "$<"

.PHONY : clean
clean :
	rm -rf *.hex *.obj *.map