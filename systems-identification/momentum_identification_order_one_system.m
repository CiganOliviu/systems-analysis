t = impuls0(:, 1);
u = impuls0(:, 2);
y = impuls0(:, 3);

plot(t, [u, y]); hold on

cursor_info_index_1 = 170;
cursor_info_index_2 = 200;

y_stationary = mean(y(cursor_info_index_1:cursor_info_index_2));
u_stationary = mean(u(cursor_info_index_1:cursor_info_index_2));

K = y_stationary / u_stationary;
y_max = 3.4375;
y_37 = 0.37 * (y_max - y_stationary) + y_stationary;

plot(t, y_37*ones(1, length(t)));

cursor_info_data_index_3 = 238;
cursor_info_data_index_4 = 255;

T = t(cursor_info_data_index_4) - t(cursor_info_data_index_3);

A = -1/T;
B = K/T;
C = 1;
D = 0;

system = ss(A, B, C, D);
y_simulated = lsim(system, u, t, y(1));

plot(t, y_simulated)

J = sqrt(1 / length(y) * sum((y - y_simulated) .^ 2));

eMPN = norm(y - y_simulated) / norm(y - mean(y))