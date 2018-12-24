clear all; clc; close all;
load exemplenmf2.mat;


%Affichage de visages
nbvisages = 100; %pour ne pas travailler sur l'ensemble des 2429 visages, mais on pourrait !
Xtemp=X(:,1:nbvisages);
affichage(Xtemp,20,19,19);

r = 8;
timelimit=30;

[m,n]=size(Xtemp);

W0=rand(m,r);
H0=rand(r,n);

[W,H,e,t]=nmf_Guily_Magana(Xtemp,W0,H0,timelimit);

%Affichage du facteur W
affichage(W,4,19,19);

%Affichage facteur H
%affichage(H,4,8,1);

%Affichage de l'approximation W*H
affichage(W*H,20,19,19);