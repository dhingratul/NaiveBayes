
clear all;
close all;
clc;
idx=1;
alpha=5;
load reuters.mat;
mat1=zeros(1,size(train,2));
mat0=zeros(1,size(train,2));
test=full(test);
testy=full(testy);
train=full(train);
trainy=full(trainy);
V=size(train,2); % Size of vocabulary
%% Initializing likelihood matrix corresponding to probability of each frequency count.
F0=zeros(max(train(:))+1,size(train,2));
F1=zeros(max(train(:))+1,size(train,2));
count0=0;
count1=0;
%% Calculating fraction of documents that belonging to class 0, and class 1
for i=1:length(trainy)
    if(trainy(i)==0)
        count0=count0+1;
        for j=1:size(train,2)
        mat0(1,j)=mat0(1,j)+train(i,j); % Average Frequency of each word in class 0
        F0(train(i,j)+1,j)=F0(train(i,j)+1,j) + 1; % Frequency of each word in class 0
        end
        
    else
        count1=count1+1;
        for j=1:size(train,2)
        mat1(1,j)=mat1(1,j)+train(i,j); % Average Frequency of each word in class 1
        F1(train(i,j)+1,j)=F1(train(i,j)+1,j) + 1; % Frequency of each word in class 1
        end
    end
end
P_0=count0/length(trainy);
P_1=count1/length(trainy);
% for alpha=1:0.05:2
count=0;
c0=0;
c1=0;
mat0=(mat0+(alpha-1))./(sum(mat0)+V*(alpha-1));
mat1=(mat1+(alpha-1))./(sum(mat1)+V*(alpha-1));

for i=1:size(F0,1)
    L0=(F0+(alpha))./(sum(F0(:,i))+V*(alpha));
end
for i=1:size(F1,1)
    L1=(F1+(alpha))./(sum(F1(:,i))+V*(alpha));
end

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

%% Classifier- Multinomial Distribution
for i=1:size(test,1)
    for j=1:size(test,2)
        if(L0(test(i,j)+1,j)~=0 && L1(test(i,j)+1,j)~=0)
       c0=c0+log(L0(test(i,j)+1,j));
       c1=c1+log(L1(test(i,j)+1,j));
        end
    end
    c0=c0+log(P_0);
    c1=c1+log(P_1);
    if(c0>c1)
        output1(i,1)=0;
    else
        output1(i,1)=1;
    end
end
%% Accuracy- Average Method
for i=1:length(output1)
    if(output1(i,1)==testy(i,1))
        count=count+1;
    end
end
per(idx,2)=(count/length(testy))*100;
per(idx,1)=alpha;
idx=idx+1;
% end
% plot(per(:,1),per(:,2));
save result per;