# Romberg-Integration
MATLAB: Uses Romberg's method to numerically solve real valued integrals across some defined interval [a,b] to some arbitrary error tolerance.

There are 2 mandatory input parameters (the bounds), and one optional input parameter (the error tolerance).
Additionally, while running, the function will request an input function (integrand) to evaluate.

Complete function details and syntax (with examples) are commented into the .m file, and are additionally reproduced below.

The pdf file is a plot of an example 'slowly converging' function: the integral of: sin(x^3-erf(x)*tan(x/2))+erf(sin(x)) from 0 to 10.

NOTES

int_a^b f(x) using Romberg Integration

Adam Diehl
Version 1.0
Last updated Nov 30, 2016

Variables:
a = left endpoint
b = right endpoint
ErrorBound (input 3) is optional manual error tolerance
    Default error tolerance is 1e-16

Syntax:
    >> Romberg(0,5)
        2*x^2-sin(x) [[[When asked for function input]]]
    >> Romberg(-1,3,1e-10)
        3*x^-1

Note 1: under slow convergence conditions (matrix size = 16x16 with current solution being at least 10^3*(Error Bound)) the function will terminate early and spit out a warning. This behavior can be modified at line 89.
    
    An example of a slowly converging function is:
        sin(x^3-erf(x)*tan(x/2))+erf(sin(x)) from 0 to 10
    This requires an 18x18 matrix to recover a solution, so setting the tolerance to n=18 would produce a solution (~1.9688...)
    
Note 2: The accuracy in the error approximation increases with the accuracy in the integral solution.
