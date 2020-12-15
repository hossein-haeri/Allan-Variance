clear all
clc
close all

% set random seeds
rng(111)

% create a random walk signal
x = zeros(10000, 1);
for i= 2:10000
    x(i) = x(i-1) + normrnd(0, 0.1);
end

% randomly (and uniformly) sample 1000 timestamps from [0, 1] and sort them
t = sort(rand(1000,1));

x_ = zeros(1000, 1);
for i= 1:1000
    index = round(10000*t(i));
    x_(i) = x(index);
end


% create a Gaussian white noise
v = normrnd(0,5,[1000,1]);

% combine RW and noise signals
y = x_ + v;

% create a list of window lengths
tau = linspace(0.01,0.2,100);

% calculate the AVAR 
avar = AVAR2(t, y, tau);


subplot(3,1,1)
hold on
plot(y, 'DisplayName', 'Irregular RW measurements')
plot(x_, 'DisplayName', 'Irregular RW signal')
legend
grid on
xlabel('Window length (m)')
ylabel('AVAR')

subplot(3,1,2)
loglog(tau, avar)
grid on
xlabel('Window length (m)')
ylabel('AVAR')

subplot(3,1,3)
histogram(t, 50)
xlabel('Time stamp value')
ylabel('Time stamp frequency')

