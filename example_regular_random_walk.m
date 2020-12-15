clear all
clc
close all

% set random seeds
rng(123)

% create a random walk signal
x = zeros(1000, 1);
for i= 2:1000
    x(i) = x(i-1) + normrnd(0, 0.1);
end

% create a Gaussian white noise
v = normrnd(0,1,[1000,1]);

% combine RW and noise signals
y = x + v;

% create a list of window lengths
tau = (1:200);

% calculate the AVAR 
avar = AVAR(y, tau);


subplot(2,1,1)
hold on
plot(y, 'DisplayName', 'RW Measurements')
plot(x, 'DisplayName', 'RW Signal')
legend
grid on
xlabel('Window length (m)')
ylabel('AVAR')

subplot(2,1,2)
loglog(tau, avar)
grid on
xlabel('Window length (m)')
ylabel('AVAR')


