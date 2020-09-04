function [R,V]=r0v02rv(R0,V0,t)
%------------------------------------------------------------------------%
%  This function computes the state vector(R,V) form the initial state
%vector(R0,V0) and elapsed time.
%
%mu - gravitational parameter(kg^3/s^2)
%R0 - initial position vector(km)
%V0 - initial velocity vector(km/s)
% t - elapsed time(s)
% R - final position vector(km)
% V - final velocity vector(km/s)
%
%User M-functions required:kepler_U, f_and_g,fDot_and_gDot
%------------------------------------------------------------------------%

