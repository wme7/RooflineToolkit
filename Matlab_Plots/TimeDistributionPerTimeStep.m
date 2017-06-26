% Plot Execution time distribution for the Kernels on the K80

% Execution Time
t_H2D=1; % [s]
t_GPU=3; % [s]
t_D2H=1.5; % [s]
t_DT=2.5; % [s]

X = [t_H2D,t_GPU,t_D2H,t_DT];
p = pie(X);

% Extract the Percentage values
hText = findobj(p,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values

% get rid of % symbol
for i=1:4; prcent=percentValues{i}; percentValues{i}=prcent(1:end-1); end

% Combine Labels with their percentage values
labels = {'H2D: ';'GPU: ';'D2H: ';'DT: '};
combinedtxt = strcat(labels,percentValues,'$\%$'); % strings and percent values

% store extend values
oldExtents_cell = get(hText,'Extent'); % cell array

hText(1).String = combinedtxt(1);
hText(2).String = combinedtxt(2);
hText(3).String = combinedtxt(3);
hText(4).String = combinedtxt(4);

for i = 1:2:8
p(i).EdgeColor = 'none';
end

for i = 2:2:8
p(i).FontSize = 16;
p(i).Interpreter = 'Latex';
end