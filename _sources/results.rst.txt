.. _results:

===============================
 Post-processing and results
===============================

Results are shown in terms of:

* energy density, i.e. the energy of the system is evaluated at each node of the beam during the whole simulation time as:

  .. math::
       \begin{aligned}
           H_{density} \left( x,t,u,\dot{u},u' \right) = \frac{1}{2} \left( \dot{u}^2 + c^2 u' ^2 \right)
       \end{aligned}

* energy charge, i.e. the total energy of the system evaluated in the discretised simulation time

  .. math::
       \begin{aligned}
           H_{charge} \left( t \right) = \int_{0}^\tau \left[ \frac{1}{2} \left( u' ^2 + c^2 \dot{u}^2 \right) dt \right]
       \end{aligned}

Both quantities are calculated by using the discrete Legendre transform. In the discrete settings, energy density and charge are respectively detemined as follow:

.. math::
     \begin{aligned}
         H_{density}^{i,j} = \frac{1}{2} \left( (p_t^{i,j})^2 + c^2 (p_x^{i,j})^2 \right)
     \end{aligned}

.. math::
     \begin{aligned}
         H_{charge}^j \left( t \right) = \sum\limits_{j=0}^\tau \left[ \frac{1}{2} \left( (p_t^{j})^2 + c^2 (p_x^{j})^2 \right) \right]
     \end{aligned}

For the particular example problem, the above quantities are shown in Figure 1 and 2. It can be notice the good behaviour of the energy charge with an error in time of the order of :math:`10^{-15}` in Figure 2.

.. figure:: /figures/energy_density.png

   Figure 1. Energy density

.. figure:: /figures/energy_error.png

   Figure 2. Energy charge: error
