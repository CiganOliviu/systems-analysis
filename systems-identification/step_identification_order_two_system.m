t = treapta0(:, 1);
u = treapta0(:, 2);
y = treapta0(:, 4);

plot(t, [u, y]); hold on

cursor_info_index_1 = 431;
cursor_info_index_2 = 495;
cursor_info_index_3 = 640;
cursor_info_index_4 = 705;

y_0 = mean(y(cursor_info_index_1:cursor_info_index_2));
y_stationary = mean(y(cursor_info_index_3:cursor_info_index_4));

u_0 = mean(u(cursor_info_index_1:cursor_info_index_2));
u_stationary = mean(u(cursor_info_index_3:cursor_info_index_4));

K = (y_stationary - y_0) / (u_stationary - u_0);

cursor_info_index_5 = 501;
cursor_info_index_6 = 600;

y_max = y(cursor_info_index_6);
overclocking = (y_max - y_stationary) / (y_stationary - y_0);

teta = -log(overclocking) / sqrt(pi^2 + log(overclocking)^2);
Tosc = (t(cursor_info_index_6) - t(cursor_info_index_5)) / 0.5;

Wn = 2*pi / (Tosc*sqrt(1-teta));
Wosc = 2*pi / Tosc;
Tr = 4 / (teta*Wn);

A = [0 1; -Wn^2 -2*teta*Wn];
B = [0; K*Wn^2];
C = [1 0];
D = 0;

sys = ss(A, B, C, D);
ysim2 = lsim(sys, u, t, [y(1), 0]);

plot(t, ysim2)

J = sqrt(1 / length(y) * sum((y - y_simulated) .^ 2));

eMPN = norm(y - y_simulated) / norm(y - mean(y));