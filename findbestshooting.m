function NVSDG = findbestshooting(varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%-----------------------------------------------
inputs={'SucPro', 'Time', 'Shooter_idx', 'DispOtp', 'Ply_nm'};
Time = [];
Shooter_idx = 1;
Ply_nm = [];
%DispOtp = 1;
DispOtp = [];

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%----------------------------------------------

sps = SucPro;
t = Time;

[dum n] = size(sps);

if isempty (Ply_nm)
    Ply_nm = [1:n];
end


%----------------------------------------------
%Ply_nm = ply;
%t;
%n = length (Ply_nm);
%Ply_idx = [1:n];

TS = [];
TS_Idx = [];
Ply_NM = [];
Ply_Idx = [];
P0S = []; % The set of P0;
PC_A = [];
i0 = Shooter_idx; % Shooting Player
P0 = sps(:,i0);
pca = [];

for i1=1:n
    if i0 == i1
        ts_idx = length(t);
        ts = t(ts_idx);
        p_st = 1;
    else
        [ts, ts_idx, p_st, pca] = singlepairwiseshooting(sps,t,[i0 i1],0);
        Ply_Idx = [Ply_Idx i1];
        Ply_NM = [Ply_NM Ply_nm(i1)];
        TS = [TS ts];
        TS_Idx = [TS_Idx ts_idx];
        P0S = [P0S p_st];
        PC_A = [PC_A pca(:)];
    end

    
end

[t1 t1_idx] = min (TS); %---- Finding first target to shoot
[t_opt_idx sply_idx]= sort(TS_Idx); % Sorted best shooting time

M.ShtTgt_nm = [Ply_nm(i0) Ply_NM(t1_idx)];
M.ShtTgt_idx = [i0 Ply_Idx(t1_idx)];
M.FirstTarget = [Ply_Idx(t1_idx) Ply_NM(t1_idx) TS_Idx(t1_idx) TS(t1_idx) P0S(t1_idx)];
M.Set = [Ply_Idx(:) Ply_NM(:) TS_Idx(:) TS(:) P0S(:)];
M.SetSorted = [Ply_Idx(sply_idx)' Ply_NM(sply_idx)' TS_Idx(sply_idx)' TS(sply_idx)' P0S(sply_idx)'];
M.SucProb = sps(:,i0);
M.FailProb = PC_A(t1_idx);


if DispOtp >= 0 %----------------------------------------------
    
    STR = ['\n Shooter: Player-' num2str(Ply_nm(i0)) '\n'];
    Cont1 = '\n  || Tgt_idx | Tgt_nm  | t*_indx |   t*  | P0@t* ||';
    Cont2 = '\n  ||   [1]   |   [2]   |   [3]   |  [4]  |  [5]  ||';
    Ln =    '\n  ++---------+---------+---------+--------+------++'; 
    fprintf([STR Ln Cont1 Cont2 Ln]);    
    M.Set

end %-----------------------------------------------------

if DispOtp >= 2 %-----------------------------------------    
    %[t_opt_idx sply_idx]= sort(TS_Idx);
    opt_idx = TS_Idx(t1_idx);    
    Ply0 = i0;
    Ply1 = Ply_NM(t1_idx);
    pc_a = PC_A(:,t1_idx);
    p0 =  sps(:,i0);
    opt_val = [t(opt_idx) p0(opt_idx)];
    opt_val(1);
    
    
    
    figure
    hold on
    grid on
    title ('First shooting optimal time @ t*');
    ylabel ('Shooting chance [0,1]');
    xlabel ('Time');
    
	
    plot (t, p0, 'b', 'linewidth',1.1);
    plot(t, pc_a, 'c', 'linewidth',2);
    plot(t(opt_idx), p0(opt_idx)+0.05,'rv','MarkerSize',8,'MarkerFaceColor','r');


    OptPly0 = ['Optimal @ ' num2str(opt_val(1))];
    Ply0Str = ['Player-' num2str(Ply0)];
    Ply1Str = ['Player-' num2str(Ply1) ' fails'];
    
    legend(Ply0Str, Ply1Str, OptPly0,'Location','northwest');
    %legend(Ply0Str, Ply1Str,'Location','northwest');
    hold off
    
end %-----------------------------------------

if DispOtp >= 1 %-----------------------------

    Ply0 = Ply_nm(i0);
    Ply1 = Ply_NM(sply_idx);
    PC_A1 = PC_A(:,sply_idx);
    p0 =  sps(:,i0);
    nd = length(TS_Idx);
    
    y1 = p0(t_opt_idx);
    t1 = t(t_opt_idx);

    %-------------------------------------------
    
    player_leg = [];
    
    for i4 =1:nd
        eply = Ply1(i4);
        t0 = t1(i4);
        eachply = ['with Player-' num2str(eply) ' @ ' num2str(t0, '%4.2e')];
        player_leg = [player_leg; eachply];
    end
    %-------------------------------------------    
    
    %player_leg
    eachply0 = ['Shooter: Player-' num2str(Ply0)];
    %player_leg = [eachply0; player_leg]

    
    figure
	hold on
	grid on
	%title ('Finding optimal timing t*');
    title (['Best shooting time for pairwise players [' eachply0 ']']);
	ylabel ('Shooting chance [0,1]');
	xlabel ('Time');
        
    plot(t,PC_A1);
    legend (player_leg,'Location','northeast');
    plot (t, p0, 'b', 'linewidth',1.1);
    %legend (player_leg,eachply0,'Location','northeast');
    hold off
    
	
	
end %-----------------------------------------


NVSDG = M;


end

