clear;
l=5;
p=4;
q=4;
s=1;
f=@(t,y)[l+p*cos(y(1))-s*cos(t)-q*cos(y(2));
         p*sin(y(1))-s*sin(t)-q*sin(y(2));]
     
[t y]=ode45(f,[0 2*pi],[2.1662 1.0595]) 

for i = 1:1:length(t)
    
plot([l 0],[0 0]);
hold on;
plot([s*cos(t(i)) 0],[s*sin(t(i)) 0]);
plot([l p*cos(y(i,1))+l],[0 p*sin(y(i,1))]); 
plot([s*cos(t(i)) p*cos(y(i,1))+l],[s*sin(t(i)) p*sin(y(i,1))]); 
hold off;
xlim([-6 6]);
ylim([-6 6]);
pause(0.1);
end;
