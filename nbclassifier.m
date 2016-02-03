clear all;
close all;
clc;
count0=0;
count1=0;
count=0;
c0=1;
c1=1;
P0=zeros(50,5180);
P1=zeros(50,5180);
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
        mat0(1,j)=mat0(1,j)+train(i,j); % Average Frequency of each word in class 0
%         P0(train(i,j)+1,j)=P0(train(i,j)+1,j) + train(i,j);
        end
        
    else
        count1=count1+1;
        for j=1:size(train,2)
        mat1(1,j)=mat1(1,j)+train(i,j); % Average Frequency of each word in class 1
%         P1(train(i,j)+1,j)=P1(train(i,j)+1,j) + train(i,j);
        end
    end
end
P_0=count0/length(trainy);
P_1=count1/length(trainy);
mat0=(mat0)./(sum(mat0));
mat1=(mat1)./(sum(mat1));
% P0=P0./sum(P0(:));
% P1=P1./sum(P1(:));
%% Classifier-Average method
for i=1:length(testy)
    
    c0=P_0*prod(mat0.^test(i,:));
    c1=P_1*prod(mat1.^test(i,:));
    
    if(c0>c1)
        output(i,1)=0;
    else
        output(i,1)=1;
    end
end

% %% Classifier- Multinomial Distribution
% for i=1:length(testy)
%     for j=1:size(test,2)
%        a=a+log(P0(test(i,j)+1,j));
%        b=b+log(P1(test(i,j)+1,j));
%     end
%     a=a+log(P_0);
%     b=b+log(P_1);
%     if(a>b)
%         output1(i,1)=0;
%     else
%         output1(i,1)=1;
%     end
% end
%% Accuracy- Average Method
for i=1:length(output)
    if(output(i,1)==testy(i,1))
        count=count+1;
    end
end
per=count/length(testy)*100