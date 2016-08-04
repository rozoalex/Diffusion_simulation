%B model

%%
%Variables that are not interesting to play with.
%A improper set of them might lead to a failure of the code 
Lx=2;                      %Length of x
Ly=2;                      %Length of y
Lx_interest=[0.75 1.25];   %Interested region(must be less than Lx)
Ly_interest=[0.75 1.25];   %Interested region(must be less than Ly)
nx=100;                    %Number of x data points 
ny=100;                    %Number of y data points 
u=zeros(nx,ny);            %smog concentration
max_u=[];                  %Max smog Concentration
dx=Lx/(nx-1);              %Position steps
dy=Ly/(ny-1);              %Position steps
x=0:dx:Lx;                 %Position interval
y=0:dy:Ly;                 %Position interval
dt=0.05;                   %Each time step
nt=300;                      %Number of time steps 
secdev_u=[];               %second order derivtives in each steps
dederiv_u_save=zeros(nx,ny);
%%
%Variables that are interesting to play with.
D=0.9;                     %diffusion coe.
i_u_in=2;                  %Initial concentration in side interested region
i_u_out=0.5;               %Initial concentration around

B=zeros(nx,ny);            %Matrix of Constant Factor
B_set=0.002;                 %Value of Constant Factor
%%
%Initial Condition
%Setting up the u matrix
for i=1:nx
    for j=1:ny
        if ((Ly_interest(1)<=y(j))&&(y(j)<=Ly_interest(2))&&(Lx_interest(1)<=x(i))&&(x(i)<=Lx_interest(2)))
            u(i,j)=i_u_in;
        else
            u(i,j)=i_u_out;
        end
    end
end
%Setting up the B Matrix 
B(find(u==i_u_in))=B_set;

%%
%Simulation

figure;
for t=0:dt:nt;
    
    h=surf(x,y,u,'EdgeColor','none');
    axis([0 Lx 0 Ly 0 2])
    max_u(end+1)=max(max(u));
    shading interp
  
    title({['max=',num2str(round(max_u(end),2))],['t=',num2str(t)]},'position',[max_u(end),0,1.5],'FontSize',16);
    drawnow; 
    refreshdata(h)
    
%find dS/dx
for i=1:nx
secdev_u=diff(u(i,:),2);
dederiv_u_save(i,:)=[secdev_u(1) secdev_u secdev_u(end)] ;
end

for j=1:ny
secdev_u=diff(u(:,j),2);
dederiv_u_save(:,j)=dederiv_u_save(:,j)+[secdev_u(1);secdev_u;secdev_u(end)];
end
u=u+(D*dederiv_u_save+B)*dt;
end

figure;
plot(0:dt:nt,max_u,'.r');
xlabel('time');
ylabel('max concentration')


%dS/dt=B + D * d2S/dx2
