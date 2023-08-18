z=sym('z',[5 1]);
syms m g l lmbda;
z(5,1)=z(5,1)*m;
M=[m 0; 0 m];
Q=[0; -m*g];
pos=[z(1,1);z(2,1)];
v=[z(3,1);z(4,1)];
c=z(1,1)^2+z(2,1)^2-l^2
D=jacobian(c,pos)
r=-transpose(jacobian(D,pos)*v)*v;
 h=D*inv(M)*transpose(D);
 lmbda=inv(h)*(D*inv(M)*Q-r);
 q=sym('q',[5 1]);
 q(1,1)=z(3,1);q(2,1)=z(4,1);
 t=inv(M)*(Q-transpose(D)*z(5,1));
 q(3,1)=t(1);q(4,1)=t(2);
 q(5,1)=z(5,1)/m-lmbda/m;

 
 
 q=simplify(q);

z(5,1)=z(5,1)/m;

q=subs(q,g,10);

w=matlabFunction(q);

 f=@(t,y)w(y(1),y(2),y(3),y(4),y(5));

 
 
 m=[1 0 0 0 0;0 1 0 0 0 ; 0 0 1 0 0; 0 0 0 1 0 ; 0 0 0 0 0];

 
 options = odeset('Mass',m);



[t,y] = ode15s(f,[0 10],[10*sin(.5); -10*cos(.5); 0; 0 ;cos(.5)/2 ],options);
 



for i=1:1:length(t)
plot([0 y(i,1)],[0 y(i,2)],y(:,1),y(:,2),y(i,1),y(i,2),'o');xlim([-10 10]);
ylim([-15 5]);
if(i<length(t))
pause(t(i+1)-t(i));
end;
end;

% ode=odefunction(q,[z(1) z(2) z(3) z(4) z(5)]);