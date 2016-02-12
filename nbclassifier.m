function[per_avg,output,output1]=nbclassify(train,labeltr,test,labelte,alpha)
    %% Initializing likelihood matrix corresponding to probability of each frequency count.
    test=full(test);
    labelte=full(labelte);
    train=full(train);
    labeltr=full(labeltr);
    F0=zeros(max(train(:))+1,size(train,2));
    F1=zeros(max(train(:))+1,size(train,2));
    mat1=zeros(1,size(train,2));
    mat0=zeros(1,size(train,2));
    count0=0;
    count1=0; 
    ctr1=0; ctr2=0;
    c0=0;c1=0;itr=1;
    V=size(train,2);    
    for alpha=1:1:1000
    %% Calculating fraction of documents that belonging to class 0, and class 1
for i=1:length(labeltr)
    if(labeltr(i)==0)
        count0=count0+1;
        for j=1:size(train,2)
        mat0(1,j)=mat0(1,j)+train(i,j); % Average Frequency of each word in class 0
        F0(train(i,j)+1,j)=F0(train(i,j)+1,j) + 1; % Frequency of each word in class 0
        end
        F0=F0+(alpha-1);
        mat0=mat0+(alpha-1);
    else
        count1=count1+1;
        for j=1:size(train,2)  
        mat1(1,j)=mat1(1,j)+train(i,j); % Average Frequency of each word in class 1
        F1(train(i,j)+1,j)=F1(train(i,j)+1,j) + 1; % Frequency of each word in class 1
        end
        F1=F1+(alpha-1);
        mat1=mat1+(alpha-1);
    end
end
P_0=count0/length(labeltr);
P_1=count1/length(labeltr);

M0=(mat0)./(sum(mat0));
M1=(mat1)./(sum(mat1));
for i=1:size(F0,1)
    P0=(F0)./(sum(F0(:,i)));
end
for i=1:size(F1,1)
    P1=(F1)./(sum(F1(:,i)));
end
%% Classifier- Multinomial Distribution
for i=1:size(test,1)
    for j=1:size(test,2)
        if(P0(test(i,j)+1,j)~=0 && P1(test(i,j)+1,j)~=0)
        c0=c0+log(P0(test(i,j)+1,j));
        c1=c1+log(P1(test(i,j)+1,j));
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
%% Accuracy Multinomial Method
for i=1:length(output1)
    if(output1(i,1)==labelte(i,1))
        ctr1=ctr1+1;
    end
end
per_mn(itr,2)=ctr1/length(labelte);
per_mn(itr,1)=alpha;
%% Classifier-Average method
for i=1:length(labelte)
    
    c0=P_0*prod(M0.^test(i,:));
    c1=P_1*prod(M1.^test(i,:));
    
    if(c0>c1)
        output(i,1)=0;
    else
        output(i,1)=1;
    end
end
ctr2=0;
%% Accuracy Average Method
for i=1:length(output1)
    if(output(i,1)==labelte(i,1))
        ctr2=ctr2+1;
    end
end
per_avg(itr,2)=ctr2/length(labelte);
per_avg(itr,1)=alpha;
itr=itr+1;
 count0=0;
    count1=0; 
    ctr1=0; ctr2=0;
    c0=0;c1=0;

    end
% save result per_mn per_avg
end