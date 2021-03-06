/* resample.h */
/* Vis5D version 5.2 */

/*
Vis5D system for visualizing five dimensional gridded data sets
Copyright (C) 1990 - 2000 Bill Hibbard, Johan Kellum, Brian Paul,
Dave Santek, and Andre Battaiola.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 1, or (at your option)
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/


#ifndef RESAMPLE_H
#define RESAMPLE_H


#include "grid_i.h"



/*
 * A resampler struct carries the information needed to resample a 3-D
 * grid from one projection and VCS to a new projection and VCS.
 * We perform vertical resampling first, then horizontal resampling.
 */
struct resampler {

   struct projection *inproj;        /* Input projection */
   struct vcs *invcs;                /* Input VCS */
   struct projection *outproj;       /* Output projection */
   struct vcs *outvcs;               /* Output VCS */

   /*
    * These values indicate the size of the dynamic arrays below:
    */
   int inR, inC, inL;     /* size of input grid */
   int outR, outC, outL;  /* size of output grid */

   /*
    * For a given level in the output grid, Level indicates which
    * data values to sample in the input grid.  The Coef values are
    * the weights to use in the resampling.  The arrays are also
    * indexed by (row,col) to allow sigma coordinates (relative to
    * topography).
    */
   int DoVertical;        /* Is vertical resampling needed? */
   float *SampLev;        /* SampLev[outL][inR][inC] */

   /*
    * For a given (row,col) in the output grid, RectRow and RectCol
    * indicates which data values to sample in the input grid.  The
    * Coef_s and Coef_t values are the weights to use in the sampling.
    */
   int DoHorizontal;      /* Is horizontal resampling needed? */
   float *SampRow;        /* SampRow[outR][outC] */
   float *SampCol;        /* SampCol[outR][outC] */

   int Guard;             /* how many boundary rows & cols to discard */
};




extern struct resampler *get_resampler( struct projection *inproj,
                                        struct vcs *invcs,
                                        struct projection *outproj,
                                        struct vcs *outvcs,
                                        int outnl );


extern void free_resamplers( void );


extern void resample_vertical( struct resampler *r,
                               float *indata, float *outdata );


extern void resample_horizontal( struct resampler *r,
                                 float *indata, float *outdata );


#endif

