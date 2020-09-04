function [u,Alpha] = getcontrol(Y,epsilon,lam0,parameters)
IspPg0  = parameters.IspPg0;
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
% Optimal Thrust Direction
Alpha = -Lamv/norm(Lamv,2);
u = u';