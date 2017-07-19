% Plot Execution time distribution for the Kernels on the K80
clear; clc; close all;

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

% Execution Time
t_WENO7_x=22.235+21.175; % [ms]
t_WENO7_y=19.099+18.385; % [ms]
t_WENO7_z=19.347+18.543; % [ms]
t_laplace= 5.012; % [ms]
t_RK=5.629; % [ms]

t = [t_WENO7_x,t_WENO7_y,t_WENO7_z,t_laplace,t_RK];
p = pie(t);

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
labels = {'$\partial_x\mathbf{F}$';'$\partial_y\mathbf{G}$';'$\partial_z\mathbf{H}$';'$\nabla^2\mathbf{q}$';'$RK_{stages}$'};
%combinedtxt = strcat(labels,percentageValues,'$\%$'); % strings and percent values
combinedtxt = strcat(labels); % strings

% store extend values
oldExtents_cell = get(hText,'Extent'); % cell array
oldExtents = cell2mat(oldExtents_cell);

hText(1).String = combinedtxt(1);
hText(2).String = combinedtxt(2);
hText(3).String = combinedtxt(3);
hText(4).String = combinedtxt(4);
hText(5).String = combinedtxt(5);

for i = 1:2:10
p(i).EdgeColor = 'none';
end

hold on 
p = pie(t);

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
p(i).FontSize = 16;
p(i).Interpreter = 'Latex';
end

colormap autumn
% stop figue and reconfigure labels!

%% Print Figure
print('-depsc',[pwd,'/TimeDistributionPerIteration_WENO7Z.eps']); 