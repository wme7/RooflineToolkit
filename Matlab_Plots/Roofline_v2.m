% Plot Roofline and Measurements
clear; clc; close all;
 
%% Color Panteon
% name     R          G         B       
% ======================================
blue  =  [     0    0.4470    0.7410];
orange = [0.8500    0.3250    0.0980];
yellow = [0.9290    0.6940    0.1250];
purple = [0.4940    0.1840    0.5560];
green =  [0.4660    0.6740    0.1880];
cyan  =  [0.3010    0.7450    0.9330];
red   =  [0.6350    0.0780    0.1840];

%% Plot the Roofline data

% setup plotting stile for figures
set(0,'defaultTextInterpreter','latex')
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',20,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',18,...
'DefaultLineLineWidth',1.5,...
'DefaultAxesBox','on',...
'defaultAxesLineWidth',1.0,...
'DefaultFigureColor','w',...
'DefaultLineMarkerSize',8.0)

GFLOPsnominal = 1455.0; % x10^9 FLOP/s 
GFLOPsmax = 1236.88; % x10^9 FLOP/s
nominalBandwidth = 240; % x10^9 Bytes/s
maxBandwidth = 133.8; % x10^9 Bytes/s

% -----------------------------------
% Performance = bandwidth X intensity 
% -----------------------------------

x_FL_Nominal=[8/nominalBandwidth,GFLOPsnominal/nominalBandwidth,1E4];
y_FL_Nominal=[8,GFLOPsnominal,GFLOPsnominal];

x_FL_100_DRAM=[0.01,2,1E4];
y_FL_100_DRAM=[5.5,GFLOPsmax,GFLOPsmax];

x_FL_100_L1=[0.01,9,1E4];
y_FL_100_L1=[1.5,GFLOPsmax,GFLOPsmax];

x_FL_50=[3.0,1E4];
y_FL_50=[GFLOPsnominal/2,GFLOPsnominal/2];

x_FL_25=[1.5,1E4];
y_FL_25=[GFLOPsnominal/4,GFLOPsnominal/4];

x_FL_10=[0.6,1E4];
y_FL_10=[GFLOPsnominal/10,GFLOPsnominal/10];

GFlop = 1E9;
GByte = 1E6;
ms = 1E-3; % [1ms = 1/1000s]

% Kernels Measurements
Ttotal=0;
Wtotal=0;
Itotal=0;

