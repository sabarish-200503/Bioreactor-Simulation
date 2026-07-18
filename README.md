#  Fed-Batch Bioreactor Simulation & Optimization

A computational bioprocess engineering project implementing **Monod kinetic modeling**, 
**parameter estimation**, **sensitivity analysis**, and **feed rate optimization** 
for a fed-batch bioreactor — built entirely in **GNU Octave**.

---

##  Project Overview

This project simulates the dynamic behavior of a fed-batch bioreactor producing a 
biological product (e.g., insulin, ethanol, or antibiotics) using mathematical modeling 
and numerical methods.

The complete bioprocess engineering workflow is demonstrated:

Build Model → Fit Parameters → Analyze Sensitivity → Optimize Process
Phase 1   →    Phase 2    →      Phase 3         →    Phase 4

---

##  Phases

### Phase 1 — Bioreactor Simulation
- Modeled biomass growth, substrate consumption, product formation and volume change
- Implemented **Monod kinetics** with fed-batch mass balance equations
- Solved system of ODEs using `ode45` (Runge-Kutta method)

**State Variables:**
| Variable | Description | Unit |
|---|---|---|
| X | Biomass concentration | g/L |
| S | Substrate concentration | g/L |
| P | Product concentration | g/L |
| V | Reactor volume | L |

**Monod Growth Rate:**

$$\mu = \mu_{max} \cdot \frac{S}{K_s + S}$$

---

### Phase 2 — Parameter Estimation
- Generated synthetic experimental data with realistic sensor noise
- Estimated kinetic parameters (µmax, Ks) from noisy data using `fminsearch`
- Minimized sum of squared errors between model and experimental data
- Validated estimated parameters against true values

---

### Phase 3 — Sensitivity Analysis
- Varied each parameter by ±10%, ±20%, ±30% from baseline
- Quantified impact on final biomass and product concentration
- Identified the most critical parameters for process control

---

### Phase 4 — Feed Rate Optimization
- Scanned feed rates from 0.01 to 0.20 L/hr
- Found optimal feed rate that maximizes final product concentration
- Compared optimized vs baseline fermentation profiles

---

##  Repository Structure
Bioreactor-Simulation/
├── Bioreactor.m               # Phase 1 - ODE simulation
├── bioreactor_odes.m          # Shared ODE function (Monod kinetics)
├── parameter_estimation.m     # Phase 2 - Parameter fitting
├── objective_function.m       # Phase 2 - Least squares objective
├── sensitivity_analysis.m     # Phase 3 - Sensitivity analysis
├── optimization.m             # Phase 4 - Feed rate optimization
├── LICENSE                    # MIT License
└── README.md                  # Project documentation

---

## ⚙️ Requirements

- **GNU Octave** 6.0 or higher (free download at octave.org)
- No additional toolboxes required — uses only built-in functions

---

##  How to Run

1. Clone or download this repository
2. Open GNU Octave
3. Navigate to the project folder:
```octave
cd 'path/to/Bioreactor-Simulation'
```
4. Run each phase in order:
```octave
Bioreactor              % Phase 1 - Simulation
parameter_estimation    % Phase 2 - Parameter Estimation
sensitivity_analysis    % Phase 3 - Sensitivity Analysis
optimization            % Phase 4 - Optimization
```

---

##  Results Summary

| Phase | Key Output |
|---|---|
| Phase 1 | Dynamic profiles of X, S, P, V over 24 hours |
| Phase 2 | Estimated µmax and Ks from noisy experimental data |
| Phase 3 | µmax identified as most sensitive parameter |
| Phase 4 | Optimal feed rate identified for maximum product yield |

---

##  Key Concepts Demonstrated

- **Monod Kinetics** — microbial growth rate modeling
- **Fed-batch mass balance** — dynamic ODE system
- **Nonlinear parameter estimation** — inverse problem solving
- **One-at-a-time sensitivity analysis** — process robustness evaluation
- **Process optimization** — maximizing bioprocess productivity
- **Numerical methods** — Runge-Kutta ODE solver (ode45)

---

##  Real World Applications

The methodology demonstrated in this project is directly applicable to:
- **Pharmaceutical manufacturing** — insulin, monoclonal antibodies
- **Vaccine production** — cell culture optimization
- **Biofuel production** — ethanol fermentation
- **Food biotechnology** — probiotic and enzyme production

---

##   References

1. Shuler, M.L. & Kargi, F. (2002). *Bioprocess Engineering: Basic Concepts*. Prentice Hall.
2. Monod, J. (1949). The growth of bacterial cultures. *Annual Review of Microbiology*, 3, 371–394.
3. Levenspiel, O. (1999). *Chemical Reaction Engineering*. John Wiley & Sons.

---

##   Author

Sabarish.G
B.Tech Biotechnology
SASTRA University 

Email - sabarish03062005@gmail.com
Linkdein -  www.linkedin.com/in/sabarish-g-7b959b2a7

---

##  License

This project is licensed under the MIT License — see the LICENSE file for details.

---

*This project was independently developed to demonstrate computational bioprocess 
engineering skills for academic and research applications.*
