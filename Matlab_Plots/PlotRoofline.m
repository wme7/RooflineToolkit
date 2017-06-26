% Plot Roofline and Measurements
clear; clc; close all;

x_FL_100=[1E2,1E3,1E6];
y_FL_100=[1E3,1E5,1E5];

x_FL_50=[1E2,1E3,1E6];
y_FL_50=[1E3,1E5/2,1E5/2];

x_FL_25=[1E2,1E3,1E6];
y_FL_25=[1E3,1E5/4,1E5/4];

x_FL_10=[1E2,1E3,1E6];
y_FL_10=[1E3,1E5/10,1E5/10];

x_data=[1E3];
y_data=[1E4];

loglog(x_FL_100,y_FL_100,'-'); hold on
loglog(x_FL_50,y_FL_50,'-');
loglog(x_FL_25,y_FL_25,'-');
loglog(x_FL_10,y_FL_10,'-');
loglog(x_data,y_data,'o'); hold off
axis([1E2,1E6,1E3,2E5]);
grid on;