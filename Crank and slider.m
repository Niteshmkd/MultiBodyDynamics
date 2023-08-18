%  syms x1 y1 t1 x2 y2 t2 x3 y3 t3 f c1 c2 c3;
% f=[x1-c1*cos(t1)
% y1-c1*sin(t1)
% x1-x2 + c1*cos(t1)+c2*cos(t2)
% y1-y2+c1*sin(t1)+c2*sin(t2)
% x2-x3+c2*cos(t2)+c3*cos(t3)
% y2-y3+c2*sin(t2)+c3*sin(t3)
% x3+c3*cos(t3)-2
% y3+c3*sin(t3)]
bore=127.00
stroke=156.144;
distance=146.05
screw=9.52;

syms x1 x2 t1 y1 y2 t2 x3 y3 c1 c2
eq=sym('eq',[7 1]);
o1=[x1;y1];o2=[x2;y2];o3=[x3;y3];
A1=[cos(t1) -sin(t1);sin(t1) cos(t1)];
A2=[cos(t2) sin(t2);-sin(t2) cos(t2)];
T=o1+A1*[-c1; 0];
eq(1)=T(1);
eq(2)=T(2);
T=o1+A1*[c1; 0]-o2-A2*[-c2;0];
eq(3)=T(1);
eq(4)=T(2);
T=o3-o2-A2*[c2; 0];
eq(5)=T(1);
eq(6)=T(2);
eq(7)=y3;
e=subs(eq,[c1 c2 t1],[3 5 .05]);
 sol=solve(e);
 x0(1)=double(sol.t2(1));
 x0(2)=double(sol.x1(1));
 x0(3)=double(sol.x2(1));
 x0(4)=double(sol.x3(1));
 x0(5)=double(sol.y1(1));
 x0(6)=double(sol.y2(1));
 x0(7)=double(sol.y3(1));
 y0=double(x0);
 i=0;
 for t=0:0.05:3.14*4
     e=subs(eq,[c1 c2 t1],[3 5 t]);
     w=matlabFunction(e);
    f=@(y)w(y(1),y(2),y(3),y(4),y(5),y(6),y(7));
 i=i+1;  
    [y]=fsolve(f,y0);
    y0=y;
    pos(i,:)=y;
   
    
% %     plot
   p= [pos(i,2);pos(i,5)]+[cos(t) -sin(t);sin(t) cos(t)]*[3; 0];
     plot([0 p(1)],[0 p(2)]);  
     hold on;
      xlim([-10 25]);ylim([-10 25]);
     
     plot([p(1) y(4)],[p(2) y(7)]);
  
     hold off;
     
    pause(0.0005);
     
end
 
 
%  velocity

D=jacobian(eq,[t2 x1 x2 x3 y1 y2 y3 t1]);
Dhat=rref(D);
alpha=-Dhat(:,8);
i=0;
w=2;
for t=0:0.05:3.14*4
    i=i+1;
alpha1=subs(alpha,[c1 c2],[3 5]);
alpha2=subs(alpha1,[t2 x1 x2 x3 y1 y2 y3],pos(i,:));
alpha3=subs(alpha2,t1,t);
v(i,:)=double(alpha3)*w;
end

i=0;
for t=0:0.05:3.14*4
i=i+1;
pos(i,8)=t;
v(i,8)=w;
end

% acceleration
j=0;
for t=0:0.05:3.14*4
    j=j+1;
    v1=sym('v1',[8 1]);
    for i=1:1:7
          r(i)=-1*transpose(jacobian(Dhat(i,:),[t2 x1 x2 x3 y1 y2 y3 t1])*v1)*v1;
    end   
    r=subs(r,[c1 c2],[3 5]);
 r=subs(r,transpose(v1),v(j,:));

    a(j,:)=double(subs(r,[t2 x1 x2 x3 y1 y2 y3 t1],pos(j,:)));
end

i=0;
for t=0:0.05:3.14*4
i=i+1;
a(i,8)=0;
end


% moment caculations

G=-transpose(D);
H=[0; 0; 0; 0; 0; 0; 0; 1];
G(:,8)=H;
G=subs(G,[c1 c2],[3 5]);
i=0;
for t=0:0.05:3.14*4
    i=i+1;
    G1=subs(G,[t2 x1 x2 x3 y1 y2 y3 t1],pos(i,:));
   temp=double(inv(G1)*transpose(a(i,:)));
    moment(i)=temp(8);
end

plot(0:0.05:4*3.14,moment)