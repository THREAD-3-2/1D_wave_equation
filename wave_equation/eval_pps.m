function [pp_s] = eval_pps(Ld_ij,Ld_i0j,Ld_ij0,Ld_i0j0,u_ij,u_ij1,u_ij0,u_i1j1,u_i1j,u_i0j,u_i0j1,uu,delta_t,n_t,n_s)
% Legendre transform.
%
p_s_backward = -(diff(Ld_ij,u_ij)+diff(Ld_ij0,u_ij))/delta_t;
p_s_forward  = (diff(Ld_i0j,u_ij)+diff(Ld_i0j0,u_ij))/delta_t;

p_s0_b = -diff(Ld_ij,u_ij)/delta_t*2;
p_s0_f = diff(Ld_i0j,u_ij)/delta_t*2;

p_sl_b = -diff(Ld_ij0,u_ij)/delta_t*2;
p_sl_f = diff(Ld_i0j0,u_ij)/delta_t*2;

pp_s = sym(zeros(n_s,n_t));

% t = t0
for j=2:n_t-1
    pp_s(1,j) = subs(p_s_backward,[u_ij,u_ij1,u_ij0,u_i1j1,u_i1j],[uu(1,j),uu(1,j+1),uu(1,j-1),uu(2,j+1),uu(2,j)]);
end

for i=1:n_s-1
    pp_s(i,1) = subs(p_s0_b,[u_ij,u_i1j,u_ij1,u_i1j1],[uu(i,1),uu(i+1,1),uu(i,2),uu(i+1,2)]);
end
pp_s(n_s,1) = subs(p_s0_f,[u_ij,u_i0j,u_i0j1,u_ij1],[uu(n_s,1),uu(n_s-1,1),uu(n_s-1,2),uu(n_s,2)]);

% time steps
for j=2:n_t-1
    for i=2:n_s
        pp_s(i,j) = subs(p_s_forward,[u_ij,u_ij1,u_ij0,u_i0j],[uu(i,j),uu(i,j+1),uu(i,j-1),uu(i-1,j)]);
    end
end

% t = t_end
pp_s(1,end) = subs(p_sl_b,[u_ij,u_ij0,u_i1j],[uu(1,end),uu(1,end-1),uu(2,end)]);
for i=2:n_s
    pp_s(i,end) = subs(p_sl_f,[u_i0j,u_ij,u_ij0],[uu(i-1,end),uu(i,end),uu(i,end-1)]);
end

end

