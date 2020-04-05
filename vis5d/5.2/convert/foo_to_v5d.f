C foo_to_v5d.f

C This is a skeleton conversion program for converting your data format
C to VIS-5D's v5d format (which is directly read by vis5d).

C This version only allows a rectangular lat/lon projection and equally
C spaced vertical levels in km.  See foo2_to_v5d for more advanced
C options.

C You need to insert code to do two things:
C     1. Open your input file and read the header information, putting
C        that information into the required variables.  If your file
C        doesn't contain some of the needed values you can just assign
C        constants to the variables.
C     2. read your grid data into the array G for each timestep and
C        variable.

C Pay special attention to comments in UPPERCASE.  They give more
C information about what you have to do.

C The rest of the program will handle creating the v5d file, writing the
C grid data, and closing the file.

C Compile this program with the foo_to_v5d.f.m makefile.
C Run this program with two arguments:  the name of your input file and
C the name of the v5d output file.



      program foo_to_v5d
      implicit none
      include "../src/v5df.h"
      integer iargc
c     Local vars
      integer n
      real*4 G(MAXROWS, MAXCOLUMNS, MAXLEVELS)
      character*100 inname, outname


C  THE FOLLOWING VARIABLES DESCRIBE THE DATASET TO BE CONVERTED.  YOU
C  MUST INITIALIZE ALL THESE VARIABLES WITH VALUES FROM YOUR FILE OR
C  ASSIGN SUITABLE CONSTANTS.  SEE THE README FILE FOR DESCRIPTIONS
C  OF THESE VARIABLES.
      integer nr, nc, nl
      integer numtimes
      integer numvars
      character*10 varname(MAXVARS)
      integer dates(MAXTIMES)
      integer times(MAXTIMES)
      real northlat
      real latinc
      real westlon
      real loninc
      real bottomhgt
      real hgtinc


c     initialize the variables to missing values
      data nr,nc,nl / IMISSING, IMISSING, IMISSING /
      data numtimes,numvars / IMISSING, IMISSING /
      data (varname(i),i=1,MAXVARS) / MAXVARS*"          " /
      data (dates(i),i=1,MAXTIMES) / MAXTIMES*IMISSING /
      data (times(i),i=1,MAXTIMES) / MAXTIMES*IMISSING /
      data northlat, latinc / MISSING, MISSING /
      data westlon, loninc / MISSING, MISSING /
      data bottomhgt, hgtinc / MISSING, MISSING /

c     get command line arguments
      if (iargc() .ne. 2) then
         print *,"Error:  two filename arguments are needed."
         call exit(1)
      else
         call getarg(1, inname)
         call getarg(2, outname)
      endif
      print 10,"Input file: ", inname
      print 10,"Output file: ", outname
 10   format (A,A)


C  OPEN YOUR DATAFILE (inname) HERE AND READ ITS HEADER INFORMATION TO
C  INITIALIZE THE ABOVE VARIABLES.





C                           INSERT CODE HERE







C  IF YOU FAIL TO INITIALIZE SOME VARIABLES, THEY WILL BE DETECTED AND
C  REPORTED BY THE V5D LIBRARY.

c     Create the v5d file.
      n = v5dcreatesimple( outname, numtimes, numvars, nr, nc, nl,
     *                 varname, times, dates,
     *                 northlat, latinc, westlon, loninc,
     *                 bottomhgt, hgtinc )
      if (n .eq. 0) then
         call exit(1)
      endif

c     enter the conversion subroutine
      call convert( nr, nc, nl, numtimes, numvars, G )

c     close the v5d file and exit
      n = v5dclose()
      if (n .eq. 0) then
c        failed
         call exit(1)
      else
c        success
         call exit(0)
      endif

      end




c     Read 3-D grids from input file, write them to the output file.
      subroutine convert( nr, nc, nl, numtimes, numvars, G )
      implicit none
      include "../src/v5df.h"
c     Arguments
      integer nr
      integer nc
      integer nl
      integer numtimes
      integer numvars
      real*4 G(nr, nc, nl)
c     Local vars
      integer it, iv, n

      do it=1,numtimes
         do iv=1,numvars


C  READ YOUR DATA FOR TIME STEP NUMBER IT AND VARIABLE NUMBER IV INTO
C  THE ARRAY G HERE.  NOTE THAT G(1,1,1) IS THE NORTH WEST BOTTOM CORNER
C  AND G(NR,NC,NL) IS THE SOUTH EAST TOP CORNER.  ALSO, THE LOOPS CAN
C  BE CHANGED TO WORK IN ANY ORDER, THE v5dwrite CALL WILL STILL WORK.
C  VALUES GREATER THEN 1.0E30 ARE CONSIDERED TO BE 'MISSING'.






C                           INSERT CODE HERE






c           write the 3-D grid to the v5d file
            n = v5dwrite( IT, IV, G )
            if (n .eq. 0) then
c              error
               call exit(1)
            endif
         enddo
      enddo

      end
