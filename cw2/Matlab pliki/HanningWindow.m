function out = HanningWindow(tau, Mw)
    if abs(tau) < Mw
        out = 0.5*(1 + cos((tau*pi)/Mw));
    else
        out = 0;
    end
end