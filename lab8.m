
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title: EGR223-02 Lab 7
% Filename: lab8.m
% Author: Dixit Gurung
% Date: 3/25/2020
% Instructor: Dr. Nicholas Baine
% Description: Work with expectation and multiple variables.
% Explore formulations for linear regression.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
%{
%%%PART 2
%%%%%%%%%%%%baseline.txt%%%%%%%%%%%%%%%%%%%%%
baseline = load('Baseline.txt', '-ascii');
[covar1,corel1,stdX1,stdY1,meanX1,meanY1] = covarandcorel(baseline);

alpha1 = (corel1*stdY1)/stdX1;
beta1 = meanY1 - (alpha1*meanX1);

figure
plot(baseline(:,1),baseline(:,2),'*','MarkerSize',2)
xlabel('electrical data');
ylabel('pressure data');
title(' electrical versus pressure data for Baseline.txt');
hold on
  x= linspace(-75,150, 100);
  y= (alpha1*x) + beta1;
  plot(x,y,'LineWidth',2)
hold off


%%%%Reaperfusion.txt%%%%%%%%%%%%%%%%%%%%%%%%%%%
Reaperfusion = load('Reaperfusion.txt', '-ascii');
[covar2,corel2,stdX2,stdY2,meanX2,meanY2] = covarandcorel(Reaperfusion);

alpha2 = (corel2*stdY2)/stdX2;
beta2 = meanY2 - (alpha2*meanX2);

figure
plot(Reaperfusion(:,1),Reaperfusion(:,2),'*','MarkerSize',2)
xlabel('electrical data');
ylabel('pressure data');
title(' electrical versus pressure data for Reaperfusion.txt');
hold on
  x= linspace(-75,225, 400); 
  y= (alpha2*x) + beta2;
  plot(x,y,'LineWidth',2)
hold off

%}

%%{
%%%%part 3%%%%%%%%%%%%%%%%%%%%%
S = load('lab8_data.mat', '-mat');

one = ones(1000,1);
M = [S.A(:),S.B(:),one(:)]; %merging three column vectors to form a 3*1000 [MATRIX M]
P = S.Vout;
P = (P');
MT = (M');
unknown = MT*M;
unknown = inv(unknown);
unknown = unknown * MT *P;
alpha1 = unknown(1,1);
alpha2 = unknown(2,1);
beta = unknown(3,1);

%Empirical normalized prediction error
stdP = std(P);
A = S.A;
A = A';
B = S.A;
B = B';
E = abs((alpha1*A) + (alpha2*B) + beta );
E = (P - E).^(2);
E = (sum(E))/999;
E = E / (stdP^2);
E = sqrt(E);

figure
plot3(A,B,P,'o','MarkerSize',2)
xlabel('A');
ylabel('B');
zlabel('Vout');
title(' plot for  multiple variable model');
hold on
minX1 = min(A);
maxX1 = max(A);
minX2 = min(B);
maxX2 = max(B);

XA= linspace(minX1,maxX1, 1000);
XB= linspace(minX2,maxX2, 1000);
Y = (alpha1*A) +(alpha2*B) + beta;
plot3(XA, XB, Y);
legend('cos(x)','cos(2x)')
view(200,300)
hold off

%%}