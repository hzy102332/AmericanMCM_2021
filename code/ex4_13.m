function f = fungi( t,x )
clc,clear
[t,x] = ode45(@species,[0,200],[2,2]);
temp = 1;
temp1 = 1;
x(:,1) = x(:,1)-2;
x(:,2) = x(:,2)-2;
for i = 1:size(x(:,1))
    if x(i,1)>= 50
        x(i,1) = 50;
        if temp == 1
            f1 = i;
            temp = 0;
        end
    end
    if x(i,2)>= 50
        x(i,2) = 50;
        if temp1 == 1
            f2 = i;
            temp1 = 0;
        end
    end
end
x
X = sum(x,2);
plot(t,X,'-')
hold on

plot(t,x(:,1),'-',t,x(:,2),'-')
line([t(f1) t(f1)],[0 100],'linestyle','--')
line([t(f2) t(f2)],[0 100],'linestyle','--')

text(t(f1),66,strcat('x = ',num2str(t(f1))))
text(t(f2),56,strcat('x = ',num2str(t(f2))))

axis([0 200 0 100]);
title('T = 22¡æ PH = 7 Moisture = 50%')
xlabel('Time(day)')
ylabel('Decomposition(%)')
legend('Total decomposition','Fungi1','Fungi2');
hold off

function o = species(t,u)
Hn1 = 4;Hn3 = 4;%Intrinsic growth rate
alpha1 = 0.5; beta1 = 0.5; %weight coefficient 
k1 = 1/32400; k2 = 25/9;%Scale factor
PH1 =8 ;PH2 = 6.5;PH3 = 5.7;PH4 = 4;%Optimum pH
PH = 7;%Current pH

T1= 30;T2=40;T3=65;T4=61;%Optimum temperature
T = 22;%Current temperature

M1=0.2;M3=0.8;%Optimum humidity
M = 0.5;%Current humidity

xm1= 100;xm3=100;%Maximum population
x(1) = u(1);
x(2) = u(2);
%% 1 and 3
H1 = Hn1*(alpha1*(1-k1*(PH-PH1)^2*(T-T1)^2)+(1-alpha1)*(1-k1*(PH-PH4)^2*(T-T4)^2))*(1-k2*(M-M1)^2)*x(1)*(1-x(1)/xm1);
H2 = Hn3*(beta1*(1-k1*(PH-PH2)^2*(T-T2)^2)+(1-beta1)*(1-k1*(PH-PH3)^2*(T-T3)^2))*(1-k2*(M-M3)^2)*x(2)*(1-x(2)/xm3);
X1 = (7*sqrt(H1)+5)/122;
X2 = (7*sqrt(H2)+5)/122;
o = [X1;X2];

end
end