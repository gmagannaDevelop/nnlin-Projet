function [x,e,t]=nnls_nomequipe(A,b,x0,timelimit,choix)
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
  gamma = .....; %COMPLETER ICI
  x     = gamma*x0;
  
  [Q, x0, c, p] = quadfunctiongenerator(choix);
  
  %Initialisation des vecteurs erreurs et temps
  temps = cputime;
  t     = 0;
  e     = 0.5*(x'*AtA*x-2*Atb'*x+btb); 
  
  alpha = 0.9; %necessaire pour la methode du gradient accelere
  iter  = 0;
  while cputime-temps<=timelimit
    iter=iter+1;
    
    if choix==1
      %COMPLETER ICI
    end
    
    if choix==2
      %COMPLETER ICI
    end
    
    
    if choix==3
      n = length(x);
  
  %generer soit meme la fonction quadratique
  
  maxiter = input ( 'Nombre de iterations : '); 
  
  [x, z] = coordinatedescent(Q,c,p,x0,maxiter);
  % implemente la descente de coordonnees en choisissant 
  % les variables aleatoirement.
  
  visualizer(x, z, Q, c, p);
  % visualisation graphique des iterations et de la fonction
    end   
    
    %Calcul du temps et de l'erreur
    time_lost = cputime;
    e         = [e 0.5*(x'*AtA*x-2*Atb'*x+btb)]; 
    temps     = temps+(cputime-time_lost);
    t         = [t cputime-temps];
  end
end