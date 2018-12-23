
function [W,H,e,t]=nmf_Magana(X,W0,H0,timelimit)
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
    iter=iter+1;
    
   %%Optimisation de H
    % On fait n problemes nnls, un pour chaque cologne de H
    % La cologne 'i' de H -->  H(:,i)
    % La matrice W
    % La cologne 'i' de X -->  X(:,i)
    % A partir de :
    %  X(:,i) = W*H(:,i)
    % On peut le reecrire (pour le cas optimale) de la
    % façon suivante:
    %   W*H(:,i) - X(:,i)  = 0
    %   A*x      - b       = 0
    % On peut donc appeler la fonction nnls:
    %   A = W
    %   x = H(:,i)
    %   b = X(:,i)
    % [x     ,      _e,     _t] = nnls_Guily_Magana(A, b,      x0,      _timelimit, 2)
    % [H(:,i), _erreur, _temps] = nnls_Guily_Magana(W, X(:,i), H0(:,i), _timelimit, 2)
    % 2 c'est la methode du gradient accelere, celle que l'on a trouvee optimale. 
    for i=1:n
      [H(:,i), _e, _t] = nnls_Guily_Magana(W,X(:,i),H0(:,i), 0.05*timelimit, 2)
    endfor
    
   %%Optimisation de W
    % On fait m problemes nnls, un pour chaque file de W
    % La file 'i' de W -->  W(i,:)
    % La matrice H
    % La file 'i' de X -->  X(i,:)
    % A partir de :
    %  X(i,:) = W*H(i,:)
    % On peut le reecrire (pour le cas optimale) de la
    % façon suivante:
    %   W*H(i,:) - X(i,:)  = 0
    %   A*x      - b       = 0
    % On peut donc appeler la fonction nnls:
    %   A = H
    %   x = W(i,:)
    %   b = X(i,:)
    % [x     ,      _e,     _t] = nnls_Guily_Magana(A, b,      x0,      _timelimit, 2)
    % [H(i,:), _erreur, _temps] = nnls_Guily_Magana(W, X(i,:), H0(1,:), _timelimit, 2)
    % 2 c'est la methode du gradient accelere, celle que l'on a trouvee optimale. 
    for i=1:n
      [W(:,i), _e, _t] = nnls_Guily_Magana(H,X(i,:),W0(i,:), 0.05*timelimit, 2)
    endfor
    
    %Calcul du temps et de l'erreur
    time_lost = cputime;
    e         = [e nX-2*sum(sum((X*H').*W))+sum(sum((H*H').*(W'*W)))];
    temps     = temps+(cputime-time_lost);
    t         = [t cputime-temps];
  end
end