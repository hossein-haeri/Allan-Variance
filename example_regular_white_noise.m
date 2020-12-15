clear all
clc
close all

% create a white noise signal
x = rand(1000,1);

% create a list of window lengths
tau = (1:100);

% calculate the AVAR 
avar = AVAR(x, tau);


loglog(tau, avar)
grid on
xlabel('Window length (m)')
ylabel('AVAR')