# makefile for sample.c conversion program

# The input to the conversion program is your 5-D grid format.  The ouput
# is a McIDAS grid file.  The McIDAS grid file is then converted/compressed
# to vis5d's format with comp5d.


# By default, the name of the conversion program is 'sample'.  You should
# probably use a better name.  Assign that name to PROGRAM here:
PROGRAM = sample


# If DEC, add -DLITTLE to CFLAGS
# If DEC or Linux, (Little-endian), add -DLITTLE to CFLAGS
CFLAGS = -c -g
CC = cc
LIBS = -lm


$(PROGRAM): $(PROGRAM).o binio.o
	$(CC) $(PROGRAM).o binio.o $(LIBS) -o $@

$(PROGRAM).o: $(PROGRAM).c ../src/binio.h
	$(CC) $(CFLAGS) -I../src $(PROGRAM).c

binio.o: ../src/binio.c
	$(CC) $(CFLAGS) ../src/binio.c -o $@
