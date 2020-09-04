clc
clear 
close all;
format long;
mhSun = 398600E9;     % 单位  m^3/s^2
LUnit = 6378E3;       % 单位  m
TUnit = sqrt(LUnit*LUnit*LUnit/mhSun); % 单位 s
VUnit = LUnit/TUnit;  % m/s
AUnit = VUnit/TUnit;  % m/s^2
MUnit = 9000;           % kg;
IspPg0 = 400*9.80655; % 发动机喷射速率 m/s
Tmax   = 500;           % 3.3; % N
IspPg0NU = IspPg0/VUnit;
mhSunNU  = (mhSun/LUnit)*(TUnit/LUnit)*(TUnit/LUnit);
TmaxNU   = Tmax/(MUnit*AUnit);
parameters.miuE = mhSunNU;
parameters.IspPg0 = IspPg0NU;
parameters.Tmax = TmaxNU;

deg = pi/180;
theta0 = 160*deg;  %约束可观测的真近角范围
thetaf = 205*deg;
% 初始轨道参数(经典轨道根数坐标系下)
hp0     = 300E3;
ha0     = 42000E3;
a00     = (ha0+hp0)/2+LUnit;
e00     = (ha0+LUnit)/a00-1;
inc00   = 51*deg;
omega00  = 11*deg;
w00     = 225*deg;
theta00 = theta0;
coe0    = [a00;e00;inc00;omega00;w00;theta00];
% 目标轨道参数(经典轨道根数坐标系下)
hpf     = 1800E3;
haf     = 38000E3;
aff     = (haf+hpf)/2+LUnit;
eff     = (haf+LUnit)/aff-1;
incff   = 63.4*deg;
omegaff  = 11*deg;
wff     = 270*deg;
thetaff = thetaf;
coef    = [aff;eff;incff;omegaff;wff;theta00];

[R0, V0] = coe2sv(coe0,mhSun);
R0UN = R0./LUnit;
V0UN = V0./VUnit;
[Rf, Vf] = coe2sv(coef,mhSun);
RfUN = Rf./LUnit;
VfUN = Vf./VUnit;
m0 = 1;


%%
equini = [R0UN;V0UN;m0];
equfinal = [RfUN;VfUN];
lambda0 =[0.4970   -0.0069   -0.0036   -0.0124    0.1044    0.0826   -0.8323    0.2066]';
TOF = 100; 
epsilon = 0.01;

soloptions = optimset('Display', 'iter');
options = odeset('RelTol', 1e-10, 'AbsTol', 1e-10);
[X,FVAL,EXITFLAG,OUTPUT,JACOB] = fsolve(@shooting,lambda0,soloptions,equini,equfinal,TOF,options,epsilon,parameters);
out = shooting(X,equini,equfinal,TOF,options,epsilon,parameters);