% WENO5_x Operator
% [ShMem, BlokSweep, PlaneSweep]
T = [2*2.4,10.32,8.467]*ms;
Qw= [42.47,61.17,56.066];
Qr= [97.43,66.78,25.546];
W = [2*6.67E8,10.7E8,9.8E8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernelf=I;
y_Kernelf=P;

Ttotal = Ttotal + T(1);
Wtotal = Wtotal + W(1);
Itotal = Itotal + I(1);

% WENO5_y Operator
% [ShMem, BlokSweep, PlaneSweep]
T = [2*3.52,3.1,5.372]*ms;
Qw= [38.76,34.28,12.59];
Qr= [103.96,102.70,7.825];
W = [2*6.67E8,10.7E8,9.8E8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernelg=I;
y_Kernelg=P;

Ttotal = Ttotal + T(2);
Wtotal = Wtotal + W(2);
Itotal = Itotal + I(2);

% WENO5_z Operator
% [ShMem, BlokSweep, PlaneSweep]
T = [2*3.59,3.0,5.295]*ms;
Qw= [37.34,34.28,12.726];
Qr= [103.57,102.93,7.7555];
W = [2*6.67E8,10.7E8,9.8E8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernelh=I;
y_Kernelh=P;

Ttotal = Ttotal + T(2);
Wtotal = Wtotal + W(2);
Itotal = Itotal + I(2);

% Laplace Operator
T = 4*[471,438,560]*ms*ms;
Qw= [81.54,90.5,94.81];
Qr= [38.32,40.8,32.93];
W = 4*[5E6,5E6, 4.9E6];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernelL=I;
y_KernelL=P;

Ttotal = Ttotal + T(1);
Wtotal = Wtotal + W(1);
Itotal = Itotal + I(1);

% Runge Kutta (average of steps)
T = [1.8,2.36]*ms;
Qw= [108.5,95.55];
Qr= [40.99,34.77];
W = [1.47E8,1.38E8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernelRK=I;
y_KernelRK=P;

Ttotal = Ttotal + 3*T(1);
Wtotal = Wtotal + 3*W(1);
Itotal = Itotal + 3*I(1);

% Overall Performance
T=Ttotal;
W=Wtotal;

P = (W./T)/GFlop;
Q = Q*GByte;
I = Itotal;%W./Q;

x_kernelCODE=I;
y_KernelCODE=P;

% Plot Figure
fig=figure; fig.PaperUnits = 'inches'; fig.PaperPosition = [0 0 8 6];
loglog(x_kernelf(3),y_Kernelf(3),'o','Color',blue); hold on
loglog(x_kernelg(3),y_Kernelg(3),'s','Color',blue);
loglog(x_kernelh(3),y_Kernelh(3),'d','Color',blue);
loglog(x_kernelf(2),y_Kernelf(2),'o','Color',orange);
loglog(x_kernelg(2),y_Kernelg(2),'s','Color',orange);
loglog(x_kernelh(2),y_Kernelh(2),'d','Color',orange);
loglog(x_kernelf(1),y_Kernelf(1),'o','Color',yellow);
loglog(x_kernelg(1),y_Kernelg(1),'s','Color',yellow);
loglog(x_kernelh(1),y_Kernelh(1),'d','Color',yellow);
loglog(x_kernelL(3),y_KernelL(3),'^','Color',blue);
loglog(x_kernelL(2),y_KernelL(2),'^','Color',orange);
loglog(x_kernelL(1),y_KernelL(1),'^','Color',yellow);
loglog(x_kernelRK(2),y_KernelRK(2),'*','Color',blue);
loglog(x_kernelRK(1),y_KernelRK(1),'*','Color',orange);
loglog(x_kernelCODE(1),y_KernelCODE(1),'p','Color',purple);
loglog(x_FL_10,y_FL_10,'-r'); 
loglog(x_FL_25,y_FL_25,'-r');
loglog(x_FL_50,y_FL_50,'-r');
loglog(x_FL_Nominal,y_FL_Nominal,'-k');
%loglog(x_FL_100_DRAM,y_FL_100_DRAM,'--b');
loglog(x_FL_100_L1,y_FL_100_L1,'--k','Linewidth',1); hold off
axis([1/16,196,8,2050]);
legend({...
    'WENO5$_Z$ {\boldmath $f$}$_x$',...
    'WENO5$_Z$ {\boldmath $g$}$_y$',...
    'WENO5$_Z$ {\boldmath $h$}$_z$',...
    'WENO5$_Z^{b}$ {\boldmath $f$}$_x$',...
    'WENO5$_Z^{b}$ {\boldmath $g$}$_y$',...
    'WENO5$_Z^{b}$ {\boldmath $h$}$_z$',...
    'WENO5$_Z^{sh}$ {\boldmath $f$}$_x$',...
    'WENO5$_Z^{sh}$ {\boldmath $g$}$_y$',...
    'WENO5$_Z^{sh}$ {\boldmath $h$}$_z$',...
    'Laplacian {\boldmath $\nabla$}$^2$',...
    'Laplacian$^{b}$ {\boldmath $\nabla$}$^2$',...
    'Laplacian$^{sh}$ {\boldmath $\nabla$}$^2$',...
    'RK stage (avg.)'...
    'RK$^{b}$ stage (avg.)'...
    '$\mathcal{L}$({\boldmath $q$}) (\textit{sh}--\textit{b})'...
    },'Location','Eastoutside','Interpreter','Latex');
legend boxoff
ylabel('(double precision) GFLOP/s','Interpreter','Latex'); 
xlabel('Operational Intensity (FLOPs/Byte)','Interpreter','Latex');
set(gca, 'TickLabelInterpreter','Latex');
set(gca, 'XTick', [0.125,0.25,0.5,1,2,4,8,64,1024]);
set(gca, 'XTickLabel',{'$\frac{1}{8}$','$\frac{1}{4}$','$\frac{1}{2}$','1','2','4','8','64','1024'}); 
set(gca, 'YTick', [32,64,128,256,512,1024,2048]);
grid on; grid minor; grid minor;
axis square;

% Create textbox 50%
annotation(fig,'textbox',...
    [0.56 0.70 0.06 0.06],...
    'String',{'50%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 25%
annotation(fig,'textbox',...
    [0.56 0.62 0.06 0.06],...
    'String',{'25%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 10%
annotation(fig,'textbox',...
    [0.56 0.50 0.06 0.06],...
    'String',{'10%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Nominal GFLOPs
text('FontSize',14,'Interpreter','tex',...
    'String','1455 GFLOP/s',...
    'Position',[10 1650.0 0]);

% GFLOPs max 
% text('FontSize',14,'Interpreter','tex',...
%     'String','1236.9 GFLOP/s',...
%     'Position',[3.8 1400.0 0]);

% Nominal Bandwidth 
text('FontSize',14,'Rotation',56,'Interpreter','tex',...
    'String','240 GB/s',...
    'Position',[0.6 200 0]);

% L1 Bandwidth
% text('FontSize',14,'Rotation',52,'Interpreter','tex',...
%     'String','L1 (563.2 GB/s)',...
%     'Position',[0.25 200.45 0]);

% DRAM Bandwidth
text('FontSize',14,'Rotation',56,'Interpreter','tex',...
    'String','DRAM (133.8 GB/s)',...
    'Position',[0.09 16 0]);

% Print Figure
print('-depsc',[pwd,'/Roofline.eps']); 
