function [uu] = timesolver(uu_ij1_DEL,u_ij,u_i0j,u_i1j,u_ij0,uu,n_t,n_s)
%Time solver of the discrete Euler-Lagrange equations.
%
% :param u_ij: discrete transverse deformations
% :param n_t,n_s: number of time and space steps
%
% :returns: uu discrete transverse deformations at the interior points of the space-time grid (solution of the discrete Euler-Lagrange equations)
%
for j=2:n_t-1
    for i=2:n_s-1
        uu(i,j+1) = subs(uu_ij1_DEL,[u_ij,u_i0j,u_i1j,u_ij0],...
            [uu(i,j),uu(i-1,j),uu(i+1,j),uu(i,j-1)]);
    end
end
end

