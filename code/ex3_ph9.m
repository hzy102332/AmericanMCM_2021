function f = fungi( t,x )
clc,clear
[t,x] = ode45(@species,[0,500],[2,2,2]);

plot(t,x(:,1),'-',t,x(:,2),'-',t,x(:,3),'-')
xlim([0, 0.016])
hold on 

axis([0 20 0 100]);
title('T = 22¡æ PH = 9 Moisture = 50%')
xlabel('Time')
ylabel('Population')
legend('Fungi1','Fungi2','Fungi3');
hold off

function o = species(t,u)
Hn1 = 2;Hn2 = 4;Hn3 = 6;%Intrinsic growth rate
alpha1 = 0.5; beta1 = 0.5; %weight coefficient 
k1 = 1/32400; k2 = 25/9;%Scale factor
PH1 =8 ;PH2 = 6.5;PH3 = 5.7;PH4 = 4;%Optimum pH
PH = 9;%Current pH

T1= 30;T2=40;T3=65;T4=61;%Optimum temperature
T = 22;%Current temperature

M1=0.2;M2=0.5;M3=0.8;%Optimum humidity
M = 0.5;%Current humidity

xm1= 100;xm2=100;xm3=100;%Maximum population
S2 = 0.7;S3 = 0.8;%Competition coefficient
x(1) = u(1);
x(2) = u(2);
x(3) = u(3);
X1 = Hn1*(alpha1*(1-k1*(PH-PH1)^2*(T-T1)^2)+(1-alpha1)*(1-k1*(PH-PH4)^2*(T-T4)^2))*(1-k2*(M-M1)^2)*x(1)*(1-x(1)/xm1);
X2 = Hn2*(beta1*(1-k1*(PH-PH2)^2*(T-T2)^2)+(1-beta1)*(1-k1*(PH-PH3)^2*(T-T3)^2))*(1-k2*(M-M2)^2)*x(2)*(1-x(2)/xm2-S2*x(3)/xm3);
X3 = Hn3*(beta1*(1-k1*(PH-PH2)^2*(T-T2)^2)+(1-beta1)*(1-k1*(PH-PH3)^2*(T-T3)^2))*(1-k2*(M-M3)^2)*x(3)*(1-x(3)/xm3-S3*x(2)/xm2);

o = [X1;X2;X3];
end
end