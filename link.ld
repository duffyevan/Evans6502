MEMORY {
  ram:
	start = $0,
	size = $6000,
	file = "";

  rom:
	start = $8000,
	size = $8000,
	file = "kernel.rom";

}
SEGMENTS {
	KERNEL:
		load = rom,
		type = ro;
	CODE:
		load = rom,
		type = ro;
	BSS:
		load = ram,
		type = bss;
	DATA:
		load = rom,
		type = ro;
	RODATA:
		load = rom,
		type = ro;
}
