clc
clear 
% close all;
mhSun = 398600E9;     % 单位  m^3/s^2
LUnit = 6378E3;       % 单位  m
TUnit = sqrt(LUnit*LUnit*LUnit/mhSun); % 单位 s
VUnit = LUnit/TUnit;  % m/s
AUnit = VUnit/TUnit;  % m/s^2
MUnit = 4330;           % kg;
IspPg0 = 315*9.80655; % 发动机喷射速率 m/s
Tmax   = 490;           % 3.3; % N
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
hp0    = 200E3;
ha0    = 40000E3;
a00     = (ha0+hp0)/2+LUnit;
e00     = (ha0+LUnit)/a00-1;
inc00   = 51*deg;
omega00  = 11*deg;
w00     = 225*deg;
theta00 = theta0;
coe0    = [a00;e00;inc00;omega00;w00;theta00];
% 目标轨道参数(经典轨道根数坐标系下)
hpf     = 1500E3;
haf     = 38850E3;
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


equini = [R0UN;V0UN;m0];
equfinal = [RfUN;VfUN];

% lambda0 =[0.5875  0.0026  0.0092  0.0117 -0.0307  0.1146  0.1259  0.7904]';% TOF = 32;
% lambda0 =[0.4865 -0.0201 -0.0114 -0.0173  -0.0071 -0.0908 -0.8494 0.1806]';TOF = 68; epsilon = 0.5;
% lambda0 =[0.4686 -0.0148 -0.0087 -0.0159  0.0532 -0.0589 -0.8576 0.1949]';TOF = 68; epsilon = 0.2;
% lambda0 =[0.4754 -0.0124 -0.0075 -0.0150  0.0805 -0.0388 -0.8520 0.1990]';TOF = 68; epsilon = 0.1;
% lambda0 =[0.4778 -0.0118 -0.0074 -0.0147  0.0862 -0.0347 -0.8503 0.1993]';TOF = 68; epsilon = 0.05;
% lambda0 =[0.4779 -0.0119 -0.0075 -0.0146  0.0859 -0.0334 -0.8505  0.1985]';TOF = 68; epsilon = 0.01;
% lambda0 =[0.478129248030773  -0.011898096071096  -0.007493210621768  -0.014640500685143...
%     0.085855371419004  -0.034147920337261  -0.850256078054313 0.198764265931482]';TOF = 68; epsilon = 0.001;
lambda0 = [0.478156476956799  -0.011895759471696  -0.007488802276818  -0.014642634986813...
    0.085888761686516  -0.034155878540751  -0.850230837048775 0.198791830051763]';TOF = 68; epsilon = 0.0001;
% lambda0 = [0.482185927130570  -0.010404562186604  -0.006552230890422  -0.014145023293093   0.100065706479853...
%     -0.015566963704961  -0.846509339904480   0.200924446979926]';TOF = 67; epsilon = 0.0001;
% lambda0 = [0.473404721597674  -0.013335302695674  -0.008644043247467  -0.015134152501569   0.069676393744246...
%     -0.052961358731656  -0.853936866995761   0.196418816111559]';TOF = 69; epsilon = 0.0001;
% lambda0 =[0.6320    0.0039    0.0044   -0.0086    0.1792    0.1786   -0.7138    0.2145]';TOF = 102; epsilon = 0.5;
% lambda0 =[0.4981   -0.0068   -0.0050   -0.0136    0.0833    0.0713   -0.8348    0.2122]';TOF = 100; epsilon = 0.1;
% lambda0 =[0.4970   -0.0069   -0.0036   -0.0124    0.1044    0.0826   -0.8323    0.2066]';TOF = 100; epsilon = 0.01;
% lambda0 =[0.504955615990381  -0.006906503577780  -0.002230577497262  -0.012797658791804   0.114433136755704...
%     0.076784441704881  -0.824309035432479    0.215309036737390]';TOF = 100; epsilon = 0.001;
% lambda0 =[0.484120199860208  -0.013013463920176  -0.007063008128632  -0.014985725171500   0.064872591800326...
%     -0.020093867065655  -0.848331826001909   0.202249154427159]';TOF = 108; epsilon = 0.001;
% lambda0 =[0.484120732104669  -0.013013361729489  -0.007063094191126  -0.014985845079158   0.064871163005827...
%     -0.020094146100629  -0.848331640205798   0.202249084148616]';TOF = 108; epsilon = 0.00001;
% lambda0 =[0.481549978730904  -0.013615825981003  -0.007632268434576  -0.015218488332778   0.058393772586860...
%     -0.029798104489786  -0.850303228819833   0.200800977784949]';TOF = 109; epsilon = 0.00001;
% lambda0 =[0.479003570903803  -0.014195440169035  -0.008187979064647  -0.015450078224366   0.051908703659776...
%     -0.039202264387116  -0.852086391353603   0.199413876348623]';TOF = 110; epsilon = 0.00001;

