 % Plot Roofline and Measurements
clear; clc; close all;
 
%% Color Panteon
% name     R          G           B       
% ======================================
blue  =  [     0     0.4470    0.7410];
orange = [0.8500     0.3250    0.0980];
yellow = [0.9290     0.6940    0.1250];
purple = [0.4940     0.1840    0.5560];
green =  [0.4660     0.6740    0.1880];
cyan  =  [0.3010     0.7450    0.9330];
red   =  [0.6350     0.0780    0.1840];
lgray =  [192/256,  192/256,  192/256];

%% Plot the Roofline data

% setup plotting stile for figures
set(0,'defaultTextInterpreter','latex')
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',20,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',14,...
'DefaultLineLineWidth',0.5,...
'DefaultAxesBox','on',...
'defaultAxesLineWidth',0.5,...
'DefaultFigureColor','w',...
'DefaultLineMarkerSize',3.0)

% Constants
GFLOP = 1/1E9; % FLOPs

% Iterations
% T = [XS , S , M , L , XL]; 
iter= [300,101, 10, 3 , 1 ];

% -------------------------------%
% CPU time of OMP implementation %
% -------------------------------%
T_XS=1.598;
T_S_=5.198;
T_M_=4.683;
T_L_=23.05;
T_XL=76.92;
T_OMP = [T_XS,T_S_,T_M_,T_L_,T_XL]./iter;
T_OMP = [T_OMP;T_OMP;T_OMP;T_OMP]';

% ---------------------------%
% FLOPS per single iteration %
% ---------------------------%
FLOPs_XS = 3*(23767484 + 21168128 + 171859968 + 25290668 + 4*1131624 + 1685077);
FLOPs_S_ = 3*(241989340 + 171859968 + 165470208 + 248785084 + 4*11444328 + 15724800);
FLOPs_M_ = 3*(2165428508 + 1384939520 + 1333428224 + 2194017500 + 4*102074472 +  135390805);
FLOPs_L_ = 3*(1.8287E10 + 1.11207E10 + 1.0706E10 + 1.8404E10 + 4*860625000 + 1122750720);
FLOPs_XL = 3*(3.7250E10 + 2.2280E10 + 2.1451E10 + 2.1451E10 + 4*1755894888 + 2272339541)*4;
FLOPs = [FLOPs_XS,FLOPs_S_,FLOPs_M_,FLOPs_L_,FLOPs_XL];

% ----------------------%
% Benchmarks Test Cases %
% ----------------------%
% Time per iteration
T_1GPU = [1.304617,1.579873,1.348921,3.476893, inf ]./iter*0.85;
T_2GPU = [0.972122,0.593772,0.389932,1.074410, inf ]./iter;
T_4GPU = [1.151733,0.552446,0.284670,0.623828,1.311819]./iter;
T_8GPU = [1.108511,0.620046,0.197519,0.398020,0.772124]./iter;
T = [T_1GPU;T_2GPU;T_4GPU;T_8GPU]';
fprintf('Time per iteration:\n');
disp(T);

% ------------------------------%
% Speed up wrt to i7-OMP solver %
% ------------------------------%
SpeedUp = T_OMP./T;
fprintf('Speed Up:\n');
disp(SpeedUp);

% ----------------------%
%     Compute FLOP/s    %
% ----------------------%

NAS_1GPU = FLOPs*GFLOP./T_1GPU;
NAS_2GPU = FLOPs*GFLOP./T_2GPU;
NAS_4GPU = FLOPs*GFLOP./T_4GPU;
NAS_8GPU = FLOPs*GFLOP./T_8GPU;
NAS = [NAS_1GPU;NAS_2GPU;NAS_4GPU;NAS_8GPU]';

% --------------------%
%      Plot Figure    %
% --------------------%
hbar=bar(NAS,'edgecolor','none');
hbar(1).FaceColor = blue;
hbar(2).FaceColor = orange;
hbar(3).FaceColor = lgray;
hbar(4).FaceColor = yellow;
h=gca; h.YGrid='on';box off;
ylabel('GFLOP/s','Interpreter','Latex'); 
set(gca, 'TickLabelInterpreter','Latex');
set(gca, 'XTick', 1:5);
set(gca, 'XTickLabel',{'XS','S','M','L','XL'}); 
set(gca, 'YTick', [200,400,600,800,1000,1200,1400,1600,1800]);
hl=legend({'1x GPU','2x GPU','4x GPU','8x GPU'},...
    'Location','southoutside',...
    'Orientation','horizontal',...
    'Interpreter','latex',...
    'Fontsize',12); 
legend boxoff;
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];
print('-depsc',[pwd,'/GFLOPsMultiGPU.eps']); 