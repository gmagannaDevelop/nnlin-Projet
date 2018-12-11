

## Author: ThomasGuily, Gustavo Maganna Lopez
## Created: 2018-11-19

function [f,delta] = fcalculator (Q, x0, c, p)

  f = 0.5*(x0'*Q*x0) - (c' * x0) + p ;
  %calcule la valeur de f a chaque iteree.
  delta = (x0'*Q)- c'; 
  %calcule le gradient a chaque iteree.
 
endfunction
