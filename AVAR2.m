function avar = AVAR2(data_t,data_x,tau_list)

%% FUNCTION INPUTS %%
% data_t: data time stamps
% data_x: data values
% tau_list: list of window lengths which AVAR needs to be evaluated with 
%% FUNCTION OUTPUTS %%
% avar: Allan variance of the data evaluated with each window length in tau_list 


%%
avar = zeros(numel(tau_list),1);
t_min = data_t(1);
t_max = data_t(end);

% resulation of sliding integration
dt = mean(diff(data_t))/2;
% dt = 0.1;

% for each window length (tau) in tau_list
for tau_indx= 1:numel(tau_list)        
    tau = tau_list(tau_indx);
    total_weights = 0;
    E = 0;
    dt = tau/2;
    % for each sliding time t
    for t= t_min:dt:t_max

        % extract data points which fall into the two adjacent windows 1 and 2 
        x_1 = data_x(t<data_t & data_t<t+tau);
        x_2 = data_x(t+tau<data_t & data_t<t+2*tau);
        
%         x_1 = data_x(data_t<t & data_t>t-tau);
%         x_2 = data_x(data_t<t-tau & data_t>t-2*tau);
        
        % count how many points each windows contains
        c_1 = numel(x_1);
        c_2 = numel(x_2);
        
        % calculate the weight
        weight = c_1 * c_2;
        
        % compute average values of each window
        x_bar_1 = mean(x_1);
        x_bar_2 = mean(x_2);

        % if weight is nonzero then
        if ~weight==0
%                 weight = 1;
                %  add the weighted squared difference of averages to E
                E = E + weight*(x_bar_1 -  x_bar_2)^2;
                % keep track of total weights
                total_weights  = total_weights + weight;
        end
        
    end

    % normalize expected value with respect of the weights
    E = 0.5*E/total_weights;
    avar(tau_indx) = E;
end
end




