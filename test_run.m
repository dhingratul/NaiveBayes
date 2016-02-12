clear all;
close all;
clc;

load reuters.mat
alpha=3;
[per, output]=nbclassify(train,trainy,test,testy,alpha);
% disp(output);