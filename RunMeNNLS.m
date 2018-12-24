clear all; clc; close all;
load exemplennls1.mat;

timelimit=10;
% time for calculation

[x_1,e_1,t_1]=nnls_Guily_Magana(A,b,x0,timelimit,1);
[x_2,e_2,t_2]=nnls_Guily_Magana(A,b,x0,timelimit,2);
[x_3,e_3,t_3]=nnls_Guily_Magana(A,b,x0,timelimit,3);


%Graphes des erreurs
semilogy(t_1,e_1); hold on;
semilogy(t_2,e_2,'r');
semilogy(t_3,e_3,'m');
legend('Meth. du gradient','Grad. Acc.','Coo. Desc.');