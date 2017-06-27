% Plot Roofline and Measurements
clear; clc; close all;

%% Some usefull reference
% Markus Deserno 'Linear and Logarithmic Interpolation', Note, March 2004.
%
% 1. Linear Inteporlation
%
% x2 - x    b
% ------ = --- =  1/f - 1 
% x - x1    a
%
% where the fractional division 'f 'is 
%
%  f := a / (a+b)
%
% so that 
%
% x = f*x2 + (1-f)*x1     (lin)
%
% .2 Logarithmic Inteporlation
%
% log(x2) - log(x)    b
% ---------------- = --- =  1/f - 1 
% log(x) - log(x1)    a
%192,192,192
% solving for x, we find the logarithmic interpolation formula
%
% x = x2^{f} + x1^{(1-f)}    (log)
 
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

x_FL_100_DRAM=[0.01,2,100];
y_FL_100_DRAM=[5.5,GFLOPsmax,GFLOPsmax];

x_FL_100_L1=[0.01,9,100];
y_FL_100_L1=[1.5,GFLOPsmax,GFLOPsmax];

x_FL_50=[4.5,100];
y_FL_50=[GFLOPsmax/2,GFLOPsmax/2];

x_FL_25=[2.2,100];
y_FL_25=[GFLOPsmax/4,GFLOPsmax/4];

x_FL_10=[0.87,100];
y_FL_10=[GFLOPsmax/10,GFLOPsmax/10];

% Kernels Measurements
x_kernel1=1;
y_Kernel1=100;

x_kernel2=2;
y_Kernel2=200;

x_kernel3=3;
y_Kernel3=300;

x_kernel4=1.5;
y_Kernel4=150;

x_kernel5=2.5;
y_Kernel5=250;

x_kernel6=3.5;
y_Kernel6=350;

x_kernel7=4;
y_Kernel7=400;

x_kernel8=5;
y_Kernel8=500;

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
loglog(x_FL_100_DRAM,y_FL_100_DRAM,'--k','Linewidth',1); 
loglog(x_FL_100_L1,y_FL_100_L1,'-k'); hold off
axis([0.1,100,10,2000]);
legend({'WENO5 $i_x$','WENO5 $i_y$','WENO5 $i_z$','WENO7 $i_x$','WENO7 $i_y$','WENO7 $i_z$','Laplace','RK step'},'Location','Eastoutside','Interpreter','Latex');
legend boxoff
ylabel('GFLOP/s','Interpreter','Latex'); 
xlabel('FLOPs/Byte','Interpreter','Latex');
set(gca, 'XTick', [0.1,1,10,100]);
grid on; grid minor;
axis square;

% Create textbox
annotation(fig,'textbox',...
    [0.57 0.47 0.05 0.06],...
    'String',{'10%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox
annotation(fig,'textbox',...
    [0.57 0.59 0.05 0.06],...
    'String',{'25%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox
annotation(fig,'textbox',...
    [0.57 0.68 0.05 0.06],...
    'String',{'50%'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Print Figure
print('-depsc',[pwd,'/Roofline.eps']); 
