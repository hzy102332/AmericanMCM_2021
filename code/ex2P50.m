function f = fungi( t,x )
clc,clear
[t,x] = ode45(@species,[0,105],[2,2,2]);
plot(t,x(:,1),'-',t,x(:,2),'-',t,x(:,3),'-')
axis([0 50 0 100]);
title('T = 22?? Moisture = 50%')
xlabel('Time')
ylabel('Population')
legend('Fungi1','Fungi2','Fungi3');
hold off
function o = species(t,u)
Hn1 = 2;Hn2 = 4;Hn3 = 6;%Intrinsic growth rate
M1=0.2;M2=0.5;M3=0.8;%Optimum humidity
M = 0.5;%Current humidity
xm1= 100;xm2=100;xm3=100;%Maximum population
S1=0.8;S2=0.6;S3=0.4;S4=0.7;S5=0.5;S6=0.3;%Competition coefficient
k2 = 25/9; %Scale factor
x(1) = u(1);
x(2) = u(2);
x(3) = u(3);
X1 = Hn1*(1-k2*(M-M1)^2)*x(1)*(1-x(1)/xm1-S1*x(2)/xm2-S2*x(3)/xm3);
X2 = Hn2*(1-k2*(M-M2)^2)*x(2)*(1-x(2)/xm2-S4*x(1)/xm1-S3*x(3)/xm3);
X3 = Hn3*(1-k2*(M-M3)^2)*x(3)*(1-x(3)/xm3-S6*x(2)/xm2-S5*x(1)/xm1);
o = [X1;X2;X3];
end
end