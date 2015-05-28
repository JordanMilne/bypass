#include "buffer.h"

#include <ctype.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>

#define READ_UNIT 1024
#define OUTPUT_UNIT 64

#include "parser.h"


int
main(int argc, char **argv)
{

	struct buf *ib;
	int size_read = 0, i = 0, have_errors = 0;

	/* reading everything */
	ib = bufnew(READ_UNIT);
	bufgrow(ib, READ_UNIT);
	while ((size_read = fread(ib->data + ib->size, 1, ib->asize - ib->size, stdin)) > 0) {
		ib->size += size_read;
		bufgrow(ib, ib->size + READ_UNIT);
	}
	// do something with the buffer
	Bypass::Parser parser;
        Bypass::Document document = parser.parse(bufcstr(ib));

	bufrelease(ib);
	return 0;
}
