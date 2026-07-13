% ================================
% Phase 2 - Parameter Estimation
% Estimate mu_max and Ks from data
% ================================

clc; clear; close all;

% --- True parameters (pretend we dont know these) ---
mu_max_true = 0.4;
Ks_true     = 0.1;
Yxs         = 0.5;
Ypx         = 0.3;
Sf          = 10.0;
F           = 0.05;

% --- Simulate "true" data ---
y0    = [0.5; 5.0; 0.0; 1.0];
tspan = [0, 24];

[t_true, y_true] = ode45(@(t,y) bioreactor_odes(t, y, mu_max_true, Ks_true, Yxs, Ypx, Sf, F), tspan, y0);

% --- Sample at specific time points (like real measurements) ---
t_exp = (0:2:24)';   % every 2 hours

X_true_sampled = interp1(t_true, y_true(:,1), t_exp);
S_true_sampled = interp1(t_true, y_true(:,2), t_exp);

% --- Add random noise to mimic real sensor error ---
noise_level = 0.05;
rng(42);
X_exp = X_true_sampled + noise_level * randn(size(t_exp)) .* X_true_sampled;
S_exp = S_true_sampled + noise_level * randn(size(t_exp)) .* S_true_sampled;

% --- Parameter Estimation using fminsearch ---
% Initial guess (deliberately wrong)
params0 = [0.6, 0.3];   % [mu_max_guess, Ks_guess]

% Objective function - minimise sum of squared errors
obj_fun = @(params) objective_function(params, t_exp, X_exp, S_exp, Yxs, Ypx, Sf, F, y0);

% Run optimisation
[params_estimated, fval] = fminsearch(obj_fun, params0);

mu_max_est = params_estimated(1);
Ks_est     = params_estimated(2);

fprintf('\n=============================\n');
fprintf(' Parameter Estimation Results\n');
fprintf('=============================\n');
fprintf('          True    Estimated\n');
fprintf('mu_max:   %.4f    %.4f\n', mu_max_true, mu_max_est);
fprintf('Ks:       %.4f    %.4f\n', Ks_true, Ks_est);
fprintf('=============================\n');

% --- Simulate with estimated parameters ---
[t_est, y_est] = ode45(@(t,y) bioreactor_odes(t, y, mu_max_est, Ks_est, Yxs, Ypx, Sf, F), tspan, y0);

% --- Plot Model vs Experimental Data ---
figure;

subplot(1,2,1);
plot(t_est, y_est(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t_exp, X_exp, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Time (hr)'); ylabel('Biomass (g/L)');
title('Biomass - Model vs Data');
legend('Model (estimated)', 'Experimental data');
grid on;

subplot(1,2,2);
plot(t_est, y_est(:,2), 'b-', 'LineWidth', 2); hold on;
plot(t_exp, S_exp, 'rs', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Time (hr)'); ylabel('Substrate (g/L)');
title('Substrate - Model vs Data');
legend('Model (estimated)', 'Experimental data');
grid on;

sgtitle('Phase 2 - Parameter Estimation Results');ppara
