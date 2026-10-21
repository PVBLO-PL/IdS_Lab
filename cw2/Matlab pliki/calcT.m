function T = calcT(T50, T90, val50, val90)
    T = ((T50/val50)+(T90/val90))/2;
end