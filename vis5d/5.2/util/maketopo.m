# Makefile for maketopo program

# Usage:
#   make -f maketopo.m




CC = cc
CFLAGS = -c -g
LIBS = -lm


# uncomment the the "CC" "CFLAGS" and "LIBS" for your computer

#--- irix4, irix5, cray, sunos4, sunos5 ---
#CC = cc
#CFLAGS = -c -O 
#LIBS = -lm

#--- irix6 ---
#CC = cc
#CFLAGS = -c -32 -O2 -woff all
#LIBS = -lm

#--- irix6 mips4 ---
#CC = cc
#CFLAGS =-c -n32 -O2 -woff all
#LIBS = -lm

#--- dec, alpha ---
#CC = cc
#CFLAGS = -O -c -DLITTLE
#LIBS = -lm

#--- cray ---
#CC = cc
#CFLAGS =
#LIBS = -lm

#--- freebsd ---
#CC = gcc
#CFLAGS = -pipe -O2 -c -DLITTLE
#LIBS = -lm

#--- hp ---
#CC = cc
#CFLAGS = -c -Aa -O
#LIBS = -lm

#--- ibm ---
#CC = cc
#CFLAGS = -c -O -w
#LIBS = -lm

#--- linux ---
#CC = gcc
#CFLAGS = -c -pipe -O2 -m486 -DLITTLE
#LIBS = -lm



maketopo: maketopo.o binio.o
	$(CC) maketopo.o binio.o $(LIBS) -o maketopo

maketopo.o: maketopo.c ../src/binio.h
	$(CC) $(CFLAGS) -I../src maketopo.c

binio.o: ../src/binio.c
	$(CC) $(CFLAGS) ../src/binio.c -o $@

