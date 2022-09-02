.. _matlab:

=============
 MATLAB code
=============

1D_wave_equation is a MATLAB code for the dynamics of a 1-dimensional wave equation. The trapezoidal quadrature rule is used to approximate the integral of
the Lagrangian function in both time and space. Symbolic differentiation is used for the derivation of the equations and this leads to long time running.
Matlab Symbolic Math Toolbox is needed.

wave_equation
=============

.. mat:automodule:: wave_equation

:mod:`wave_equation` module contains the source code :

.. mat:autofunction:: wave_equation.main

The discrete Lagrangian is defined in:

.. mat:autofunction:: wave_equation.discreteLag

The discrete Euler-Lagrange equations are solved in time and space in:

.. mat:autofunction:: wave_equation.timesolver

The conjugate momenta in time is evaluated in:

.. mat:autofunction:: wave_equation.eval_ppt

The conjugate momenta in space is evaluated in:

.. mat:autofunction:: wave_equation.eval_pps
