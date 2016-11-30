%% NOTES
% Function Read-Me

%int_a^b f(x) using Romberg Integration

%Adam Diehl
%Version 1.0
%Last updated Nov 30, 2016

%Variables:
%a = left endpoint
%b = right endpoint
%Input 3 is optional manual error tolerance
    %Default error tolerance is 1e-16

%Syntax:
    %Romberg(0,5)
        %2*x^2-sin(x) [[[When asked for function input]]]
    %Romberg(-1,3,1e-10)
        %3*x^-1

%Note 1: under slow convergence conditions (matrix size = 16x16 with 
    %current solution being at least 10^3*(Error Bound)) the function will
    %terminate early and spit out a warning. This behavior can be modified 
    %at line 89.
    
    %An example of a slowly converging function is:
        %sin(x^3-erf(x)*tan(x/2))+erf(sin(x)) from 0 to 10
    %This requires an 18x18 matrix to recover a solution, so setting the
    %tolerance to n=18 would produce a solution (~1.9688...)
    
%Note 2: The accuracy in the error approximation increases with the
    %accuracy in the integral solution

%% FUNCTION

function out=Romberg(a,b,ErrorBound)

%Check Inputs
if nargin < 3
    ErrorBound = 1e-16;
end

%Enter a function to evaluate. Automatic conversion to characteristic type.
s2 = input('Enter an integrand, including operators: ', 's');
s1 = '@(x)';
S = strcat(s1,s2);
f = str2func(S);    

%Clear screen and display integrand with bounds
clc
fprintf('Integrating %s from %g to %g: \n',s2,a,b);

%Initialize n. n > 1 is necessary to calculate error.
n = 2;

%End the loop when "done"
done = 0;
while done ~= 1;

%Generate solution matrix 
r = zeros(n,n);

%Calculate initial matrix element
h = b-a;
r(1,1) = (h/2)*(f(a)+f(b)); %First element

%Build the matrix
    %k is row number
for k=2:n
    h = h/2;
    %This is sum from the integration formula
    for i = 1:2^(k-2)
        r(k,1) = r(k,1)+f(a+(2*i-1)*h);
    end
    %Fill out the row
    r(k,1) = r(k-1,1)/2+h*r(k,1);
    
    %J is column number
    for j=2:k
        r(k,j) = r(k,j-1)+(r(k,j-1)-r(k-1,j-1))/(4^(j-1)-1);
    end
end

%Approximate error
Err = abs(r(k,j-1)-r(k,j));

%Function return to command window if convergence is extremely slow
if n>= 16 && Err >= 1e3*ErrorBound
    disp('Slow function convergence detected. Operation terminated.');
    return
end

%End condition for the While loop
if Err <= ErrorBound
    done = 1;
else
    done = 0;
    n=n+1;
end
end

out = r(k,j);