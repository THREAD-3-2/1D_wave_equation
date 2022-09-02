% Variational formulation of the 1D wave equation.
%
% :param u_t0, dtu_t0: initial conditions
% :param u_s0, u_sl: boundary conditions
% :param l, rho, k_pot: string length, density and stiffness
%
% :returns: discrete transverse deformations u
% :postprocessing: HH energy density, PP momentum density and HH_error error in time of the energy charge
%

clc
format short

l = 2;      % stringlength
t_end = 1; 
rho = 1;    % string density
k_pot  = 1; % string stiffness

% space-time discretisation
ns_elem = 100; 
n_s = ns_elem+1;
delta_s = l/ns_elem;
s_i =0:delta_s:l;

delta_t = 1/50;  
nt_steps = t_end/delta_t;
n_t = nt_steps+1;

% initial conditions
u_t0  = vpa(sin(pi*s_i));
dtu_t0 = zeros(n_s,1); 
% boundary conditions 
u_s0  = zeros(n_t,1);
u_sl  = zeros(n_t,1);

%% Lagrangian
syms s t u(s,t) dsu dtu

T_kin = 1/2*rho*dtu^2;
V_pot = 1/2*k_pot*dsu^2;

L = T_kin-V_pot;

%% discrete lagrangian - trapezoidal rule

% i  --> space node i    j  --> time step j 
% i1 --> space node i+1  j1 --> time step j+1
% i0 --> space node i-1  j0 --> time step j-1

syms u_ij u_i1j u_ij1 u_i1j1
syms u_i0j u_i0j1  u_ij0 u_i1j0  u_i0j0

[Ld_ij,Ld_i0j,Ld_ij0,Ld_i0j0] = discreteLag(L,delta_s,delta_t,dsu,dtu);

% discrete Euler-Lagrange eqs interior points
DEL_eqs = diff(Ld_ij,u_ij)+diff(Ld_i0j,u_ij)+diff(Ld_ij0,u_ij)+diff(Ld_i0j0,u_ij);
uu_ij1_DEL = solve(DEL_eqs,u_ij1);

% t = t0
uu = sym(zeros(n_s,n_t));
uu(:,1) = u_t0;

% time step i = 2
% intiial condition: dtu_to = 0
eq  = diff(Ld_ij,u_ij)+diff(Ld_i0j,u_ij);
eq1 = sym(zeros(n_s-2,1));
for i=2:n_s-1
    eq1(i) = vpa(subs(eq,[u_ij,u_i0j,u_i1j],[uu(i,1),uu(i-1,1),uu(i+1,1)]));
    uu(i,2) = solve(eq1(i),u_ij1);
end


% time steps
uu = timesolver(uu_ij1_DEL,u_ij,u_i0j,u_i1j,u_ij0,uu,n_t,n_s);
% uu(6,end)

%% Legendre transform

pp_t = eval_ppt(Ld_ij,Ld_i0j,Ld_ij0,Ld_i0j0,u_ij,u_i0j,u_i1j,u_ij1,u_ij0,uu,delta_t,n_t,n_s);
pp_s = eval_pps(Ld_ij,Ld_i0j,Ld_ij0,Ld_i0j0,u_ij,u_ij1,u_ij0,u_i1j1,u_i1j,u_i0j,u_i0j1,uu,delta_s,n_t,n_s);
%% Postprocessing

% momentum density
PP = pp_s.*pp_t;

% energy density
t = 0:delta_t:t_end;
s = 0:delta_s:l;
[X,Y] = meshgrid(t,s);
HH = zeros(n_s,n_t);
HH_charge_node = zeros(n_s,n_t);
HH_charge_elem = zeros(ns_elem,n_t);
PP_charge_node = zeros(n_s,n_t);
PP_charge_elem = zeros(ns_elem,n_t);
for j=1:n_t
    for i=1:n_s
        T_kin(i,j) = 1/2*rho*pp_t(i,j)^2;
        V_pot(i,j) = 1/2*k_pot*pp_s(i,j)^2;
        HH(i,j) = T_kin(i,j)+V_pot(i,j);
        HH_charge_node(i,j) = 1/2*(pp_t(i,j)^2+k_pot/rho*pp_s(i,j)^2);
        PP_charge_node(i,j) = pp_t(i,j)*pp_s(i,j);
        if not(i == 1)
        HH_charge_elem(i-1,j) = 1/2*delta_s*(HH_charge_node(i-1,j)+HH_charge_node(i,j));
        PP_charge_elem(i-1,j) = 1/2*delta_s*(PP_charge_node(i-1,j)+PP_charge_node(i,j));
        end
    end
end
figure(1)
grid on
energy = surf(X,Y,HH)
energy.EdgeColor = 'none';
energy.FaceColor = 'interp';
xlabel('t')
ylabel('x')
title('Energy density')

figure(3)
hold on
for ii=1:n_t
    plot(s,uu(:,ii))
end
hold off
% energy.EdgeColor = 'none';
% energy.FaceColor = 'interp';
%% Energy charge

HH_charge = zeros(1,n_t);
HH_error = zeros(1,n_t);
PP_charge = zeros(1,n_t);
for j=1:n_t
    HH_charge(j) = sum(HH_charge_elem(:,j));
    HH_error(j) = HH_charge(1)-HH_charge(j);
    PP_charge(j) = sum(PP_charge_elem(:,j));
end

figure(2)
plot(t,HH_error)
title('energy charge: error')

figure(3)
plot(t,HH_charge)
title('energy charge')

figure(4)
plot(t,PP_charge)
title('momentum charge')


