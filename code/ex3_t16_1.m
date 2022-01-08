function f = fungi( t,x )
clc,clear
[t,x] = ode45(@species,[0,500],[2,2,2]);
temp = 1;
temp1 = 1;
x(:,1) = x(:,1)-2;
x(:,2) = x(:,2)-2;
x(:,3) = x(:,3)-2;
for i = 1:size(x(:,1))
    if x(i,1)>= 50
        x(i,1) = 50;
        if temp == 1
            f1 = i;
            temp = 0;
        end
    end
    if x(i,2)+x(i,3) >= 55
        x(i,2) = x(i-1,2);
        x(i,3) =x(i-1,3);
        if temp1 == 1
            f2 = i-1;
            x(i,3) =50 - x(i,2);
            temp1 = 0;
        end
    end
end
x
X = sum(x,2);
plot(t,X,'-')
hold on

plot(t,x(:,1),'-',t,x(:,2),'-',t,x(:,3),'-')
line([t(f1) t(f1)],[0 100],'linestyle','--')
line([t(f2) t(f2)],[0 100],'linestyle','--')

text(t(f1),66,strcat('x = ',num2str(t(f1))))
text(t(f2),66,strcat('x = ',num2str(t(f2))))

axis([0 300 0 100]);
title('T = 16¡æ PH = 7 Moisture = 50%')
xlabel('Time')
ylabel('Decomposition(%)')
legend('Total decomposition','Fungi1','Fungi2','Fungi3');
hold off

function o = species(t,u)
Hn1 = 2;Hn2 = 4;Hn3 = 6;%Intrinsic growth rate
alpha1 = 0.5; beta1 = 0.5; %weight coefficient 
k1 = 1/32400; k2 = 25/9;%Scale factor
PH1 =8 ;PH2 = 6.5;PH3 = 5.7;PH4 = 4;%Optimum pH
PH = 7;%Current pH

T1= 30;T2=40;T3=65;T4=61;%Optimum temperature
T = 16;%Current temperature

M1=0.2;M2=0.5;M3=0.8;%Optimum humidity
M = 0.5;%Current humidity

xm1= 100;xm2=100;xm3=100;%Maximum population
S2 = 0.7;S3 = 0.8;%Competition coefficient
x(1) = u(1);
x(2) = u(2);
x(3) = u(3);
H1 = Hn1*(alpha1*(1-k1*(PH-PH1)^2*(T-T1)^2)+(1-alpha1)*(1-k1*(PH-PH4)^2*(T-T4)^2))*(1-k2*(M-M1)^2)*x(1)*(1-x(1)/xm1);
H2 = Hn2*(beta1*(1-k1*(PH-PH2)^2*(T-T2)^2)+(1-beta1)*(1-k1*(PH-PH3)^2*(T-T3)^2))*(1-k2*(M-M2)^2)*x(2)*(1-x(2)/xm2-S2*x(3)/xm3);
H3 = Hn3*(beta1*(1-k1*(PH-PH2)^2*(T-T2)^2)+(1-beta1)*(1-k1*(PH-PH3)^2*(T-T3)^2))*(1-k2*(M-M3)^2)*x(3)*(1-x(3)/xm3-S3*x(2)/xm2);

X1 = (5*sqrt(H1)+3)/122;
X2 = (5*sqrt(H2)+3)/122;
X3 = (5*sqrt(H3)+3)/122;

o = [X1;X2;X3];
end
end