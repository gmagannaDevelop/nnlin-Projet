function [W,H,e,t]=nmf_Guily_Magana(X,W0,H0,timelimit)
  % Entrees :
  % X est une matrice m x n
  % W0 est une matrice m x r
  % H0 est une matrice r x n
  % timelimit est le temps de resolution
  
  % Sorties :
  % W est une matrice m x r
  % H est une matrice r x n
  % e est le vecteur contenant les erreurs
  % t est le vecteur contenant les temps auxquels les erreurs ont ete calculees
  
  
  nX    = norm(X,'fro')^2; 
  [m,n] = size(X);
  [m,r] = size(W0);
  
  %Scaling
  A = X*H0';
  B = H0*H0';
  scale = sum(sum(A.*W0))/sum(sum(B.*(W0'*W0)));
  W=W0*scale;
  H=H0;
  
  %Initialisation des vecteurs erreurs et temps
  temps = cputime;
  t     = 0;
  e     = nX-2*sum(sum(A.*W))+sum(sum(B.*(W'*W)))
  
  %iter  = 0;
  
  %beta = 0;
  while cputime-temps<=timelimit
    
    %iter  =  iter+1;
    
    
    %Optimisation de H (après avoir essayer des méthodes accélérées dérivé de la méthode
    %du gradient, nous nous sommes rendu compte que le choix du pas est très complexe)
    
    %la collone de W qui sera optimisée est choisie au hasard
    j = ceil(rand(1)*n); 

    %calcule delta(y)
    delta = 2*W'*W*H(:,j) - 2*W'*X(:,j);
   
    %alpha = 1/ max(eig(2*W'*W));
    %pas valant l'inverse de la plus haute valeur propre
    
    alpha = (delta'*delta)/(delta'*2*W'*W*delta);
    %Meilleur pas pour le sous problème quadratique considéré 
    
    H(:,j) =  max(0,H(:,j) - alpha*delta);
    %mise à jour de H + projection
    
    
    
    %OPTI de W
      
    i = ceil(rand(1)*m); 
    %La ligne de W qui sera optimisée est choisie au hasard

    delta = 2*H*H'*W(i,:)' - 2*H*X(i,:)';
    %calcule le gradient du sous problème
    
    %alpha = 1/max(eig(2*H*H'));
    
    alpha = (delta'*delta)/(delta'*2*H*H'*delta);
    %pas optimal
    
    W(i,:) = max (0,W(i,:) - alpha*delta');
    %mise à jour de W 
    
    %Calcul du temps et de l'erreur
    time_lost = cputime;
    e         = [e nX-2*sum(sum((X*H').*W))+sum(sum((H*H').*(W'*W)))];
    temps     = temps+(cputime-time_lost);
    t         = [t cputime-temps];
  end
end