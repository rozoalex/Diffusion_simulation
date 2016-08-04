%Sin model

nx=100;
nt=250;               %Number of time steps 
dt=0.05;
u=zeros(nx,1);         %aka S
dx=2/(nx-1);
x=0:dx:2; 
D=1;                %diffusion coe.
B=zeros(nx,1);

B_set=0.10;                %Constant Factor


A=0.2;                  %Sin factors
period=12;
w=3.1415/period;
A_sin=zeros(nx,1);




deriv_u=zeros(nx-2,1);
dederiv_u=zeros(nx-2,1);



%Initial Condition
for i=1:nx 
    if ((0.75<=x(i))&&(x(i)<=1.25))
        u(i)=2;
        u_range=find(u==2);
    else
        u(i)=1;
    end
end
%Matrix of B
B(u_range)=B_set;

%Sin matrix


max_u=[]

figure;
for t=0:dt:nt;
    h=plot(x,u,'-r');
    k=round(t/dt)+1;
    max_u(k)=max(u);
    title(['t=',num2str(t),'max=',num2str(max(u))])
    axis([0 2 0 6])
    drawnow; 
    refreshdata(h)
%find dS/dx
for j=1:98
deriv_u(j)=(u(j+2)-u(j))/0.404;
end
deriv_u_save=[deriv_u(1);deriv_u;deriv_u(end)];

%find d2S/dx2
for j=1:98
dederiv_u(j)=(deriv_u_save(j+2)-deriv_u_save(j))/0.404;
end
dederiv_u_save=[dederiv_u(1);dederiv_u;dederiv_u(end)] ;

sin_u=sin(w*t);
A_sin(u_range)=A*(sin_u)*(sin_u);

u=u+(D*dederiv_u_save+B+A_sin)*dt;


end
figure;
subplot(3,1,[1 2])
plot(0:dt:nt,max_u,'or');
hold on;
tt=0:dt:nt;
sin_sq=B_set+A*(sin(w*(tt))).^2;
subplot(3,1,3)
plot(tt,sin_sq,'-k');
xlabel('time');
ylabel('max S');
%dS/dt=sin + D * d2S/dx2
