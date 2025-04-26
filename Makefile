ASM = nasm
ASM_FLAGS = -f elf32
LD = ld 
LD_FLAGS = -m elf_i386

#CAMBIAR ESTO DEPENDIENDO DE CUAL .ASM QUIERO COMPILAR
TARGET = conway

all: $(TARGET)

$(TARGET).o: $(TARGET).asm 
	$(ASM) $(ASM_FLAGS) $< -o $@

$(TARGET): $(TARGET).o
	$(LD) $(LD_FLAGS) $< -o $@

clean:
	rm -f $(TARGET) *.o

run: $(TARGET)
		./$(TARGET)

.PHONY: all clean run