function [W,H,e,t]=nmf_nomequipe(X,W0,H0,timelimit)
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
  
  iter  = 0;
  
  
  while cputime-temps<=timelimit
    
    
    %Optimisation de H
    %COMPLETER ICI
    %calcule la valeur de f a chaque iteree.
    
    
    L1   = max(eig(2*W'*W));
    
    
    
    
    for j = 1 : n
      for o = 1 : 10
        iter  =  iter+1;
        beta = (iter - 1)/(iter + 2);
      #delta1 =   2* W'*W*H(:,j) - 2*W'*X(:,j);
##      %calcule le gradient a chaque iteree. 
      
      
##    
##      %accelerate Nesterov
        if (iter != 1)
          y1 = H(:,j) + beta*(H(:,j) - H1);
        else 
          y1 = H(:,j);
##      %CF enonce
        endif
        H1 = H(:,j) ;
##      
##      
##    
        deltaY1 = 2*W'*W*y1 - 2*W'*X(:,j);
##      
##      %calcule delta(y)
        H(:,j) =  y1 - (1/L1)*deltaY1;
##      %mise à jour de X
      endfor
    iter = 0;
    endfor
    
      
    %H = max (0,H);
      
    %Optimisation de W
    %COMPLETER ICI
    L2   = max(eig(2*H*H'));
    
    
    for i = 1 : m
      for k = 1 : 20
        iter  =  iter+1;
        beta = (iter - 1)/(iter + 2);
      #delta =   2*H*H'*W(i,:)' - 2*H*X(i,:)';
##      %calcule le gradient a chaque iteree. 
      
        if (iter == 1) 
          y = W(i,:)';
##      %accelerate Nesterov
        else 
          y = W(i,:)' + beta*(W(i,:)' - W1);
##      %CF enonce
        endif

        W1 = W(i,:)' ;
##      
##      
##    
        deltaY = 2*H*H'*y - 2*H*X(i,:)';
##      
##      %calcule delta(y)
        W(i,:) = y' - (1/L2)*deltaY';
##      %mise à jour de X
      endfor
      iter = 0;
    endfor
    
    
    
    %Calcul du temps et de l'erreur
    %W = max(0,W);
    
    time_lost = cputime;
    e         = [e nX-2*sum(sum((X*H').*W))+sum(sum((H*H').*(W'*W)))];
    temps     = temps+(cputime-time_lost);
    t         = [t cputime-temps];
  end
end