function [T, T0] = calcT_T0(S, g)
    [tg, ag] = findMax(g);
    sg = S(tg, 2);
    tg_real = S(tg, 1);
    K = S(end, 2);
    T0 = (ag*tg_real-sg)/ag;
    T = K/ag;
end