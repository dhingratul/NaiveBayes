clear all;
close all;
clc;
count0=0;
count1=0;
count=0;
a=1;
b=1;
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
mat0=mat0./sum(mat0);
mat1=mat1./sum(mat1);

%% Classifier
for i=1:length(testy)
    
    a=P_0*prod(mat0.^test(i,:));
    b=P_1*prod(mat1.^test(i,:));
    
    if(a>b)
        output(i,1)=0;
    else
        output(i,1)=1;
    end
end
%% Accuracy
for i=1:length(output)
    if(output(i,1)==testy(i,1))
        count=count+1;
    end
end
per=count/length(testy)*100