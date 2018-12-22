## Copyright (C) 2018 ThomasGuily
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} nnls_Guily_Magan (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: ThomasGuily <ThomasGuily@MAITRE_DES_INTE>
## Created: 2018-12-22

function [x,e,t]=nnls_Guily(A,b,x0,timelimit,choix)
  % Entrees :
  % A est une matrice m x n
  % b est un vecteur m x 1
  % x0 est l'itere initial (vecteur n x 1)
  % timelimit est le temps de resolution
  % si choix==1 -> methode du gradient
  % si choix==2 -> methode du gradient accelere
  % si choix==3 -> methode coordinate descent
  
  % Sorties :
  % x est vecteur n x 1
  % e est le vecteur contenant les erreurs
  % t est le vecteur contenant les temps auxquels les erreurs ont ete calculees
  
  %Initialisations et scaling
  AtA = A'*A;
  Atb = A'*b;
  btb = b'*b;
  L   = max(eig(AtA));
  gamma = (b'*A*x0)/(x0'*A'*A*x0); %COMPLETER ICI
  x0=gamma*x0; 
  x = x0;
  
  %Initialisation des vecteurs erreurs et temps
  temps = cputime;
  t     = 0;
  e     = 0.5*(x'*AtA*x-2*Atb'*x+btb); 
  
  alpha = 0.9; %necessaire pour la methode du gradient accelere
  y= x0;
  xp=x0;

  iter  = 0;
  while cputime-temps<=timelimit
    iter=iter+1;
    
    if choix==1 %methode du gradient
      %COMPLETER ICI
##      d=-(AtA*x-Atb);
##      alpha = (-d'*(AtA*x-Atb))/(d'*AtA*d);
##      x=x+alpha*d;
      
      x=x-(1/L)*(AtA*x-Atb);
      
    end
    
    if choix==2 %methode du gradient accelere
      %COMPLETER ICI
      x=y-(1/L)*(AtA*y-Atb);
      newalpha=(1/2)*(sqrt(alpha^(4)+4*alpha^(2))-alpha^(2));
      beta=(alpha*(1-alpha))/(alpha^(2)+newalpha);
      y=x+beta*(x-xp);
      xp=x;
      alpha=newalpha;

    end
    
    
    if choix==3 %methode coordinate descent
      n = length(x);
      %COMPLETER ICI
      for k=1:n;
      sum=0;
        for j=1:n
          if (j!=k)
            sum += x(j)* AtA(k,j); 
          end
        end
      x(k)= (Atb(k)-sum)/AtA(k,k);
      x(k)=max(0, x(k)); %enmpêche x(k) de devenir négatif
      end  
    end   
    
    %Calcul du temps et de l'erreur
    time_lost = cputime;
    e         = [e 0.5*(x'*AtA*x-2*Atb'*x+btb)]; 
    temps     = temps+(cputime-time_lost);
    t         = [t cputime-temps];
  end
