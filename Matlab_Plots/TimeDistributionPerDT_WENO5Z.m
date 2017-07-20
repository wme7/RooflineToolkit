% Plot Execution time distribution for the Kernels on the K80
clear; clc; close all;

% setup plotting stile for figures
set(0,'defaultTextInterpreter','latex')
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',28,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',28,...
'DefaultLineLineWidth',1.5,...
'DefaultAxesBox','on',...
'defaultAxesLineWidth',1.0,...
'DefaultFigureColor','w',...
'DefaultLineMarkerSize',7.0)

% Execution Time
t_WENO5_x= 9.945+9.905; % [ms]
t_WENO5_y= 9.757+8.811; % [ms]
t_WENO5_z=10.408+9.398; % [ms]
t_laplace= 5.012; % [ms]
t_RK=4.785; % [ms]

t = [t_WENO5_x,t_WENO5_y,t_WENO5_z,t_laplace,t_RK];
p = pie(t,[0,0,0,1,1]);

percentageValues = {...
    num2str(t(1)./sum(t)*100,'%1.1f');...
    num2str(t(2)./sum(t)*100,'%1.1f');...
    num2str(t(3)./sum(t)*100,'%1.1f');...
    num2str(t(4)./sum(t)*100,'%1.1f');...
    num2str(t(5)./sum(t)*100,'%1.1f')};

% Extract the Percentage values
hText = findobj(p,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values

% get rid of % symbol
for i=1:5; prcent=percentValues{i}; percentValues{i}=prcent(1:end-1); end

% Combine Labels with their percentage values
labels = {'$\textbf{\textit{f}}_x$';'$\textbf{\textit{g}}_y$';'$\textbf{\textit{h}}_z$';'$\mathbf{\nabla}^2\textbf{\textit{q}}:$';'$RK_{stages}:$'};
%combinedtxt = strcat(labels,percentageValues,'$\%$'); % strings and percent values
combinedtxt = strcat(labels); % strings

% store extend values
oldExtents_cell = get(hText,'Extent'); % cell array

hText(1).String = combinedtxt(1);
hText(2).String = combinedtxt(2);
hText(3).String = combinedtxt(3);
hText(4).String = combinedtxt(4);
hText(5).String = combinedtxt(5);

for i = 1:2:10
p(i).EdgeColor = 'none';
end

hold on 
p = pie(t,[0,0,0,1,1]);

% Extract the Percentage values
hText = findobj(p,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values

combinedtxt = strcat(percentageValues,'$\%$'); % strings and percent values

hText(1).String = combinedtxt(1);
hText(2).String = combinedtxt(2);
hText(3).String = combinedtxt(3);
hText(4).String = combinedtxt(4);
hText(5).String = combinedtxt(5);

for i = 1:2:10
p(i).EdgeColor = 'none';
end

for i = 2:2:10
p(i).FontSize = 24;
p(i).Interpreter = 'Latex';
end

colormap hot
% stop figure and reconfigure labels in editor mode!

%% Print Figure
print('-depsc',[pwd,'/TimeDistributionPerIteration_WENO5Z.eps']); 