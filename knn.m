count=0;
p=0;
load reuters.mat;
k=knnclassify(test,train,trainy);
for i=1:1806
    if(k(i)==testy(i))
        count=count+1;
    end
end
p=count/1806