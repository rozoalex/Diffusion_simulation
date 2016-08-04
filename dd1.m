
figure;
for ii=1:4
    subplot(2,2,ii);
%Specifying Parameters
nx=50;               %Number of steps in space(x)
nt=ii*ii*25;               %Number of time steps 
dt=0.1;              %Width of each time step
dx=2/(nx-1);         %Width of space step
x=0:dx:2;            %Range of x (0,2) and specifying the grid points
u=zeros(nx,1);       %Preallocating u
un=zeros(nx,1);      %Preallocating un
vis=0.01;            %Diffusion coefficient/viscosity
beta=vis*dt/(dx*dx); %Stability criterion (0<=beta<=0.5, for explicit)
UL=1;                %Left Bountry Condition
UR=1;                %Right Bountry Condition
UnL=1;               %Left Neumann B.C (du/dn=UnL) 
UnR=1;               %Right Neumann B.C (du/dn=UnR) 


%Initial Conditions: A square wave
for i=1:nx
    if ((0.75<=x(i))&&(x(i)<=1.25))
        u(i)=2;
        u_range=find(u==2);
    else
        u(i)=1;
    end
end

%B.C vector
bc=zeros(nx-2,1);
bc(1)=vis*dt*UL/dx^2; bc(nx-2)=vis*dt*UR/dx^2;%Dirichlet B.Cs
%bc(1)=-UnL*vis*dt/dx; bc(nx-2)=UnR*vis*dt/dx;  %Neumann B.Cs
%Calculating the coefficient matrix for the implicit scheme
E=sparse(2:nx-2,1:nx-3,1,nx-2,nx-2);
A=E+E'-2*speye(nx-2);        %Dirichlet B.Cs
%A(1,1)=-1; A(nx-2,nx-2)=-1; %Neumann B.Cs
D=speye(nx-2)-(vis*dt/dx^2)*A;

%%a
%Calculating the velocity profile for each time step
i=2:nx-1;
for it=0:nt
    un=u;
    h=plot(x,u);       %plotting the velocity profile
    axis([0 2 0 2])
    title(['t=',num2str(nt)]);
    xlabel('x')
    ylabel('S')
    drawnow; 
    refreshdata(h)
    %Uncomment as necessary
    %-------------------
    %Implicit solution
    
    U=un;U(1)=[];U(end)=[];
    U=U+bc;
    U=D\U;
    %U(u_range)=U(u_range)+it*0.0001;
    
    u=[UL;U;UR];                      %Dirichlet
    %u=[U(1)-UnL*dx;U;U(end)+UnR*dx]; %Neumann
    %}
    %-------------------
    %Explicit method with F.D in time and C.D in space
    %{
    u(i)=un(i)+(vis*dt*(un(i+1)-2*un(i)+un(i-1))/(dx*dx));
    %}
end

end

