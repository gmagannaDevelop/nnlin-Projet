clear all; clc; close all;
load exemplenmf1.mat;

[m,n]=size(X);
r=3;
W0=rand(m,r);
H0=rand(r,n);
%cette initialisation semble �tre la meilleure (d'autres possibilit�s ont �t� test�es)
timelimit=2;
[W,H,e,t]=nmf_Guily_Magana(X,W0,H0,timelimit);

%Graphes de l'erreur
semilogy(t,e);