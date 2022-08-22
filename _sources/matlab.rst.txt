.. _matlab:

=============
 MATLAB code
=============

This primitive example just shows how to document MATLAB code with Sphinx
using the `matlabdomain extension <https://github.com/sphinx-contrib/matlabdomain/blob/master/README.rst>`_.

wave_equation
========

.. mat:automodule:: wave_equation

:mod:`wave_equation` module contains the source code :

.. mat:autofunction:: wave_equation.main

The discrete Lagrangian is defined in:

.. mat:autoscript:: wave_equation.discreteLag

The discrete Euler-Lagrange equations are solved in time and space in:

.. mat:autoscript:: wave_equation.timesolver

The conjugate momenta in time is evaluated in:

.. mat:autoscript:: wave_equation.eval_ppt


The conjugate momenta in space is evaluated in:

.. mat:autoscript:: wave_equation.eval_pps
