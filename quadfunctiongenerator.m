

## Author: ThomasGuily, Gustavo Maga�a Lopez
## Created: 2018-11-19

function [Q, x0, c, p] = quadfunctiongenerator (choix)

%L'utilisateur entre la fonction quadratique  
if (choix == 0)
  
  
  n = input ('Choix du nombre de variables: n = ');
  %valable quel que soit le nombre de dimensions choisies
  fprintf ('Entrer les valeures des �l�ments de Q, de c et de la constante p \n');
  
  do
    fprintf ('Attention ! Q doit �tre d�finie positive pour poss�der un point minimum global \n');
    for i = 1 : n
      for j = 1 : n
        fprintf('Q(%d', i),fprintf(',%d', j), Q(i,j) = input (')==>');
      endfor  
    endfor
    
    for i = 1 : n
      fprintf('c(%d', i), c(i) = input (')==>');
    endfor
    p = input ('p ==>');
  
    fprintf ('Entrer les valeures de lit�r�e initiale \n');
  
    for i = 1 : n
      fprintf('x0(%d', i), x0(i) = input (')==>');
    endfor
  
    fprintf ('le probl�me est carct�ris� par: \n');
    Q , c, p, x0 
    [], b = eig(Q);
    %b = vecteur compose des valeures propres
    
  until (b > 0)
  %tant que la matrice Q n'est pas d�finie positive, l'utilisateur recommence

   
  %L'utilisateur rentre A et b pour d�finir la fonction minimisant ||Ax-b||_2^2)
else 
  
  n = input ('Choix du nombre de variables: n = ');
  %valable quel que soit le nombre de dimensions choisies
  fprintf ('Entrer les valeures des �l�ments de A et de b qui caract�rise le probl�me du moindre carr� min||Ax-b||_2^2 \n');
 
  do
    for i = 1 : n
      for j = 1 : n
        fprintf('A(%d', i),fprintf(',%d', j), A(i,j) = input (')==>');
      endfor  
    endfor
  
    for i = 1 : n
      fprintf('b(%d', i), b(i) = input (')==>');
    endfor
  
    fprintf ('Entrer les valeures de lit�r�e initiale \n');
  
    for i = 1 : n
      fprintf('x0(%d', i), x0(i) = input (')==>');
    endfor
  
    fprintf ('le probl�me est carct�ris� par: \n');
    Q = 0.5*A'*A, c = b*A, p = 0.5*b*b', x0
    %calcule Q, c et p d'apres nos constatations
    [], b = eig(Q);
    %b = vecteur compos� des valeures propres
  until (b > 0)
  %tant que la matrice Q n est pas definie positive, l'utilisateur recommence !
  
  
endif

endfunction

