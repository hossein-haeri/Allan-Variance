function [avar] = AVAR(x,m_list)
%% coded by Hossein Haeri %%
%% the code estimates the Allan variance of regularly sampled data (can be used as MATLAB's 'allanvar' function which requires signal processing toolbox)

%% FUNCTION INPUTS %%
    % data_x: data values
    % m_list: list of window lengths which AVAR needs to be evaluated at (in units of number of samples)
%% FUNCTION OUTPUTS %%
    % avar: Allan variance of the data evaluated with each window length in tau_list 

% initialze n as number of data points 
n = numel(x);

% initialized avar as an empty list for storing Allan variance values
avar = [];

% iterate for each window length m
for i=1:numel(m_list)
    m = m_list(i);
    
    % calculate Allan variance accumulatively accross the time
    avar_sum = 0;
    for k= 1+m:n-2*m
        % use the definition of the Allan variance to calculate it at the time step k and window length m
        avar_sum = avar_sum + 0.5*(mean(x(k:k+m-1))-mean(x(k+m:k+2*m-1)))^2;
    end
    
    % average the accumulated Allan variance values
    avar = [avar avar_sum/(n-2*m)];
end

