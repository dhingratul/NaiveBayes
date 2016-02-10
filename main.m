clear all;
close all;
clc;

load reuters.mat
per=nbclassify(train,trainy,test,testy,1);