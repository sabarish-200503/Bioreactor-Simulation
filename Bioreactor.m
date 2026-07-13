% ================================
% Fed-Batch Bioreactor Simulation
% Monod Kinetics Model
% ================================

clc; clear; close all;

% --- Kinetic Parameters ---
mu_max = 0.4;    % Max specific growth rate (1/hr)
Ks     = 0.1;    % Half-saturation constant (g/L)
Yxs    = 0.5;    % Biomass yield on substrate (g/g)
Ypx    = 0.3;    % Product yield on biomass (g/g)
Sf     = 10.0;   % Feed substrate concentration (g/L)
F      = 0.05;   % Feed flow rate (L/hr)

% --- Initial Conditions [X, S, P, V] ---
X0 = 0.5;   % Biomass (g/L)
S0 = 5.0;   % Substrate (g/L)
P0 = 0.0;   % Product (g/L)
V0 = 1.0;   % Volume (L)

y0 = [X0; S0; P0; V0];

% --- Time Span ---
tspan = [0, 24];  % 24 hours

% --- Solve ODE ---
[t, y] = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F), tspan, y0);

% --- Extract Results ---
X = y(:,1);  % Biomass
S = y(:,2);  % Substrate
P = y(:,3);  % Product
V = y(:,4);  % Volume

% --- Plot Results ---
figure;
subplot(2,2,1);
plot(t, X, 'b-', 'LineWidth', 2);
xlabel('Time (hr)'); ylabel('Biomass (g/L)');
title('Biomass Growth'); grid on;

subplot(2,2,2);
plot(t, S, 'r-', 'LineWidth', 2);
xlabel('Time (hr)'); ylabel('Substrate (g/L)');
title('Substrate Consumption'); grid on;

subplot(2,2,3);
plot(t, P, 'g-', 'LineWidth', 2);
xlabel('Time (hr)'); ylabel('Product (g/L)');
title('Product Formation'); grid on;

subplot(2,2,4);
plot(t, V, 'm-', 'LineWidth', 2);
xlabel('Time (hr)'); ylabel('Volume (L)');
title('Volume Change'); grid on;

sgtitle('Fed-Batch Bioreactor Simulation - Monod Kinetics');
