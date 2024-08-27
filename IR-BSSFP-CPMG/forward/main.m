clear;
clc;
%%
% components
[XX,YY,T2T1bitumen]=Component_build(25.2,1.3,0.2);%bitumen  T1=25.2 T2=1.3
[~,~,T2T1A]=Component_build(617.5,175.3,0.2);%Component A
[~,~,T2T1B]=Component_build(40,6.3,0.2);%Component B
% forward modeling
lineplotx1=XX(1,:);
lineploty1=XX(1,:);
lineplotx2=[-1,2];
lineploty2=[1,4];
lineplotx3=[-1,3];
lineploty3=[0,4];
% total signal
A=0.5;
B=0.5;
tsignal=pFW2*T2T1A+pPH*T2T1A;
figure(1);
contourf(XX,YY,tsignal,100,'LineStyle','none')   
xlabel('log_1_0(T_2) /ms','FontSize',12,'FontWeight','Normal');
ylabel('log_1_0(T_1) /ms','FontSize',12,'FontWeight','Normal');
set(gca, 'XTick',[-1 0 1 2 3 4],'YTick', [-1 0 1 2 3 4])
% colorbar('Ticks', [0, 0.05, 0.25]);
hold on 
plot (lineplotx1,lineploty1,'y-','LineWidth',1.5)
plot (lineplotx2,lineploty2,'b-','LineWidth',1.5)
plot (lineplotx3,lineploty3,'r-','LineWidth',1.5)
hold off

%%
% %forward modeling echo string
%[180_x]-TI-[-¦Á/2_y]-TR/2-[¦Á_x]-TR/2-[¦Á_x]-TR/2-...-[90_x]-TE/2-[180x]-TE-[180x]-TE-...
N=128;  %inversion data point
aa=0.1;  % left relaxation time
bb=10000;  %right relaxation time 
T2x=logspace(log10(aa),log10(bb),N);  %define the T2 time series
T1x=logspace(log10(aa),log10(bb),N);  %define the T1 time series

for n=1:10
alpha=pi/36;
TR=0.1+(n-1)*0.1;
nTR=700;  %number of alpha
TE=0.2;
nTE=4096;  %number of echo

M0=100;
W=tsignal;
time=nTR*TR+nTE*TE;  % x axis
signal=zeros(128,128);

for s=1:nTR+nTE
    if s<nTR+1  %the first window
        p=s;
        q=0;
        t(s)=p*TR+q*TE;
        for i=1:128
            for j=1:128
                signal(i,j) = W(j,i)*M0*sin(alpha)*(1-2*exp((-p*TR)*((cos(alpha/2))^2/T1x(j)+(sin(alpha/2))^2/T2x(i))))*exp(-q*TE/T2x(i))/((T1x(j)/T2x(i)+1)-(T1x(j)/T2x(i)-1)*cos(alpha));
            end
        end
    else   %the second window
        p=nTR;
        q=s-nTR;
        t(s)=p*TR+q*TE;
        for i=1:128
            for j=1:128
                 signal(i,j) = W(j,i)*M0*sin(alpha)*(1-2*exp((-p*TR)*((cos(alpha/2))^2/T1x(j)+(sin(alpha/2))^2/T2x(i))))*exp(-q*TE/T2x(i))/((T1x(j)/T2x(i)+1)-(T1x(j)/T2x(i)-1)*cos(alpha));
            end
        end
    end
     ts(s,n)=sum(sum(signal));
end
figure(2);
plot(ts,'r-','LineWidth', 1.5);
xlim=get(gca,'Xlim');  
hold on
plot(xlim,[0,0],'k--','LineWidth',1)
% hold off
end
