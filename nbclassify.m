function[per_avg,out_label,output1]=nbclassify(train,labeltr,test,labelte,alpha)
    %% Initializing frequency count.
    test=full(test);
    labelte=full(labelte);
    train=full(train);
    labeltr=full(labeltr);
    F1=zeros(1,size(train,2));
    F0=zeros(1,size(train,2));
    count0=0;
    count1=0; 
    ctr1=0; ctr=0;
    c0=0;c1=0;itr=1;
    V=size(train,2);    %Size of vocabulary
%     for alpha=1:1:1000
    %% Calculating fraction of documents that belonging to class 0, and class 1
for i=1:length(labeltr)
    if(labeltr(i)==0)
        count0=count0+1;
        for j=1:size(train,2)
        F0(1,j)=F0(1,j)+train(i,j); % Average Frequency of each word in class 0
        end
        F0=F0+(alpha-1);%Dirichlet Prior
    else
        count1=count1+1;
        for j=1:size(train,2)  
        F1(1,j)=F1(1,j)+train(i,j); % Average Frequency of each word in class 1
        end
        F1=F1+(alpha-1);%Dirichlet Prior
    end
end
P_0=count0/length(labeltr);
P_1=count1/length(labeltr);
%% Probability Calculation
P0=(F0)./(sum(F0)); %Probability of class 0
P1=(F1)./(sum(F1)); %Probability of class 1
for i=1:size(F0,1)
    P0=(F0)./(sum(F0(:,i))); % Conditional Probability of class 0
end
for i=1:size(F1,1)
    P1=(F1)./(sum(F1(:,i))); % Conditional Probability of class 1
end

%% Classifier
for i=1:length(labelte)
    
    c0=P_0*prod(P0.^test(i,:)); %Class 0 calculation
    c1=P_1*prod(P1.^test(i,:)); %Class 1 calculation
    % Taking argmax betwen c0 and c1
    if(c0>c1)
        out_label(i,1)=0;
    else
        out_label(i,1)=1;
    end
end
ctr=0;
%% Accuracy 
for i=1:length(out_label)
    if(out_label(i,1)==labelte(i,1))
        ctr=ctr+1;
    end
end
per_avg(itr,2)=ctr/length(labelte);
per_avg(itr,1)=alpha;
itr=itr+1;
    count0=0;
    count1=0; 
    ctr=0;
    c0=0;c1=0;

end
% end