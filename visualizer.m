
function  visualizer(x, z, Q, c, p)
clf;

  %% Calculer les bornes du grid:
  x1_low = x(1,1);
  x1_hi  = x(size(x)(1),1) - x1_low;
  x2_low = x(1,2);
  x2_hi  = x(size(x)(1),2) - x2_low;
  
  %% Creer le grid avec la resolution desiree:
  n=size(x)(2);
  resolution = 50;
  x1 = (linspace(x1_low, x1_hi, resolution))';
  x2 = (linspace(x2_low, x2_hi, resolution))';
  v = [];
  
  %% Calculer la valeur de la fonction 
  %% en prennant compte seulement les deux premieres variables:
  for i=1:resolution
    for j=1:resolution
      w(1)  = x1(i);
      w(2)  = x2(j);
      for m = 3:n
        w(m)= 0; %% 'Annuler la contribution de x_{i} pour les i >= 3'
      endfor  
        [_tmp, _] = fcalculator(Q, w, c, p);
        v(i,j) = _tmp;
    endfor
  endfor 
  
  %% Afficher la trajectoire prise par l'algorithme:
  plot3(x(:,1), x(:,2), z,'r');
  hold on;
  %% Afficher des boules autour de chaque iteree:
  scatter3(x(:,1), x(:,2), z,'k');
  hold on;
  hidden off;
  %% Afficher la surface de la fonction:
  [xx, yy] = meshgrid (x1, x2);
  meshc(x1,x2,v);

endfunction
