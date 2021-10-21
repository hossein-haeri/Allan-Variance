clear all
clc
close all


t = normrnd(100,5,[5000,1]);

t = sort(t);
t = t+t(0);


x = normrnd(0,1,5000);

taus = (1:50);
avar = AVAR2(t,x,taus);

loglog(avar)