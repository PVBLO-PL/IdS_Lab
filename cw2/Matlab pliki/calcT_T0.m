function [T, T0] = calcT_T0(S, g)
    g_max = max(g); % g_max(1, 1) - index; g_max(1, 2) - value;
    ag = g_max(1, 2);
    tg = g_max(1, 1);
    sg = S(tg, 2);
    tg_real = S(tg, 1);
    K = S(end, 2);
    T0 = (ag*tg_real-sg)/ag;
    T = K/ag;
end