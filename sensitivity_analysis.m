% ================================
% Phase 3 - Sensitivity Analysis
% How much does each parameter
% affect Biomass and Product?
% ================================

clc; clear; close all;

% --- Base Parameters ---
mu_max = 0.4;
Ks     = 0.1;
Yxs    = 0.5;
Ypx    = 0.3;
Sf     = 10.0;
F      = 0.05;
y0     = [0.5; 5.0; 0.0; 1.0];
tspan  = [0, 24];

% --- Base simulation ---
[t_base, y_base] = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F), tspan, y0);
X_base_final = y_base(end, 1);
P_base_final = y_base(end, 3);

% --- Parameters to vary (+-10%, +-20%, +-30%) ---
param_names  = {'mu\_max', 'Ks', 'Yxs', 'Ypx', 'Sf', 'F'};
base_values  = [mu_max, Ks, Yxs, Ypx, Sf, F];
variations   = [-0.30, -0.20, -0.10, 0, 0.10, 0.20, 0.30];

X_sensitivity = zeros(length(param_names), length(variations));
P_sensitivity = zeros(length(param_names), length(variations));

for i = 1:length(param_names)
  for j = 1:length(variations)

    % Vary one parameter at a time
    params = base_values;
    params(i) = base_values(i) * (1 + variations(j));

    mu_max_v = params(1);
    Ks_v     = params(2);
    Yxs_v    = params(3);
    Ypx_v    = params(4);
    Sf_v     = params(5);
    F_v      = params(6);

    try
      [~, y_v] = ode45(@(t,y) bioreactor_odes(t, y, mu_max_v, Ks_v, Yxs_v, Ypx_v, Sf_v, F_v), tspan, y0);
      X_sensitivity(i,j) = (y_v(end,1) - X_base_final) / X_base_final * 100;
      P_sensitivity(i,j) = (y_v(end,3) - P_base_final) / P_base_final * 100;
    catch
      X_sensitivity(i,j) = 0;
      P_sensitivity(i,j) = 0;
    end

  end
end

% --- Plot Sensitivity ---
figure;

subplot(1,2,1);
bar(variations*100, X_sensitivity');
xlabel('Parameter Change (%)');
ylabel('Biomass Change (%)');
title('Sensitivity - Biomass');
legend(param_names, 'Location', 'northwest');
grid on;

subplot(1,2,2);
bar(variations*100, P_sensitivity');
xlabel('Parameter Change (%)');
ylabel('Product Change (%)');
title('Sensitivity - Product');
legend(param_names, 'Location', 'northwest');
grid on;

sgtitle('Phase 3 - Sensitivity Analysis');

% --- Print most sensitive parameter ---
[~, idx_X] = max(abs(X_sensitivity(:, end)));
[~, idx_P] = max(abs(P_sensitivity(:, end)));

fprintf('\n=====================================\n');
fprintf(' Sensitivity Analysis Summary\n');
fprintf('=====================================\n');
fprintf('Most influential on Biomass:  %s\n', param_names{idx_X});
fprintf('Most influential on Product:  %s\n', param_names{idx_P});
fprintf('=====================================\n');sensitivity_analysis
