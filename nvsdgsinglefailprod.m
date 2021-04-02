function nvsdgfailprod = nvsdgsinglefailprod(gamematrix )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

%player0 = masterplayer;
d = gamematrix;


PC = [];
[l, n] = size (d);
pc0 = ones(l,1);

for i = 1:n
    for j=1:n
        if j == i
            pc = ones(l,1);
        else
            pc = ones(l,1)-d(:,j);
        end
        pc0 = pc0.*pc;
    end
    PC = [PC pc0];
    
end

    
nvsdgfailprod = PC;

end