      parameter (maxiu=10,maxgb=10,maxlen=400000)

      logical trace
      common /debug/trace

      common /gosubstack/nlold(10),idnl
  
      integer kunit(maxiu),ncampi(maxgb)
      logical opened(maxiu)
      byte grib(maxlen,maxgb)
      common /grib/kunit,opened,grib,ncampi
  
      character mode*1,filein*80
      integer idunit
      common /openclose/idunit,mode,filein
  
      integer key(15)
      common /keyc/key
  
  
