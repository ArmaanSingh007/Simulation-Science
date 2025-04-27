%{
Finite Volume Scheme 
---------------------------------------------------------------------------
We want to implement finite volume scheme. Therefore we consider the following problem:

    u_t + f(u)_x = 0   for all (t, x) in (0, T) × (0, 1),
    u(0, x) = u0(x)    for all x in (0, 1).

We restrict ourselves to periodic problems:

    u(t, 0) = u(t, 1).

We discretize [0, 1] by N cells Ij := (xj, xj+1), j = 0, ..., N−1,
where xj = j * Δx = j / N.

Let un_i denote the approximate mean value on the cell Ij at discrete time level tn, i.e.,

    un_i ≈ (1/Δx) ∫_{Ij} u(tn, x) dx.

We implement a 3-point finite-volume scheme of the form:

    un+1_i = un_i - (Δt/Δx) * (g(un_i, un_{i+1}) - g(un_{i-1}, un_i)).

Hint: Use the periodicity at the boundaries, i.e., un_{-1} = un_{N-1} and un_{N} = un_{0}.
---------------------------------------------------------------------------
%}



% Define parameters
T = 1.0;       % Total time
N = 100;       % Number of cells
x = linspace(0, 1, N+1); % Discretize the domain [0, 1)
x = x(1:end-1); % Adjust for periodic boundary conditions
dx = 1.0 / N;  % Spatial step size
CFL = 0.5;     % CFL number
a = 1.0;       % Advection speed

% Define the initial condition function
u0 = @(x) sin(2 * pi * x);

% Define the flux function
f = @(u) a * u; % Physical flux function

% Define the numerical flux function
g = @(ui, uj) 0.5 * (f(ui) + f(uj)); 

% Initialize the solution array
u = u0(x);

% Time step size based on CFL condition
dt = CFL * dx / a;
nt = floor(T / dt);  % Number of time steps

% Create a figure for animation
figure;
hold on;
grid on;
xlabel('x');
ylabel('u');
title('Finite Volume Scheme for Periodic Problem');
xlim([0 1]);
ylim([-1.5 1.5]);

% Plot the initial condition (static)
plot(x, u0(x), 'b-', 'DisplayName', 'Initial condition');

% Prepare storage for animation
u_record = zeros(nt, N);
for n = 1:nt
    u_new = u;
    for i = 1:N
        ip1 = mod(i, N) + 1;
        im1 = mod(i-2, N) + 1;
        u_new(i) = u(i) - (dt / dx) * (g(u(i), u(ip1)) - g(u(im1), u(i)));
    end
    u = u_new;
    u_record(n, :) = u;
end

% Animate the numerical solution using comet
h = animatedline('Color', 'r', 'LineWidth', 1.5, 'DisplayName', 'Numerical solution');

for n = 1:nt
    clearpoints(h);
    addpoints(h, x, u_record(n, :));
    drawnow;
    pause(0.01); % Control animation speed
end

% Show the legend after setting all plots
legend show;

