export iauLteqec
"""
Transformation from ICRS equatorial coordinates to ecliptic
coordinates (mean equinox and ecliptic of date) using a long-term
precession model.

This function is part of the International Astronomical Union's
SOFA (Standards of Fundamental Astronomy) software collection.

Status:  support function.

Given:
   epj     double     Julian epoch (TT)
   dr,dd   double     ICRS right ascension and declination (radians)

Returned:
   dl,db   double     ecliptic longitude and latitude (radians)

   1. No assumptions are made about whether the coordinates represent
   starlight and embody astrometric effects such as parallax or
   aberration.

   2. The transformation is approximately that from mean J2000.0 right
   ascension and declination to ecliptic longitude and latitude
   (mean equinox and ecliptic of date), with only frame bias (always
   less than 25 mas) to disturb this classical picture.

   3. The Vondrak et al. (2011, 2012) 400 millennia precession model
   agrees with the IAU 2006 precession at J2000.0 and stays within
   100 microarcseconds during the 20th and 21st centuries.  It is
   accurate to a few arcseconds throughout the historical period,
   worsening to a few tenths of a degree at the end of the
   +/- 200,000 year time span.

Called:
   iauS2c       spherical coordinates to unit vector
   iauLtecm     J2000.0 to ecliptic rotation matrix, long term
   iauRxp       product of r-matrix and p-vector
   iauC2s       unit vector to spherical coordinates
   iauAnp       normalize angle into range 0 to 2pi
   iauAnpm      normalize angle into range +/- pi

References:

   Vondrak, J., Capitaine, N. and Wallace, P., 2011, New precession
   expressions, valid for long time intervals, Astron.Astrophys. 534,
   A22

   Vondrak, J., Capitaine, N. and Wallace, P., 2012, New precession
   expressions, valid for long time intervals (Corrigendum),
   Astron.Astrophys. 541, C1

This revision:  2016 February 9

SOFA release 2018-01-30

Copyright (C) 2018 IAU SOFA Board.  See notes at end.
"""

# void iauLteqec(double epj, double dr, double dd, double *dl, double *db)

function iauLteqec(epj::Real, dr::Real, dd::Real)
   ref_dl = Ref{Float64}(0.0)
   ref_db = Ref{Float64}(0.0)
   ccall((:iauLteqec, libsofa_c), Cvoid, 
         (Cdouble, Cdouble, Cdouble,
         Ref{Cdouble}, Ref{Cdouble}), 
          convert(Float64, epj),
          convert(Float64, dr),
          convert(Float64, dd),
          ref_dl, ref_db)

   return ref_dl[], ref_db[]
end