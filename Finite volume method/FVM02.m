%{
Second Task: Implementation and Analysis of 3-Point Schemes for Linear Advection

Problem Statement:
Consider the linear advection equation:

    u_t + a u_x = 0,   for (t, x) ∈ (0, T) × (0, 1),

with periodic boundary conditions u(t, 0) = u(t, 1) and initial condition u(x, 0) = sin(2πx).
Let a = 1 and T = 1.

We investigate the behavior and accuracy of several 3-point finite-difference schemes:

(1) Central Difference in Space:
    (u_j^{n+1} - u_j^n)/Δt + a (u_{j+1}^n - u_{j-1}^n)/(2Δx) = 0

(2) Upwind Scheme:
    (u_j^{n+1} - u_j^n)/Δt + a (u_{j+1}^n - u_j^n)/Δx = 0

(3) Lax–Friedrichs Scheme:
    (u_j^{n+1} - (u_{j+1}^n + u_{j-1}^n)/2)/Δt + a (u_{j+1}^n - u_{j-1}^n)/(2Δx) = 0

(4) Lax–Wendroff Scheme:
    (u_j^{n+1} - u_j^n)/Δt + a (u_{j+1}^n - u_{j-1}^n)/(2Δx)
    - a^2 Δt/2 (u_{j+1}^n - 2u_j^n + u_{j-1}^n)/Δx^2 = 0

Implement these schemes and:

• Simulate the solution for t ∈ {0, 0.5, 1}
• Animate the numerical solutions alongside the exact solution
• For each scheme, compute the numerical error at T = 1 and determine the observed
  order of convergence using grid resolutions N = 50, 100, 200, 400.
%}

% Define parameters
a = 1.0;       % Advection speed
T = 1.0;       % Total time
times = [0, 0.5, 1]; % Times to visualize
N_values = [200, 300, 400]; % Different resolutions for convergence analysis

% Define the initial condition function
u0 = @(x) sin(2 * pi * x);

% Define the flux function
f = @(u) a * u;

% Define the numerical flux function for each scheme
g1 = @(ui, uj) 0.5 * (f(ui) + f(uj));
g2 = @(ui, uj) f(ui);
g3 = @(ui, uj) 0.5 * (f(ui) + f(uj));
g4 = @(ui, uj) 0.5 * (f(ui) + f(uj));

% Define the schemes
schemes = {@scheme1, @scheme2, @scheme3, @scheme4};
scheme_names = {'Scheme (i)', 'Scheme (ii)', 'Scheme (iii)', 'Scheme (iv)'};

% Initialize storage for errors
errors = zeros(length(schemes), length(N_values));

% Loop over different grid resolutions
for n_idx = 1:length(N_values)
    N = N_values(n_idx); % Number of cells
    dx = 1.0 / N;        % Spatial step size
    CFL = 0.5;           % CFL number
    dt = CFL * dx / a;   % Time step size
    nt = floor(T / dt);  % Number of time steps
    x = linspace(0, 1, N+1); % Discretize the domain [0, 1)
    x = x(1:end-1); % Adjust for periodic boundary conditions
    
    % Initialize the solution array
    u_init = u0(x);
    
    % Loop over the schemes
    for s_idx = 1:length(schemes)
        % Get the scheme function handle
        scheme = schemes{s_idx};
        
        % Initialize the solution
        u = u_init;
        
        % Time-stepping loop
        for n = 1:nt
            u = scheme(u, dt, dx, N);
        end
        
        % Calculate error for convergence analysis
        u_exact = u0(mod(x - a * T, 1)); % Exact solution at T=1
        errors(s_idx, n_idx) = max(abs(u - u_exact));
        
        % Plot the approximate and exact solutions
        figure;
        for t_val = times
            time_steps = round(t_val / dt);
            if time_steps > nt
                time_steps = nt;
            end
            u_vis = u_init;
            for t = 1:time_steps
                u_vis = scheme(u_vis, dt, dx, N);
            end
            
            subplot(length(times), 1, find(times == t_val));
            plot(x, u_vis, 'b', 'DisplayName', 'Approximate solution');
            hold on;
            plot(x, u0(mod(x - a * t_val, 1)), 'r--', 'DisplayName', 'Exact solution');
            title(sprintf('%s, N = %d, t = %.1f', scheme_names{s_idx}, N, t_val));
            xlabel('x');
            ylabel('u');
            legend;
            hold off;
        end
    end
end

% Calculate and display the order of convergence
for s_idx = 1:length(schemes)
    p = polyfit(log(N_values), log(errors(s_idx, :)), 1);
    disp(['Order of convergence for ', scheme_names{s_idx}, ': ', num2str(-p(1))]);
end

% Scheme (i)
function u_next = scheme1(u, dt, dx, N)
    a = 1.0; % Advection speed
    u_next = u;
    for i = 1:N
        ip1 = mod(i, N) + 1;
        im1 = mod(i-2, N) + 1;
        u_next(i) = u(i) - (a * dt / (2 * dx)) * (u(ip1) - u(im1));
    end
end

% Scheme (ii)
function u_next = scheme2(u, dt, dx, N)
    a = 1.0; % Advection speed
    u_next = u;
    for i = 1:N
        ip1 = mod(i, N) + 1;
        u_next(i) = u(i) - (a * dt / dx) * (u(ip1) - u(i));
    end
end

% Scheme (iii)
function u_next = scheme3(u, dt, dx, N)
    a = 1.0; % Advection speed
    u_next = u;
    for i = 1:N
        ip1 = mod(i, N) + 1;
        im1 = mod(i-2, N) + 1;
        u_next(i) = (u(ip1) + u(im1)) / 2 - (a * dt / (2 * dx)) * (u(ip1) - u(im1));
    end
end

% Scheme (iv)
function u_next = scheme4(u, dt, dx, N)
    a = 1.0; % Advection speed
    u_next = u;
    for i = 1:N
        ip1 = mod(i, N) + 1;
        im1 = mod(i-2, N) + 1;
        u_next(i) = u(i) - (a * dt / (2 * dx)) * (u(ip1) - u(im1)) + ...
                    (a^2 * dt^2 / (2 * dx^2)) * (u(ip1) - 2 * u(i) + u(im1));
    end
end