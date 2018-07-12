clc;
clear all;
close all;
%Programming Assignment-2 Question 1%
timestep=1.2;%0.5; and 1.6;%
%A random closed curve generation with an input of 2000 points%
N=2000;
n=15;
nonrandbit=1;
randbit=1;
alpha=linspace(0,2*pi,n);
beta=linspace(0,2*pi,N);
r=nonrandbit+randbit*rand(size(alpha));
r(end)=r(1);%Closing the curve%
rr=spline(alpha,[0 r 0],beta);
x=rr.*cos(beta);%For taking other set of curves you can interchange x and y values with each other and for the third set of input you could use%
y=rr.*sin(beta);%x=rr.*cos^2(beta)and y=rr.*sin^2(beta)

hold on;
plot(x,y,'r')%Plot of the original curve%
plotstage=30000; %After every 30000 iterations each stage is being captured%
iterations=0;%initialization of the number of iterations%
%The Euler-Lagrange minimization part which has been done in class%
while(iterations<90000)%You can change the two parameters plotstage and iterations according to the number of iterations you want to compute for your curvature equation%
x=rr.*cos(beta);
y=rr.*sin(beta);
dx=gradient(x);%Single derivatives of x and y%
dy=gradient(y);
ddx=gradient(dx);%Double derivatives of x and y%
ddy=gradient(dy);
ds=sqrt(dx.^2+dy.^2);%Curvature element%
top=(ddx.*dy-ddy.*dx);
magc=(dx.^2+dy.^2);
termx=(ds.*top)./power(magc,1.5);
termy=(ds.*top)./power(magc,1.5);
if(magc<0)
   termx=0;
   termy=0;
end
x(1,size(x))=x(1,1);
y(1,size(x))=y(1,1);
xc=dy.*termx;
yc=-dx.*termy;
x=x+xc.*(timestep);
y=y+yc.*(timestep);
rr=sqrt(x.^2+y.^2);

iterations=iterations+1;
if (mod(iterations,plotstage)==0)
    plot(x,y,'-');%Plot of the final curve after the curvature flow equation is applied%
else
    continue;
end
end
