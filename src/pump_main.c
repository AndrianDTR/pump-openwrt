/*
 * IxNpeMicrocode.h - Headerfile for compiling the Intel microcode C file
 *
 * Copyright (C) 2006 Christian Hohnstaedt <chohnstaedt@innominate.com>
 *
 * This file is released under the GPLv2
 *
 *
 * compile with
 *
 * gcc -Wall IxNpeMicrocode.c -o IxNpeMicrocode
 *
 * Executing the resulting binary on your build-host creates the
 * "NPE-[ABC].xxxxxxxx" files containing the selected microcode
 *
 * fetch the IxNpeMicrocode.c from the Intel Access Library.
 * It will include this header.
 *
 * select Images for every NPE from the following
 * (used C++ comments for easy uncommenting ....)
 */

#include <stdio.h>

int main(int argc, char *argv[])
{
	printf("Hello from pump");
	return 0;
}
