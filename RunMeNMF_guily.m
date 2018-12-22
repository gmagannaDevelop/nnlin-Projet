clear all; clc; close all;
load exemplenmf1.mat;

W0=%COMPLETER ICI
H0=%COMPLETER ICI

timelimit=10;
[W,H,e,t]=nmf_nomequipe(X,W0,H0,timelimit);

%Graphes de l'erreur
semilogy(t,e);