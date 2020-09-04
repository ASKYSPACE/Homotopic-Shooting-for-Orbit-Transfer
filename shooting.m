function out = shooting(lambda,equini,equfinal,TOF,options,epsilon,parameters)
% Shooting Function
% lambda =
% [lambda_0;lambda_x,lambda_y,lambda_z,lambda_vx,lambda_vy,lambda_vz,lambda_m];8x1
lam0 = lambda(1);
lamrvm = lambda(2:8);
yini = [equini;lamrvm];
[t,y] = ode45(@dynamics,[0,TOF],yini,options,epsilon,lam0,parameters);
ytml = y(end,:);
lamm = ytml(14);
out = [ytml(1:6)'-equfinal;lamm;norm(lambda,2)-1];