function [pp_t] = eval_ppt(Ld_ij,Ld_i0j,Ld_ij0,Ld_i0j0,u_ij,u_i0j,u_i1j,u_ij1,u_ij0,uu,delta_s,n_t,n_s)
% Legendre transform.
%
% :param u_ij: discrete transverse deformations over the space-time grid, space and time steps
% :param Ld_ij: discrete Lagrangians over the space-time grid
% :param delta_t,n_t,n_s: time step size, and number of time and space steps
%
% :returns: pp_t canonical momenta w.r.t. time evaluated at each node of the space-time grid
%
%
p_t_backward = -(diff(Ld_ij,u_ij)+diff(Ld_i0j,u_ij))/delta_s;
p_t_forward  = (diff(Ld_ij0,u_ij)+diff(Ld_i0j0,u_ij))/delta_s;

pp_t = sym(zeros(n_s,n_t));

% t = t0
for i=2:n_s-1
    pp_t(i,1) = subs(p_t_backward,[u_ij,u_i0j,u_i1j,u_ij1],[uu(i,1),uu(i-1,1),uu(i+1,1),uu(i,2)]);
end

% time steps
for j=2:n_t
    for i=2:n_s-1
        pp_t(i,j) = subs(p_t_forward,[u_ij,u_ij0,u_i1j,u_i0j],[uu(i,j),uu(i,j-1),uu(i+1,j),uu(i-1,j)]);
    end
end

end

