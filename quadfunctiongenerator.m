

## Author: ThomasGuily, Gustavo Magaña Lopez
## Created: 2018-11-19

function [Q, x0, c, p] = quadfunctiongenerator (choix)

%L'utilisateur entre la fonction quadratique  
if (choix == 0)
  
  
  n = input ('Choix du nombre de variables: n = ');
  %valable quel que soit le nombre de dimensions choisies
  fprintf ('Entrer les valeures des éléments de Q, de c et de la constante p \n');
  
  do
    fprintf ('Attention ! Q doit être définie positive pour posséder un point minimum global \n');
    for i = 1 : n
      for j = 1 : n
        fprintf('Q(%d', i),fprintf(',%d', j), Q(i,j) = input (')==>');
      endfor  
    endfor
    
    for i = 1 : n
      fprintf('c(%d', i), c(i) = input (')==>');
    endfor
    p = input ('p ==>');
  
    fprintf ('Entrer les valeures de litérée initiale \n');
  
    for i = 1 : n
      fprintf('x0(%d', i), x0(i) = input (')==>');
    endfor
  
    fprintf ('le problème est carctérisé par: \n');
    Q , c, p, x0 
    [], b = eig(Q);
    %b = vecteur compose des valeures propres
    
  until (b > 0)
  %tant que la matrice Q n'est pas définie positive, l'utilisateur recommence

   
  %L'utilisateur rentre A et b pour définir la fonction minimisant ||Ax-b||_2^2)
else 
  
  n = input ('Choix du nombre de variables: n = ');
  %valable quel que soit le nombre de dimensions choisies
  fprintf ('Entrer les valeures des éléments de A et de b qui caractérise le problême du moindre carré min||Ax-b||_2^2 \n');
 
  do
    for i = 1 : n
      for j = 1 : n
        fprintf('A(%d', i),fprintf(',%d', j), A(i,j) = input (')==>');
      endfor  
    endfor
  
    for i = 1 : n
      fprintf('b(%d', i), b(i) = input (')==>');
    endfor
  
    fprintf ('Entrer les valeures de litérée initiale \n');
  
    for i = 1 : n
      fprintf('x0(%d', i), x0(i) = input (')==>');
    endfor
  
    fprintf ('le problème est carctérisé par: \n');
    Q = 0.5*A'*A, c = b*A, p = 0.5*b*b', x0
    %calcule Q, c et p d'apres nos constatations
    [], b = eig(Q);
    %b = vecteur composé des valeures propres
  until (b > 0)
  %tant que la matrice Q n est pas definie positive, l'utilisateur recommence !
  
  
endif

endfunction

