% Plot Execution time distribution for the Kernels on the K80

% Execution Time
t_WENO5_x=1; % [s]
t_WENO5_y=3; % [s]
t_WENO5_z=0.5; % [s]
t_laplace=2.5; % [s]
t_RK=2; % [s]

X = [t_WENO5_x,t_WENO5_y,t_WENO5_z,t_laplace,t_RK];
p = pie(X);

% Extract the Percentage values
hText = findobj(p,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values

% get rid of % symbol
for i=1:5; prcent=percentValues{i}; percentValues{i}=prcent(1:end-1); end

% Combine Labels with their percentage values
labels = {'WENO5 $i_x$: ';'WENO5 $i_y$: ';'WENO5 $i_z$: ';'Laplace: ';'RK stage: '};
combinedtxt = strcat(labels,percentValues,'$\%$'); % strings and percent values

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

for i = 2:2:10
p(i).FontSize = 16;
p(i).Interpreter = 'Latex';
end