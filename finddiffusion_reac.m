%B model

nx=100;
u=zeros(nx,1);         %aka S
P=zeros(nx,1);         %Polulation
dx=2/(nx-1);
x=0:dx:2; 
D=0.9;                %diffusion coe.
D2=0.07;
B=zeros(nx,1);
B_set=0.08;                %Constant Factor
C_set=0.00;                 %Born
dt=0.05;
nt=250;               %Number of time steps 
w= -0.5;
hh=0.7;

add_u=0;
add_p=0;

deriv_u=zeros(nx-2,1);
dederiv_u=zeros(nx-2,1);
deriv_P=zeros(nx-2,1);
dederiv_P=zeros(nx-2,1);



%Initial Condition
for i=1:nx 
    if ((0.75<=x(i))&&(x(i)<=1.25))
        u(i)=2;
        u_range=find(u==2);
    else
        u(i)=1;
    end
end
u = u+add_u;
%Matrix of B
B(u_range)=B_set;

%Initial Condition
for i=1:nx 
    if ((0.75<=x(i))&&(x(i)<=1.25))
        P(i)=10;
        P_range=find(P==10);
    else
        P(i)=1;
    end
end

P = P +add_p;



figure;
for t=0:dt:nt;
    subplot(2,2,1)
    h=plot(x,u,'-r');
    find(max(abs(u)))
    maxxu=max(u);
    title(['t=',num2str(t),' max=',num2str(maxxu)])
    subplot(2,2,2)
    maxu = plot(t,maxxu,'or');
    hold on;
    subplot(2,2,3)
    h2=plot(x,P,'-b');
    maxxp=max(P);
    title(['t=',num2str(t),' max=',num2str(maxxp)])
    subplot(2,2,4)
    maxp= plot(t,maxxp,'ok');
    hold on;
    drawnow; 
    refreshdata(h)
    refreshdata(h2)
    refreshdata(maxu)
    refreshdata(maxp)
    
%find dS/dx
for j=1:98
deriv_u(j)=(u(j+2)-u(j))/0.404;
end
deriv_u_save=[deriv_u(1);deriv_u;deriv_u(end)];

%find dP/dx
for j=1:98
deriv_P(j)=(P(j+2)-P(j))/0.404;
end
deriv_P_save=[deriv_P(1);deriv_P;deriv_P(end)];

%find d2S/dx2
for j=1:98
dederiv_u(j)=(deriv_u_save(j+2)-deriv_u_save(j))/0.404;
end
dederiv_u_save=[dederiv_u(1);dederiv_u;dederiv_u(end)] ;

%find d2P/dx2
for j=1:98
dederiv_P(j)=(deriv_P_save(j+2)-deriv_P_save(j))/0.404;
end
dederiv_P_save=[dederiv_P(1);dederiv_P;dederiv_P(end)] ;
u=u+(D*dederiv_u_save+B+hh*P).*dt;
P=P+(D2*dederiv_P_save+w*u)*dt;


end

%dS/dt=B + D * d2S/dx2
