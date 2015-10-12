%neural network verisi açý yarýþlar ve lüzmsüz yarýþlar çýkarýldý

clc;
clear all;
load neuralData.mat;
n1 = neuralData(:,2) == 15;
a = size(find(n1==1));
n2 = neuralData(:,2) == 16;
b = size(find(n2==1));
n3 = neuralData(:,2) == 23;
c = size(find(n3==1));
n4 = neuralData(:,2) == 24;
d = size(find(n4==1));
n5 = neuralData(:,2) == 25;
e = size(find(n5==1));
n6 = neuralData(:,2) == 26;
f = size(find(n6==1));
n7 = neuralData(:,2) > 43;
k = size(find(n7==1));
n8 = neuralData(:,2) ==  39;
l = size(find(n8==1));
n9 = neuralData(:,2) ==  40;
m = size(find(n9==1));


a+b+c+d+e+f+k+l+m

n = n1 | n2 | n3 | n4 | n5 | n6 | n7 | n8 | n9;
h = size(find(n==1))

neuralDataKisitli = neuralData;
neuralDataKisitli(n,:) = [];
save('neuralDataKisitli','neuralDataKisitli','neuralDataLut');

