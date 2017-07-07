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
'DefaultLineMarkerSize',7.0)

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
T = 325.149*ms;
Qw = 24.915;
Qr = 65.502;
W = 174532500000;

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel1=I;
y_Kernel1=P;

% WENO5_y Operator
T = 156.867*ms;
Qw = 8.548;
Qr = 8.942;
W = 17514690000;

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel2=I;
y_Kernel2=P;

% WENO5_z Operator
T = 164.282*ms;
Qw = 7.934;
Qr = 8.190;
W = 17042250000;

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel3=I;
y_Kernel3=P;

x_kernel4=1024;
y_Kernel4=64;

x_kernel5=1024;
y_Kernel5=64;

x_kernel6=1024;
y_Kernel6=64;

% Laplace Operator
T = 2.448*ms;
Qw = 65.174;
Qr = 88.859;
W = 111125000;

P = (W/T)/GFlop;
Q = (Qw+Qr)*GByte;
I = W/Q;

x_kernel7=I;
y_Kernel7=P;

% Laplace Operator
T = 3.974*ms;
Qw = 40.712;
Qr = 123.369;
W = 149815296;

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
loglog(x_kernel4,y_Kernel4,'o','MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel5,y_Kernel5,'s','MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel6,y_Kernel6,'d','MarkerFaceColor',[0.5 0.5 0.5]);
loglog(x_kernel7,y_Kernel7,'^');
loglog(x_kernel8,y_Kernel8,'*');
loglog(x_FL_10,y_FL_10,'-r'); 
loglog(x_FL_25,y_FL_25,'-r');
loglog(x_FL_50,y_FL_50,'-r');
loglog(x_FL_100_DRAM,y_FL_100_DRAM,'-k'); 
loglog(x_FL_100_L1,y_FL_100_L1,'--k','Linewidth',1); hold off
axis([0.15,1E4,30,2050]);
legend({'WENO5 $i_x$','WENO5 $i_y$','WENO5 $i_z$','WENO7 $i_x$','WENO7 $i_y$','WENO7 $i_z$','Laplace','RK step'},'Location','Eastoutside','Interpreter','Latex');
legend boxoff
ylabel('GFLOP/s','Interpreter','Latex'); 
xlabel('FLOPs/Byte','Interpreter','Latex');
set(gca, 'TickLabelInterpreter','Latex');
set(gca, 'XTick', [0.25,0.5,1,2,4,8,64,1024]);
set(gca, 'XTickLabel',{'$\frac{1}{4}$','$\frac{1}{2}$','1','2','4','8','64','1024'}); 
set(gca, 'YTick', [32,64,128,256,512,1024,2048]);
grid on; %grid minor;
axis square;

% Create textbox 50%
annotation(fig,'textbox',...
    [0.62 0.65 0.05 0.06],...
    'String',{'50%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 25%
annotation(fig,'textbox',...
    [0.62 0.525 0.05 0.06],...
    'String',{'25%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox 10%
annotation(fig,'textbox',...
    [0.62 0.37 0.05 0.06],...
    'String',{'10%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Print Figure
print('-depsc',[pwd,'/Roofline.eps']); 
