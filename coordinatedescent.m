function [e,x, z] = coordinatedescent(Q,c,p,x0,maxiter)
  % Entrees :
  % Q est une matrice n x n
  % c est un vecteur n x 1
  % p est un scalaire
  % x0 est l'itere initial (vecteur n x 1)
  % maxiter est le nombre d'iterations a effectuer
  
  % Sortie :
  % x est vecteur n x 1
  
  a = size (c);
  n = a(1);
  %% Initialiser deux variables pour garder les iterees:
  x = []; % Pour les variables, n'importe quelle dimention
          % x sera une matrice de dimentions (n_iterees x n_entrees(x))
  z = []; % Pour la valeur de la fonction a chaque iteree

  for i=1:maxiter
    A = 0;
    [f,delta] = fcalculator (Q, x0, c, p);  
    e(i) = 0.5*x0'*Q*x0-c'*x0+p;
    %% Choisir la variable a minimiser aleatoirement:
    j = ceil(rand(1)*n);       
    
    if (delta(j) == 0)
       %% Si la derivee partielle selon la variable x_j
       %% vaut zero, x_j reste la meme
    else          
      x = [x;x0']; % ajouter l'iteree anterieure
      z = [z; f] ; % ajouter la valeur de la fonction a la derniere iteree 
      
      for o = 1:n
        A += (Q(j,o)*x0(o) + Q(o,j)*x0(o))/2; 
      endfor
      % Mettre a jour la variable x_j :
      x0(j) = (A - (Q(j,j)*x0(j)) - c(j))/(-Q(j,j)) ;
      % x0(j) = max( x0(j),0) ; % Projection sur le domaine contraint 
      %mise en commentaire car inutile à la comparaison graphique
      %n'hésitez pas à retirer % pour observer le résultat
    endif
    
  endfor
  
  % Imprimer les valeurs finaux des variables et la fonction:
  fprintf('La valeur optimale de x est %f\n', x0);
  fprintf('La valeur optimale de la fonction est %f\n', f);
endfunction
