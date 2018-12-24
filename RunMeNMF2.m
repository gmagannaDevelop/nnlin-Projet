clear all; clc; close all;
I = imread ("pl-originale.png");

X1 = double(I(:,:,1));
X2 = double(I(:,:,2));
X3 = double(I(:,:,3));

[m,n]=size(X1);

r = 12 ;
timelimit=10;

W0=rand (m,r);
H0=rand(r,n);
[W1,H1,e,t]=nmf_Guily_Magana(X1,W0,H0,timelimit);
X1t=W1*H1;

W0=rand (m,r);
H0=rand(r,n);
[W2,H2,e,t]=nmf_Guily_Magana(X2,W0,H0,timelimit);
X2t=W2*H2;

W0=rand (m,r);
H0=rand(r,n);
[W3,H3,e,t]=nmf_Guily_Magana(X3,W0,H0,timelimit);
X3t=W3*H3;

I(:,:,1)=uint8(X1t);
I(:,:,2)=uint8(X2t);
I(:,:,3)=uint8(X3t);
oldString = "pl-reduite_r=";
string = ".png";
newString = sprintf('%s%d%s', oldString, r,string);
imwrite(I,newString);

