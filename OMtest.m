clear
clc
LUnit = 6378;       % 单位  km
deg = pi/180;
mu = 398600;
theta0 = 160*deg;  %约束可观测的真近角范围
thetaf = 205*deg;
% 初始轨道参数(经典轨道根数坐标系下)
hp0     = 300;
ha0     = 42000;
a00     = (ha0+hp0)/2+LUnit;
e00     = (ha0+LUnit)/a00-1;
inc00   = 51*deg;
omega00 = 11*deg;
w00     = 225*deg;
theta00 = theta0;
coe0    = [a00;e00;inc00;omega00;w00;theta00];
% 目标轨道参数(经典轨道根数坐标系下)
hpf     = 1800;
haf     = 38000;
aff     = (haf+hpf)/2+LUnit;
eff     = (haf+LUnit)/aff-1;
incff   = 63.4*deg;
omegaff = 11*deg;
wff     = 270*deg;
thetaff = thetaf;
coef    = [aff;eff;incff;omegaff;wff;thetaff];

[r0, v0] = coe2sv(coe0,mu);
[rf, vf] = coe2sv(coef,mu);

%...Echo the input data and output the results to the command window:
fprintf('---------------------------------------------------')
fprintf('\n Gravitational parameter (km^3/s^2)  = %g\n', mu)
fprintf('\n semimajor axis (km)                 = %g', a00)
fprintf('\n Eccentricity                        = %g', e00)
fprintf('\n Right ascension (deg)               = %g', omega00)
fprintf('\n Argument of perigee (deg)           = %g', w00)
fprintf('\n True anomaly (deg)                  = %g', theta00)
fprintf('\n\n State vector:')
fprintf('\n     r (km)      = [%g %g %g]', r0(1), r0(2), r0(3))
fprintf('\n     v (km/s)    = [%g %g %g]', v0(1), v0(2), v0(3))
fprintf('\n-----------------------------------------------\n')
