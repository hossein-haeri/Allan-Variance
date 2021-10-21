clear all
clc
close all

% set random seeds
% rng(123)

% create a random walk + white noise signal
x = zeros(1000, 1);
for i= 2:1000
    x(i) = x(i-1) + normrnd(0, 0.1);
end

% create a Gaussian white noise
v = normrnd(0,1,[1000,1]);

% combine RW and noise signals
y = x + v;

% calculate the AVAR 
[avar, tau] = allanvar(y);

subplot(3,1,1)
hold on
plot(y, 'DisplayName', 'RW Measurements')
% plot(x, 'DisplayName', 'RW Signal')
legend
grid on
xlabel('Time (k)')
ylabel('X')

subplot(3,1,2)
loglog(tau, avar)
grid on
xlabel('Window length (m)')
ylabel('AVAR')


subplot(3,1,3)
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|X|')
grid on
