%A script that uses cross correlation to calculate the depth shift to
%align the well log AI with the predicted AI at blind well 20/06a-B14Z

clc; % Clear Command Window
close all; %Close all figures
clear; %Erase all existing variables

%Author: T. Berridge
%Date: 20/08/2020

load('20_06a_B6\B6_actual.txt')
load('20_06a_B6\B6_standard.txt')
load('20_06a_B6\B6_detailed.txt')

B6_actual(:,2)=B6_actual(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3
B6_standard(:,2)=B6_standard(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3
B6_detailed(:,2)=B6_detailed(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3

xx_B6_actual=(min(B6_actual(:,1)):1:max(B6_actual(:,1)))'; %interpolate so it is sampled every ft
yy_B6_actual=spline(B6_actual(:,1),B6_actual(:,2),xx_B6_actual);
B6_actual_interp=[xx_B6_actual yy_B6_actual];

xx_B6_detailed=(min(B6_detailed(:,1)):1:max(B6_detailed(:,1)))';
yy_B6_detailed=spline(B6_detailed(:,1),B6_detailed(:,2),xx_B6_detailed);
B6_detailed_interp=[xx_B6_detailed yy_B6_detailed];

xx_B6_standard=(min(B6_standard(:,1)):1:max(B6_standard(:,1)))';
yy_B6_standard=spline(B6_standard(:,1),B6_standard(:,2),xx_B6_standard);
B6_standard_interp=[xx_B6_standard yy_B6_standard];


actual = B6_actual_interp(:,2) -mean(B6_actual(:,2)); %so it oscilates around 0
detailed = B6_detailed_interp(:,2) -mean(B6_actual(:,2)); %so it oscilates around 0
standard = B6_standard_interp(:,2) -mean(B6_actual(:,2)); %so it oscilates around 0

figure;
[c,lags] = xcorr(actual,detailed);
stem(lags,c)
xlim([-30 0])
xlabel('Lag (ft)')
ylabel('Correlation Measure')


%%
figure;
[c,lags] = xcorr(actual,standard);
stem(lags,c)
xlim([-30 0])
xlabel('Lag (ft)')
ylabel('Correlation Measure')
%%
figure;
hold on
plot(B6_actual_interp(:,2),B6_actual_interp(:,1), 'r')
plot(B6_detailed_interp(:,2),(B6_detailed_interp(:,1)), 'b')
plot(B6_standard_interp(:,2),(B6_standard_interp(:,1)), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard')%, 'Mean AI (well data)')
%%
figure;
hold on
plot(B6_actual_interp(:,2),B6_actual_interp(:,1), 'r')
plot(B6_detailed_interp(:,2),(B6_detailed_interp(:,1) -19), 'b')
plot(B6_standard_interp(:,2),(B6_standard_interp(:,1) -6), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard')%, 'Mean AI (well data)')

figure;
hold on
plot(B6_actual_interp(:,2),B6_actual_interp(:,1), 'r')
plot(B6_detailed_interp(:,2),(B6_detailed_interp(:,1) -19), 'b')
plot(B6_standard_interp(:,2),(B6_standard_interp(:,1) -19), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard')%, 'Mean AI (well data)')

figure;
hold on
plot(B6_actual_interp(:,2),B6_actual_interp(:,1), 'r')
plot(B6_detailed_interp(:,2),(B6_detailed_interp(:,1) -13), 'b')
plot(B6_standard_interp(:,2),(B6_standard_interp(:,1) -13), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard')%, 'Mean AI (well data)')

