clear all; clc; close all;
load exemplenmf1.mat;

% X est definie dans exemplenmf1.mat
[m, n] = size(X);

% Notre parametre arbitraire:
r  = 2;

RND    = rand(m, r);
W0     = X * RND;
H0     = rand(r, n);

timelimit=10;
[W,H,e,t]=nmf_Magana(X,W0,H0,timelimit);

%Graphes de l'erreur
semilogy(t,e);