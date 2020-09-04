function [coe]=sv2coe(R,V,mu)
% Computes the classical orbital elements(coe) form the state vector(R,V)
%
% mu    - gravitational parameter (km^3/s^2)
% R     - position vector in the geocentric equatorial frame (km)
% V     - velocity vector in the geocentric equatorial frame (km)
% r, v  - the magnitudes of R and V
% vr    - radial velocity component (km/s)
% H     - the angular momentum vector (km^2/s)
% h     - the magnitude of H (km^2/s)
% incl  - inclination of the orbit (rad)
% N     - the node line vector (km^2/s)
% n     - the magnitude of N
% cp    - cross product of N and R
% Omega - right ascension of the ascending node (rad)
% E     - eccentricity vector
% e     - eccentricity (magnitude of E)
% eps   - a small number below which the eccentricity is considered to be zero
% w     - argument of perigee (rad)
% Theta - true anomaly (rad)
% a     - semimajor axis (km)
% pi    - 3.1415926...
% coe   - vector of orbital elements [a e incl Omega w Theta]
%
% User M-functions required: None
% ------------------------------------------------------------
%   This .m file was from Appendix D of the book:
%       <Orbit Mechanics for engineering Students> (Howard D. Curtis)
%   You could get appendix D from: http://books.elsevier.com/companions
% ------------------------------------------------------------
%   Last Edit by:           Huan Jiang   2018/07/19
% ------------------------------------------------------------
eps = 1.e-10;

r = norm(R);
v = norm(V);

vr = dot(R,V)/r;

H = cross(R,V);
h = norm(H);

%...Equation 4.7:
incl = acos(H(3)/h);

%...Equation 4.8:
N = cross([0 0 1],H);
n = norm(N);

%...Equation 4.9:
if n~= 0
    Omega = acos(N(1)/n);
    if N(2) < 0
        Omega = 2*pi - Omega;
    end
else
    Omega = 0;
end

%...Equation 4.10:
E = 1/mu*((v^2 - mu/r)*R - r*vr*V);
e = norm(E);

%...Equation 4.12 (incorporating the case e = 0):
if n~= 0
    if e > eps
        w = acos(dot(N,E)/n/e);
        if E(3) < 0
            w = 2*pi - w;
        end
    else
        w = 0;
    end
else
    w = 0;
end

%...Equation 4.13a (incorporating the case e = 0):
if e > eps
    Theta = acos(dot(E,R)/e/r);
    if vr < 0
        Theta = 2*pi - Theta;
    end
else
    cp = cross(N,R);
    if cp(3) >= 0
        Theta = acos(dot(N,R)/n/r);
    else
        Theta = 2*pi - acos(dot(N,R)/n/r);
    end
end

%...Equation 2.61 (a < 0 for a hyperbola):
a = h^2/mu/(1 - e^2);
coe = [a;e;incl;Omega;w;Theta];
