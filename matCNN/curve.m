clear all
syms x(t) y(t);
 
% Vector Function
% r(t) = < x(t), y(t) >
x(t)  = sqrt(2/3)*sin(t);
y(t)  = sqrt(3/4)*cos(t);
 
% r'(t) = < dx(t), dy(t) >
dx = diff(x);
dy = diff(y);
 
% determine r(t)
det = sqrt(dx^2+dy^2);
 
% unit tangent
% T(t) = < dx/det, dy/det >
Tx = dx/det;
Ty = dy/det;
 
% T'(t) = < dTx, dTy >
dTx = diff(Tx);
dTy = diff(Ty);
 
% curvature of curve
%       ||T'(t)||
%   k = ---------
%       ||r'(t)||
 
% ||T'(t)||
dTval = sqrt(dTx^2+dTy^2);
% ||r'(t)||
drval = sqrt(dx^2+dy^2);
% k
k = dTval/drval;
 
[ kval, val, tt ] = curve4cal( k );
 
nKval = double(kval);
 
fprintf('curvature at %s = %d is %.4f\n', val, tt, nKval)