function [XX,YY,P] = Component_build(T1,T2,sigma)
N=128; %inversion data point
aa=0.1; % left relaxation time
bb=10000;%right relaxation time 
T2x=logspace(log10(aa),log10(bb),N);%define the T2 time series
T1x=logspace(log10(aa),log10(bb),N);%define the T1 time series
T2x=log10(T2x);
T1x=log10(T1x);
[XX,YY]=meshgrid(T2x,T1x);
P=exp(-((XX-log10(T2)).^2+(YY-log10(T1)).^2)./2/sigma^2); 
P(find( P<0.01 ))=0;
P=P/sum(P(:));
end
