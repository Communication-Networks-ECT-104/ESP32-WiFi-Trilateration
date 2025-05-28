% This code generates the best fitting pathloss functions that are later used to get an 
% approximations of the distances of a device from all reachable access points. A detailed 
% analysis of this code is provided in section 3.4 of the project report.

% Data
d = [1,5,10,15,20,25,30,35,40,45,50,55,60,65,70];
r = [-42.5,-56,-63,-66,-64,-73,-70,-74,-75,-70,-80,-80,-81,-75,-90];

% Transform for linear regression
X = log10(d)';
Y = r';

% Fit linear model: Y = a + b*log10(d)
coeffs = polyfit(X, Y, 1);
b = coeffs(1);  % Slope
a = coeffs(2);  % Intercept

% Calculate path loss exponent n
n = -b / 10;

fprintf("Estimated RSSI_0 (at 1m): %.2f dBm\n", a);
fprintf("Estimated path loss exponent (n): %.2f\n", n);

% Plot
fitted_rssi = polyval(coeffs, X);
plot(d, r, 'ro', 'MarkerSize', 8, 'DisplayName', 'Measured RSSI');
hold on;
plot(d, fitted_rssi, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Model');
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
legend;
title('RSSI vs. Distance - Path Loss Model Fit');
grid on;hold off
out=@(r) 10.^((-40.81-r)/(10*2.16))
rssi = -90;  % RSSI reading from ESP32
distance_est = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est);
% Data
d = [1,5,10,15,20,25,30,35,40];
r = [-62,-73.5,-82,-81.5,-86.5,-89.5,-88,-90,-92,];


% Transform for linear regression
X = log10(d)';
Y = r';

% Fit linear model: Y = a + b*log10(d)
coeffs = polyfit(X, Y, 1);
b = coeffs(1);  % Slope
a = coeffs(2);  % Intercept

% Calculate path loss exponent n
n = -b / 10;

fprintf("Estimated RSSI_0 (at 1m): %.2f dBm\n", a);
fprintf("Estimated path loss exponent (n): %.2f\n", n);

% Plot
fitted_rssi = polyval(coeffs, X);
plot(d, r, 'ro', 'MarkerSize', 8, 'DisplayName', 'Measured RSSI');
hold on;
plot(d, fitted_rssi, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Model');
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
legend;
title('RSSI vs. Distance - Path Loss Model Fit');
grid on;
hold off
out=@(r) 10.^((-61.65-r)/(10*1.86))
rssi = -85;  % RSSI reading from ESP32
distance_est = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est);
% Data
d = [1,5,10,15,20,25,30,35];
r = [-35,-49,-66,-74.5,-76,-85,-86,-90];

% Transform for linear regression
X = log10(d)';
Y = r';

% Fit linear model: Y = a + b*log10(d)
coeffs = polyfit(X, Y, 1);
b = coeffs(1);  % Slope
a = coeffs(2);  % Intercept

% Calculate path loss exponent n
n = -b / 10;

fprintf("Estimated RSSI_0 (at 1m): %.2f dBm\n", a);
fprintf("Estimated path loss exponent (n): %.2f\n", n);

% Plot
fitted_rssi = polyval(coeffs, X);
plot(d, r, 'ro', 'MarkerSize', 8, 'DisplayName', 'Measured RSSI');
hold on;
plot(d, fitted_rssi, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Model');
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
legend;
title('RSSI vs. Distance - Path Loss Model Fit');
grid on;hold off
out=@(r) 10.^((-30.53-r)/(10*3.69))
rssi = -120;  % RSSI reading from ESP32
distance_est = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est);
% Data
d = [1,5,10,15,20,25,30,35,40,45];
r = [-42,-47,-58,-58,-64,-72,-65,-68,-66,-69];

% Transform for linear regression
X = log10(d)';
Y = r';

% Fit linear model: Y = a + b*log10(d)
coeffs = polyfit(X, Y, 1);
b = coeffs(1);  % Slope
a = coeffs(2);  % Intercept

% Calculate path loss exponent n
n = -b / 10;

fprintf("Estimated RSSI_0 (at 1m): %.2f dBm\n", a);
fprintf("Estimated path loss exponent (n): %.2f\n", n);

% Plot
fitted_rssi = polyval(coeffs, X);
plot(d, r, 'ro', 'MarkerSize', 8, 'DisplayName', 'Measured RSSI');
hold on;
plot(d, fitted_rssi, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Model');
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
legend;
title('RSSI vs. Distance - Path Loss Model Fit');
grid on;hold off
out=@(r) 10.^((-39.59-r)/(10*1.80))
rssi = -64;  % RSSI reading from ESP32
distance_est = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est);
% Data
d = [1,5,10,15,20,25,30];
r = [-55,-62,-69,-78,-85,-88,-91,];

% Transform for linear regression
X = log10(d)';
Y = r';

% Fit linear model: Y = a + b*log10(d)
coeffs = polyfit(X, Y, 1);
b = coeffs(1);  % Slope
a = coeffs(2);  % Intercept

% Calculate path loss exponent n
n = -b / 10;

fprintf("Estimated RSSI_0 (at 1m): %.2f dBm\n", a);
fprintf("Estimated path loss exponent (n): %.2f\n", n);

% Plot
fitted_rssi = polyval(coeffs, X);
plot(d, r, 'ro', 'MarkerSize', 8, 'DisplayName', 'Measured RSSI');
hold on;
plot(d, fitted_rssi, 'b-', 'LineWidth', 2, 'DisplayName', 'Fitted Model');
xlabel('Distance (m)');
ylabel('RSSI (dBm)');
legend;
title('RSSI vs. Distance - Path Loss Model Fit');
grid on;hold off
out=@(r) 10.^((-50.06-r)/(10*2.7))
rssi = -85;  % RSSI reading from ESP32
distance_est = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est);