clear all; clc; close all;
load exemplenmf1.mat;

[m,n]=size(X);
W0=rand (m,3);
H0=rand(3,n);

timelimit=1;
[W,H,e,t]=nmf_Guily_Magana(X,W0,H0,timelimit);

%Graphes de l'erreur
semilogy(t,e);