function dydt = bioreactor_odes(t, y, mu_max, Ks, Yxs, Ypx, Sf, F)
  X = y(1);  % Biomass
  S = y(2);  % Substrate
  P = y(3);  % Product
  V = y(4);  % Volume

  % Monod growth rate
  mu = mu_max * (S / (Ks + S));

  D = F / V;  % Dilution rate

  % ODEs
  dXdt = (mu - D) * X;
  dSdt = D * (Sf - S) - (mu / Yxs) * X;
  dPdt = Ypx * mu * X - D * P;
  dVdt = F;

  dydt = [dXdt; dSdt; dPdt; dVdt];
end