soloptions = optimset('Display', 'iter');
options = odeset('RelTol', 1e-10, 'AbsTol', 1e-10);
lam0 = lambda0(1);
lamrvm = lambda0(2:8);
yini = [equini;lamrvm];
[t,y] = ode45(@dynamics,[0,TOF],yini,options,epsilon,lam0,parameters);
for i = 1:length(y)
[u(i),Alpha(i,:)]=getcontrol(y(i,:),epsilon,lam0,parameters);
end
ytml = y(end,:);
lamm = ytml(14);
out = [ytml(1:6)'-equfinal;lamm;norm(lambda0,2)-1];
%%
for i = 1:length(y)
ycoe(i,:) = sv2coe(y(i,1:3),y(i,4:6),mhSunNU);
end
%%
colr = 'r';
colb = 'b';
colk = 'k';
fw   = 'normal';
figure(1)
EarthPlot
plot3(y(:,1)*LUnit/1000,y(:,2)*LUnit/1000,y(:,3)*LUnit/1000,'LineWidth',1,'Color','b','LineStyle','-');
quiver3(y(:,1)'*LUnit/1000,y(:,2)'*LUnit/1000,y(:,3)'*LUnit/1000,u.*Tmax.*Alpha(:,1)',u.*Tmax.*Alpha(:,2)',u.*Tmax.*Alpha(:,3)','LineWidth',2,'Color','r');
grid on;
hold on;
axis equal
tl = title('轨道演化变化图');
xl = xlabel('X轴/km');
yl = ylabel('Y轴/km');
zl = zlabel('Z轴/km');
set(xl, 'FontSize',12,'FontWeight',fw);
set(yl, 'FontSize',12,'FontWeight',fw);
set(zl, 'FontSize',12,'FontWeight',fw);
set(gca, 'FontSize',12,'FontWeight',fw);
%%
figure(2)
plot(t*TUnit/3600,u*Tmax,'LineWidth',2,'Color',colr,'LineStyle','-');grid on;hold on;
xl = xlabel('时间/小时');  
yl = ylabel('推力大小/N');  
set(xl, 'FontSize',12,'FontWeight',fw);
set(yl, 'FontSize',12,'FontWeight',fw);
title('推力大小变化图');
set(gca, 'FontSize',12,'FontWeight',fw);
figure(3)
tl = title('推力方向变化图');
set(tl, 'FontSize',14,'FontWeight',fw);
hold on;
subplot(3,1,1)
plot(t*TUnit/3600,Alpha(:,1)/deg,'LineWidth',1,'Color',colk,'LineStyle','-');
grid on;
xlabel('时间/小时');ylabel('\alpha_1(deg)'); 
set(gca, 'FontSize',12,'FontWeight',fw);
subplot(3,1,2)
plot(t*TUnit/3600,Alpha(:,2)/deg,'LineWidth',1,'Color',colk,'LineStyle','-');
grid on;
xlabel('时间/小时');ylabel('\alpha_2(deg)'); 
set(gca, 'FontSize',12,'FontWeight',fw);
subplot(3,1,3)
plot(t*TUnit/3600,Alpha(:,3)/deg,'LineWidth',1,'Color',colk,'LineStyle','-');
grid on;
xlabel('时间/小时');ylabel('\alpha_3(deg)');  
set(gca, 'FontSize',12,'FontWeight',fw);
figure(4)
plot(t*TUnit/3600,m0*MUnit-y(:,7)*MUnit,'LineWidth',2,'Color',colr,'LineStyle','-');grid on;
xlabel('时间/小时');ylabel('消耗燃料(kg)');  
set(gca, 'FontSize',12,'FontWeight',fw);
figure(5);
plot(t*TUnit/3600,ycoe(:,6)/deg,'LineWidth',2,'Color',colb,'LineStyle','-');
xlabel('时间/小时');ylabel('真近点角(deg)');  
set(gca, 'FontSize',12,'FontWeight',fw);
grid on;