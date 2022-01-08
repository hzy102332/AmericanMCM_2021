function f = fungi( t,x )
clc,clear
[t,x] = ode45(@species,[0,88.8],[2,2,2]);
x1 = x(:,1)-2;
x2 = x(:,2)-2;
x3 = x(:,3)-2;
plot(t,x1,'-',t,x2,'-',t,x3,'-')
axis([0 20 0 100]);
title('Total breakdown through three Fungi species')
xlabel('Time')
ylabel('Population')
legend('Fungi1','Fungi2','Fungi3');
hold off
function o = species(t,u)
H1=4;H2=4;H3=4;
xm1= 100;xm2=100;xm3=100;%Maximum population
S1=0.8;S2=0.6;S3=0.4;S4=0.7;S5=0.5;S6=0.3;%Competition coefficient
x(1) = u(1);
x(2) = u(2);
x(3) = u(3);
X1 = H1*x(1)*(1-x(1)/xm1-S1*x(2)/xm2-S2*x(3)/xm3);
X2 = H2*x(2)*(1-x(2)/xm2-S4*x(1)/xm1-S3*x(3)/xm3);
X3 = H3*x(3)*(1-x(3)/xm3-S6*x(2)/xm2-S5*x(1)/xm1);
o = [X1;X2;X3];
end
end