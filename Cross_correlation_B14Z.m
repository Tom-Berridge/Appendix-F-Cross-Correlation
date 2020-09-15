%A script that uses cross correlation to calculate the depth shift to
%align the well log AI with the predicted AI at blind well 20/06a-B14Z

clc; % Clear Command Window
close all; %Close all figures
clear; %Erase all existing variables

%Author: T. Berridge
%Date: 20/08/2020

load('20_06a_B14Z\B14Z_actual.txt')
load('20_06a_B14Z\B14Z_standard.txt')
load('20_06a_B14Z\B14Z_detailed.txt')

B14Z_actual(:,2)=B14Z_actual(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3
B14Z_standard(:,2)=B14Z_standard(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3
B14Z_detailed(:,2)=B14Z_detailed(:,2)*0.0003048; %convert from ft.g/s.cm3 to km.g/s.cm3

xx_B14Z_actual=(min(B14Z_actual(:,1)):1:max(B14Z_actual(:,1)))'; %interpolate so it is sampled every ft
yy_B14Z_actual=spline(B14Z_actual(:,1),B14Z_actual(:,2),xx_B14Z_actual);
B14Z_actual_interp=[xx_B14Z_actual yy_B14Z_actual];

xx_B14Z_detailed=(min(B14Z_detailed(:,1)):1:max(B14Z_detailed(:,1)))';
yy_B14Z_detailed=spline(B14Z_detailed(:,1),B14Z_detailed(:,2),xx_B14Z_detailed);
B14Z_detailed_interp=[xx_B14Z_detailed yy_B14Z_detailed];

xx_B14Z_standard=(min(B14Z_standard(:,1)):1:max(B14Z_standard(:,1)))';
yy_B14Z_standard=spline(B14Z_standard(:,1),B14Z_standard(:,2),xx_B14Z_standard);
B14Z_standard_interp=[xx_B14Z_standard yy_B14Z_standard];


actual = B14Z_actual_interp(:,2) -mean(B14Z_actual(:,2)); %so it oscilates around 0
detailed = B14Z_detailed_interp(:,2) -mean(B14Z_actual(:,2)); %so it oscilates around 0
standard = B14Z_standard_interp(:,2) -mean(B14Z_actual(:,2)); %so it oscilates around 0

figure;
[c,lags] = xcorr(actual,detailed);
stem(lags,c)
xlim([55 85])
xlabel('Lag (ft)')
ylabel('Correlation Measure')

%%
figure;
[c,lags] = xcorr(actual,standard);
stem(lags,c)
xlim([60 80])
xlabel('Lag (ft)')
ylabel('Correlation Measure')
%%
figure;
hold on
plot(B14Z_actual_interp(:,2),B14Z_actual_interp(:,1), 'r')
plot(B14Z_detailed_interp(:,2),(B14Z_detailed_interp(:,1)), 'b')
plot(B14Z_standard_interp(:,2),(B14Z_standard_interp(:,1)), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard', 'Mean AI (well data)')

figure;
hold on
plot(B14Z_actual_interp(:,2),B14Z_actual_interp(:,1), 'r')
plot(B14Z_detailed_interp(:,2),(B14Z_detailed_interp(:,1) +72), 'b')
plot(B14Z_standard_interp(:,2),(B14Z_standard_interp(:,1) +72), 'g')
%plot([7.7357 7.7357], [min(B6_actual_interp(:,1)) max(B6_actual_interp(:,1))], 'k', 'Linewidth', 2)
ax = gca;
ax.YDir = 'reverse';
ylabel('Depth (MD, ft)')
xlabel('AI [(km.g)/(s.cm3)]')
legend('Well data', 'Inverted AI detailed', 'Inverted AI standard', 'Mean AI (well data)')

