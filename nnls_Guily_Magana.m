function [x,e,t]=nnls_Guily_Magana(A,b,x0,timelimit,choix)
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
  gamma = (A'*b)/(A'*A*x0); %COMPLETER ICI
  x0     = gamma*x0;
 
  x = [];
  x1 = x0;
  
  %Initialisation des vecteurs erreurs et temps
  temps = cputime;
  t     = 0;
  e     = 0.5*(x0'*AtA*x0-2*Atb'*x0+btb); 
  
  %alpha = 0.9; %necessaire pour la methode du gradient accelere
  alpha = 0.9;
  iter  = 0;
  while cputime-temps<=timelimit
    
    
    
    if choix==1
    
    
    f = 0.5*(x0'*AtA*x0-2*Atb'*x0+btb);
    %calcule la valeur de f a chaque iteree.
    delta = AtA*x0 - Atb; 
    %calcule le gradient a chaque iteree. 
   
    
    
    % ICI :Algorithme à implémenter
    alpha = (delta'*delta)/(delta'*AtA*delta);
	  %alpha = 1/L;
    x0 = max(x0 - alpha*delta,0);
   
    
    
    end
    
    if choix==2
      
      
      f = 0.5*(x0'*AtA*x0-2*Atb'*x0+btb);
      %calcule la valeur de f a chaque iteree.
      delta = AtA*x0 - Atb; 
      %calcule le gradient a chaque iteree. 
    
      beta = (iter - 1)/(iter + 2);
  	  y = x0 + beta*(x0 - x1);
      %CF enonce
    
      x1 = x0 ;
      %x0 = x(i-1);
    
      deltaY = AtA*y - Atb;
      
      %calcule delta(y)
      x0=max(y - (1/L)*deltaY,0);
      %mise à jour de X
    end
    
    
    if choix==3
      n = length(x0);
      B = 0;
      f = 0.5*(x0'*AtA*x0-2*Atb'*x0+btb);
      %calcule la valeur de f a chaque iteree.
      delta = AtA*x0 - Atb; 
      %calcule le gradient a chaque iteree.
      
      %% Choisir la variable a minimiser aleatoirement:
      j = ceil(rand(1)*n);       
    
      if (delta(j) == 0)
        %% Si la derivee partielle selon la variable x_j
          %% vaut zero, x_j reste la meme
      else          
        
      
        for o = 1:n
          if (o != j) 
            
            B += (AtA(j,o)*x0(o) + AtA(o,j)*x0(o))/2; 
          endif
        endfor
        
        % Mettre a jour la variable x_j :
        x0(j) = (B - Atb(j))/(-AtA(j,j)) ;
        
        x0(j) = max(0, x0(j)) ; % Projection sur le domaine contraint 
        %mise en commentaire car inutile à la comparaison graphique
        %n'hésitez pas à retirer % pour observer le résultat
     endif
    
    endif 
    
    %Calcul du temps et de l'erreur
    time_lost = cputime;
    %e         = [e 0.5*(x'*AtA*x-2*Atb'*x+btb)]; 
    temps     = temps+(cputime-time_lost);
    t         = [t, cputime-temps];
    iter=iter+1;
    
    x = [x, x0]; % ajouter l'iteree anterieure
    
    e = [e, f] ; % Calcul de l'erreur 
  end

end