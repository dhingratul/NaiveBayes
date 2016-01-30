clear all;
close all;
clc;
count0=0;
count1=0;
load reuters.mat;
mat1=zeros(1,size(train,2));
mat0=zeros(1,size(train,2));
test=full(test);
testy=full(testy);
train=full(train);
trainy=full(trainy);
%% Calculating fraction of documents that belong to class 0, and class 1
for i=1:length(trainy)
    if(trainy(i)==0)
        count0=count0+1;
        for j=1:size(train,2)
        mat0(1,j)=mat0(1,j)+train(i,j); 
        end
        
    else
        count1=count1+1;
        for j=1:size(train,2)
        mat1(1,j)=mat1(1,j)+train(i,j); 
        end
    end
end
P_0=count0/length(trainy);
P_1=count1/length(trainy);


% mat0=mat0./count0;
% mat1=mat1./count1;

