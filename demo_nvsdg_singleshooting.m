%demo_nvsdg_singleshooting

nvsdg_demo_setup
%n_player = 5;
%duration = 30;
%epsilon = 0.1;
FileName

NumPly = -1;
Ply0_idx = -1;
sp = [];
Flag = 0;

if exist(FileName, 'file') == 2
    D = load (FileName);
    disp('Loading the success probabilities of players......');    
    n_player = D.TotalPlayers;
    Flag = 1; % Demo -- ON

else    
    Flag = 0; % Demo -- OFF
end

if Flag == 1
    sps = D.SucPro;
    t = D.Time;
    NumPlyStr = num2str (n_player);

    while Ply0_idx < 0 || Ply0_idx > n_player
        DISP = ['Pick up the player within [1] - [' NumPlyStr '] to find the best shooting time...........'];
        disp(DISP);
        Ply0_idx = input('Choose one player (0:exit): ');
    end
    
    %-----------------------------------------------
    
    
    %[ts, ts_idx, p_star, pca] = singlepairwiseshooting(sps, t, Ply0_idx, 3, ply_nm);
    %inputs={'SucPro', 'Time', 'Ply_idx', 'DispOtp', 'Ply_nm'};
    
    %NVSDG = findbestshooting(sps,t,Ply0_idx,1,ply_nm);
    B3 = nvsdgbestshooting(sps,t,Ply0_idx,bul,1,ply_nm);
    %inputs={'SucPro', 'Time', 'Shooter_idx', 'DispOtp', 'Ply_nm'};
else
    disp(['Pre-loaded file is NOT exsist......']);
end



