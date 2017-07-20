% Plot Roofline and Measurements
clear; clc; close all;
 
%% Color Panteon
%     R     G     B      hex       name
%    ========================================
%      0   114   190    0072BE     blue
%    218    83    25    DA5319     red/orange
%    238   178    32    EEB220     yellow
%    126    47   142    7E2F8E     purple
%    119   173    48    77AD30     green
%     77   191   239    4DBFEF     light blue
%    163    20    47    A3142F     dark red
%    192   192   192    C0C0C0     silver

%% Plot the Roofline data

% setup plotting stile for figures
set(0,'defaultTextInterpreter','latex')
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',20,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',20,...
'DefaultLineLineWidth',1.5,...
'DefaultAxesBox','on',...
'defaultAxesLineWidth',1.0,...
'DefaultFigureColor','w',...
'DefaultLineMarkerSize',8.0)

GFLOPsmax = 1236.88; % x10^9 FLOP/s

x_FL_100_DRAM=[0.01,2,1E4];
y_FL_100_DRAM=[5.5,GFLOPsmax,GFLOPsmax];

x_FL_100_L1=[0.01,9,1E4];
y_FL_100_L1=[1.5,GFLOPsmax,GFLOPsmax];

x_FL_50=[1.0,1E4];
y_FL_50=[GFLOPsmax/2,GFLOPsmax/2];

x_FL_25=[0.51,1E4];
y_FL_25=[GFLOPsmax/4,GFLOPsmax/4];

x_FL_10=[0.21,1E4];
y_FL_10=[GFLOPsmax/10,GFLOPsmax/10];

GFlop = 1E9;
GByte = 1E6;
ms = 1E-3; % [1ms = 1/1000s]

% Kernels Measurements

% WENO5_x Operator
% [Newest Measurement, base/initial measurement]
T = [3.4,   325.149]*ms;
Qw= [117,   24.915];
Qr= [25,    65.502];
W = [6.5e8, 175e8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel1=I;
y_Kernel1=P;

% WENO5_y Operator
% [Newest Measurement, base/initial measurement]
T = [3.0,   156.867]*ms;
Qw= [121,   8.548];
Qr= [24,    8.942];
W = [6.5e8, 175e8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel2=I;
y_Kernel2=P;

% WENO5_z Operator
% [Newest Measurement, base/initial measurement]
T = [3.2,   164.282]*ms;
Qw= [115,   7.934];
Qr= [25,    8.190];
W = [6.5E8, 170e8];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel3=I;
y_Kernel3=P;

% WENO7_x Operator
% [Newest Measurement, base/initial measurement]
T = [7.5]*ms;
Qw= [115];
Qr= [35];
W = [1.1E9];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel4=I;
y_Kernel4=P;

% WENO7_y Operator
% [Newest Measurement, base/initial measurement]
T = [7.1]*ms;
Qw= [115];
Qr= [35];
W = [1.1E9];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel5=I;
y_Kernel5=P;

% WENO7_z Operator
% [Newest Measurement, base/initial measurement]
T = [7.0]*ms;
Qw= [115];
Qr= [35];
W = [1.1E9];

P = (W./T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W./Q;

x_kernel6=I;
y_Kernel6=P;

% Laplace Operator
T = [414,   2.45]*ms*ms;
Qw= [48,    65.174];
Qr= [85,    88.859];
W = [4.7E7, 1.1E8];

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel7=I;
y_Kernel7=P;

% Runge Kutta
T = [139,   3.974]*ms*ms;
Qw= [37,    37];
Qr= [120,   120];
W = [3.6E6, 1.5E8];

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel8=I;
y_Kernel8=P;

% Plot Figure
fig=figure; fig.PaperUnits = 'inches'; fig.PaperPosition = [0 0 8 6];
loglog(x_kernel1,y_Kernel1,'o'); hold on
loglog(x_kernel2,y_Kernel2,'s');
loglog(x_kernel3,y_Kernel3,'d');
loglog(x_kernel4,y_Kernel4,'o');%,'MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel5,y_Kernel5,'s');%,'MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel6,y_Kernel6,'d');%,'MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel7,y_Kernel7,'^');
loglog(x_kernel8,y_Kernel8,'*');
loglog(x_FL_10,y_FL_10,'-r'); 
loglog(x_FL_25,y_FL_25,'-r');
loglog(x_FL_50,y_FL_50,'-r');
loglog(x_FL_100_DRAM,y_FL_100_DRAM,'-k'); 
loglog(x_FL_100_L1,y_FL_100_L1,'--k','Linewidth',1); hold off
axis([0.15,32,30,2050]);
legend({'WENO5 $\mathbf{\mathit{f}}_x$','WENO5 $\mathbf{\mathit{g}}_y$','WENO5 $\mathbf{\mathit{h}}_z$','WENO7 $\mathbf{\mathit{f}}_x$','WENO7 $\mathbf{\mathit{g}}_y$','WENO7 $\mathbf{\mathit{h}}_z$','Laplacian $\mathbf{\nabla}^2$','RK step (avg.)'},'Location','Eastoutside','Interpreter','Latex');
legend boxoff
ylabel('(double precision) GFLOP/s','Interpreter','Latex'); 
xlabel('Operational Intensity (FLOPs/Byte)','Interpreter','Latex');
set(gca, 'TickLabelInterpreter','Latex');
set(gca, 'XTick', [0.25,0.5,1,2,4,8,64,1024]);
set(gca, 'XTickLabel',{'$\frac{1}{4}$','$\frac{1}{2}$','1','2','4','8','64','1024'}); 
set(gca, 'YTick', [32,64,128,256,512,1024,2048]);
grid on; grid minor; grid minor;
axis square;

% Create textbox 50%
annotation(fig,'textbox',...
    [0.56 0.63 0.05 0.06],...
    'String',{'50%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 25%
annotation(fig,'textbox',...
    [0.56 0.525 0.05 0.06],...
    'String',{'25%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 10%
annotation(fig,'textbox',...
    [0.56 0.375 0.05 0.06],...
    'String',{'10%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create text
text('FontSize',14,'Interpreter','tex',...
    'String','1236.9 GFLOP/s',...
    'Position',[3.8 1400.0 0]);

% Create text
text('FontSize',14,'Rotation',52,'Interpreter','tex',...
    'String','L1 (563.2 GB/s)',...
    'Position',[0.25 200.45 0]);

% Create text
text('FontSize',14,'Rotation',52,'Interpreter','tex',...
    'String','DRAM (133.8 GB/s)',...
    'Position',[0.95 172.15 0]);

% Print Figure
print('-depsc',[pwd,'/Roofline.eps']); 
