%nvsdg_shootingorder
%---------------------------
%Ply = [1:5]; %Ply_nm
%Ply_idx = [1:5];

Ply_nm = ply;
%t;

n = length (Ply_nm);
Ply_idx = [1:n];
TS = [];
TS_Idx = [];
Ply_NM = [];
P0S = []; % The set of P0;
PC_A = [];
i0 = 3; % Shooting Player
P0 = sps(:,i0);
pca = [];

for i1=1:n
    if i0 == i1
        ts_idx = length(t);
        ts = t(ts_idx);
        p_st = 1;
    else
    [ts, ts_idx, p_st, pca] = singlepairwiseshooting(sps,t,[i0 i1],0);
    end
    
    TS = [TS ts];
    TS_Idx = [TS_Idx ts_idx];
    P0S = [P0S p_st];
    PC_A = [PC_A pca(:)];
end

[Ply_nm(:) TS_Idx(:) TS(:) P0S(:)]
%plot(t,[P0 PC_A])