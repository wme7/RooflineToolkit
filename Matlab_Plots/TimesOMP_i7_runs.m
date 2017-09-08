% Iterations
% T = [XS , S , M , L , XL]; 
iter= [300,101, 10, 5 , 3 ];

% -------------------------------%
% CPU time of OMP implementation %
% -------------------------------%
T_1CPU_XS= 8.934518*2;  % [32x32x32]x2 = [32x32x64]
T_1CPU_S_=32.528230*2;  % [64x64x64]x2 = [64x64x128] ...
T_1CPU_M_=14.994900*2;  % [128x128x128]x2 
T_1CPU_L_=88.916767*2;  % [256x256x256]x2 
T_1CPU_XL=563.997267*2; % [512x512x512]x2 
T_1CPU_OMP = [T_1CPU_XS,T_1CPU_S_,T_1CPU_M_,T_1CPU_L_,T_1CPU_XL]./iter;
fprintf('Time per iteration (1 OMP threads):\n');
disp(T_1CPU_OMP');

T_8CPU_XS= 1.598332*2;
T_8CPU_S_= 5.198362*2;
T_8CPU_M_= 4.683131*2;
T_8CPU_L_= 23.051087*2;
T_8CPU_XL= 124.945279*2;
T_8CPU_OMP = [T_8CPU_XS,T_8CPU_S_,T_8CPU_M_,T_8CPU_L_,T_8CPU_XL]./iter;
fprintf('Time per iteration (8 OMP threads):\n');
disp(T_8CPU_OMP');