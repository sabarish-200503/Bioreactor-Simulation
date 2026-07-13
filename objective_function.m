function err = objective_function(params, t_exp, X_exp, S_exp, Yxs, Ypx, Sf, F, y0)
  mu_max = params(1);
  Ks     = params(2);

  % Simulate with current parameters
  try
    [t_sim, y_sim] = ode45(@(t,y) bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F), [0, max(t_exp)], y0);

    % Interpolate to experimental time points
    X_sim = interp1(t_sim, y_sim(:,1), t_exp);
    S_sim = interp1(t_sim, y_sim(:,2), t_exp);

    % Sum of squared errors
    err = sum((X_sim - X_exp).^2) + sum((S_sim - S_exp).^2);
  catch
    err = 1e10;  % large penalty if simulation fails
  end
end
