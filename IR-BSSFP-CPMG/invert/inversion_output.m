clear;
clc;
%%
%Read the inverted output file
XX=load('XX.txt');
YY=load('YY.txt');
invdata=load('2D_Distribution.txt');
%Eliminate inversion errors
invdata(invdata < 0.03) = 0;
lineplotx1=XX(1,:);
lineploty1=XX(1,:);
lineplotx2=[-1,2];
lineploty2=[1,4];
lineplotx3=[-1,3];
lineploty3=[0,4];
contourf(XX,YY,invdata,100,'LineStyle','none')
% colorbar('Ticks', [0, 0.05, 0.25]);
xlabel('log_1_0(T_2) /ms','FontSize',12,'FontWeight','Normal');
ylabel('log_1_0(T_1) /ms','FontSize',12,'FontWeight','Normal');
set(gca, 'XTick',[-1 0 1 2 3 4],'YTick', [-1 0 1 2 3 4])
hold on 
plot (lineplotx1,lineploty1,'y-','LineWidth',1.5)
plot (lineplotx2,lineploty2,'b-','LineWidth',1.5)
plot (lineplotx3,lineploty3,'r-','LineWidth',1.5)
hold off
