t = treapta0(:, 1);
u = treapta0(:, 2);
y = treapta0(:, 3);

plot(t, [u, y]); hold on

cursor_info_index_1 = 435;
cursor_info_index_2 = 494;
cursor_info_index_3 = 604;
cursor_info_index_4 = 708;

y_0 = mean(y(cursor_info_index_1:cursor_info_index_2));
y_stationary = mean(y(cursor_info_index_3:cursor_info_index_4));

u_0 = mean(u(cursor_info_index_1:cursor_info_index_2));
u_stationary = mean(u(cursor_info_index_3:cursor_info_index_4));

k = (y_stationary - y_0) / (u_stationary - u_0);

y_at_63 = y_0 + 0.63 * (y_stationary - y_0);

plot(t, y_at_63 * ones(1, length(t)));

cursor_info_time_constant_index_1 = 501;
cursor_info_time_constant_index_2 = 508;

T = t(cursor_info_time_constant_index_2) - t(cursor_info_time_constant_index_1);

A = -1/T;
B = k/T;
C = 1;
D = 0;

system = ss(A, B, C, D);
y_simulated = lsim(system, u, t, y(1));

plot(t, y_simulated);

J = sqrt(1 / length(y) * sum((y - y_simulated) .^ 2));

eMPN = norm(y - y_simulated) / norm(y - mean(y));