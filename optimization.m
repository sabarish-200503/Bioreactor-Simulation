% ================================
% Phase 4 - Feed Rate Optimization
% Find best F to maximize Product
% ================================

clc; clear; close all;

% --- Fixed Parameters ---
mu_max = 0.4;
Ks     = 0.1;
Yxs    = 0.5;
Ypx    = 0.3;
Sf     = 10.0;
y0     = [0.5; 5.0; 0.0; 1.0];
tspan  = [0, 24];

% --- Scan Feed Rates ---
F_values     = 0.01:0.005:0.20;
P_final      = zeros(size(F_values));
X_final      = zeros(size(F_values));

for i = 1:length(F_values)
  F = F_values(i);
  try
    [~, y] = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F), tspan, y0);
    P_final(i) = y(end, 3);
    X_final(i) = y(end, 1);
  catch
    P_final(i) = 0;
    X_final(i) = 0;
  end
end

% --- Find Optimum ---
[P_max, idx] = max(P_final);
F_optimal    = F_values(idx);

fprintf('\n=====================================\n');
fprintf(' Optimization Results\n');
fprintf('=====================================\n');
fprintf('Optimal Feed Rate:     %.4f L/hr\n', F_optimal);
fprintf('Maximum Product:       %.4f g/L\n', P_max);
fprintf('Biomass at optimum:    %.4f g/L\n', X_final(idx));
fprintf('=====================================\n');

% --- Plot Product vs Feed Rate ---
figure;

subplot(2,1,1);
plot(F_values, P_final, 'g-', 'LineWidth', 2); hold on;
plot(F_optimal, P_max, 'rv', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
xlabel('Feed Rate F (L/hr)');
ylabel('Final Product (g/L)');
title('Product vs Feed Rate');
legend('Product', sprintf('Optimum F = %.3f L/hr', F_optimal));
grid on;

subplot(2,1,2);
plot(F_values, X_final, 'b-', 'LineWidth', 2); hold on;
plot(F_optimal, X_final(idx), 'rv', 'MarkerSize', 12, 'MarkerFaceColor', 'r');
xlabel('Feed Rate F (L/hr)');
ylabel('Final Biomass (g/L)');
title('Biomass vs Feed Rate');
legend('Biomass', sprintf('Optimum F = %.3f L/hr', F_optimal));
grid on;

sgtitle('Phase 4 - Feed Rate Optimization');

% --- Simulate at optimal F and compare with base F ---
F_base = 0.05;
[t_base, y_base] = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F_base), tspan, y0);
[t_opt,  y_opt]  = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F_optimal), tspan, y0);

figure;
plot(t_base, y_base(:,3), 'b--', 'LineWidth', 2); hold on;
plot(t_opt,  y_opt(:,3),  'r-',  'LineWidth', 2);
xlabel('Time (hr)');
ylabel('Product (g/L)');
title('Product Profile - Base vs Optimized Feed Rate');
legend(sprintf('Base F = %.2f L/hr', F_base), ...
       sprintf('Optimal F = %.3f L/hr', F_optimal));
grid on;optimization
