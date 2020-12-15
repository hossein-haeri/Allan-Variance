clear all
clc
close all

% create a white noise signal
x = rand(1000,1);

% create a list of window lengths
tau = (1:100);

% calculate the AVAR 
avar_1 = AVAR(x, tau); % using the AVAR function
avar_2 = allanvar(x, tau); % using MATLAB's build-in function

hold on
plot(tau, avar_1, 'DisplayName', 'AVAR')
plot(tau, avar_2, 'DisplayName', 'MATLAB  allanvar')
legend
grid on
xlabel('Window length (m)')
ylabel('AVAR')