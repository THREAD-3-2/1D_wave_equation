.. _introduction:

==============
 Introduction
==============

Description of the problem
==========================

The transverse deformation :math:`u = u(s,t)` of the string is a function
defined in the space-time domain :math:`X = [0,l] \times [0,\tau]` to the configuration space :math:`Q = \mathbb{R}`. Here :math:`l, \tau \in \mathbb{R}` denote the length of the string and the total simulation time respectively. Its Lagrangian density can be written as:

.. math::
        \begin{aligned}
        		L(u,\dot{u},u')= T(\dot{u})-V(u')= \frac{1}{2} \left(\dot{u}^2 - c^2 {u'}^2 \right)
        \end{aligned}

where :math:`T` is the kinetic energy density, :math:`V` is the potential energy density,
:math:`\dot{u}` is the derivative w.r.t. time, :math:`u'` is the derivative
w.r.t. space, and :math:`c` is the propagation speed of the waves. If :math:`\rho` is the density and :math:`k` is the modulus of elasticity of the string, then :math:`c = \sqrt{k/\rho}`.
The associated action functional is:

.. math::
        \begin{aligned}
      	 		S[u]=\int_{0}^{\tau} {\int_{0}^{l} L(u(s,t),\dot{u}(s,t),u'(s,t)) ds}dt
      	\end{aligned}

Applying Hamilton's principle of stationary action with fixed variations at the boundary of :math:`X` yields the Euler-Lagrange equations of the string, the 1D wave equation:

.. math::
        \begin{aligned}
      	   \ddot{u} - c^2 u'' =0
      	\end{aligned}

In this report, we discretise and solve this problem in time and space using a multisymplectic variational integrator.

Canonical picture
=================

As in standard Lagrangian mechanics, in Lagrangian field theories there exists the concept of canonical momenta. These are quantities defined by the partial derivatives of the Lagrangian density with respect to the derivatives of the field. In this case, two canonical momenta exist

.. math::
        \begin{align*}
      	   &p_t = \frac{\partial L}{\partial \dot{u}}(u,\dot{u},u') = \dot{u},\\
      	   &p_s = \frac{\partial L}{\partial u'}(u,\dot{u},u') = -c^2 u'.
      	\end{align*}

These will be important in order to impose the boundary conditions after the discretisation.
