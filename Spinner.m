t=linspace(0,pi*2);
x(1,:)=5*cos(t);
x(2,:)=5*sin(t);
x(3,:)=0*t;

A=[1 0 0 ; 0 cos(pi/2) -sin(pi/2); 0 sin(pi/2) cos(pi/2)];
X=[cos(.2) 0 sin(.2); 0 1 0 ; -sin(.2) 0 cos(.2)];
plot3(0, 0,0);
pause(50)

for t=0:.25:4*pi
Z=[cos(t) -sin(t) 0 ; sin(t) cos(t) 0; 0 0 1]

plot3(0, 0,0);
hold on;

for j=0:1:3
C=[cos(j*pi/4) -sin(j*pi/4) 0 ; sin(j*pi/4) cos(j*pi/4) 0; 0 0 1];

 
 xlim([-10 10]);ylim([-10 10]);zlim([0 20]);
 set(gca,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],'BoxStyle','full','Box','on')
 
 for i=1:1:length(x)
    z(:,i)=C*A*x(:,i);
 end
 for i=1:1:length(x)
     temp=z(:,i);
     temp(3)=temp(3)+10;
   P(1:3,i,j+1)=(Z*X*Z)*temp;
 end

%   plot3(z(1,1:end/2),z(2,1:end/2),z(3,1:end/2)+10);
% 
%   plot3([0 z(1,1)],[0 z(2,1)],[0 z(3,1)+10]);
%  for i=1:1:length(x)
%     z1(:,i)=C*A*x(:,i);
%  end
%  plot3(z1(1,:),z1(2,:),z1(3,:));
end;
a=[0; 0 ;20];
plot3([0 a(1)],[0 a(2)],[0 a(3)],'--','color','b');
a=Z*X*Z*a;
plot3([0 a(1)],[0 a(2)],[0 a(3)],'--','color','r');

for i=1:1:length(x)
    temp=x(:,i);
     temp(3)=temp(3)+10;
   e(:,i)=(Z*X*Z)*temp;
end
  plot3(e(1,:),e(2,:),e(3,:));
 
  for j=1:1:4
  plot3(P(1,1:end/2+1,j),P(2,1:end/2+1,j),P(3,1:end/2+1,j));
  plot3([0 P(1,1,j)],[0 P(2,1,j)],[0 P(3,1,j)]);
    plot3([0 P(1,end/2+1,j)],[0 P(2,end/2+1,j)],[0 P(3,end/2+1,j)]);
  end



pause(.1)
hold off;
end
% 
% hold on;
% xlim([-10 10]);ylim([-10 10]);zlim([0 20]);
% set(gca,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],'BoxStyle','full','Box','on')
% for j=0:1:7
% plot3(z(1,:,j),z(2,:,j),z(3,:,j)+10);
% end
