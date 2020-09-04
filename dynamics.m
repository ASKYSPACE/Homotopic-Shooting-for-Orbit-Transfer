function dY = dynamics(t,Y,epsilon,lam0,parameters)



miuE = parameters.miuE;
IspPg0  = parameters.IspPg0;
Tmax = parameters.Tmax;
x  = Y(1);
y  = Y(2);
z  = Y(3);
vx = Y(4);
vy = Y(5);
vz = Y(6);
m  = Y(7);
lamx = Y(8);
lamy  = Y(9);
lamz  = Y(10);
lamvx = Y(11);
lamvy = Y(12);
lamvz = Y(13);
lamm  = Y(14);
% lam0 = abs(lam0);
if m<0.2
    m = 0.2;
end

R = [x;y;z];
V = [vx;vy;vz];
r = norm(R,2);
v = norm(V,2);
% SF
Lamv = [lamvx,lamvy,lamvz];
rou = 1-IspPg0*norm(Lamv,2)/(lam0*m)-lamm/lam0;
% u
if rou>abs(epsilon)
    u = 0;
elseif rou<-abs(epsilon)
    u = 1;
elseif  abs(rou)<= abs(epsilon)
    u = 0.5-0.5*rou/epsilon;
else
%     error('parameter epsilon mistake!');
    u = 0;
end
tul = 20;tuu =50;
% if tul <= t&&t <=tuu
%     u = 0;
% end
% Optimal Thrust Direction
Alpha = -Lamv/norm(Lamv,2);

% Orbit Equations and Costate Equations
dY(1)  = vx;
dY(2)  = vy;
dY(3)  = vz;
dY(4)  = -miuE*x/r^3 + Tmax*u*Alpha(1)/m;
dY(5)  = -miuE*y/r^3 + Tmax*u*Alpha(2)/m;
dY(6)  = -miuE*z/r^3 + Tmax*u*Alpha(3)/m;
dY(7)  = -Tmax*u/(IspPg0);
dY(8)  = miuE*lamvx/r^3 - 3*miuE*dot(R,Lamv)*x/r^5;
dY(9)  = miuE*lamvy/r^3 - 3*miuE*dot(R,Lamv)*y/r^5;
dY(10) = miuE*lamvz/r^3 - 3*miuE*dot(R,Lamv)*z/r^5;
dY(11) = -lamx;
dY(12) = -lamy;
dY(13) = -lamz;
dY(14) = -Tmax*u*norm(Lamv,2)/m^2;
dY = dY';






