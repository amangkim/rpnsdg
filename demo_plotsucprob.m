%demo_plotsucprob

nvsdg_demo_setup
% FileName

NumPly = -1;
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
    DISP = ['Plotting the success probabilities of ' NumPlyStr ' players.........'];
    disp(DISP);
    ENT = input('Press [Enter] Key.........');
    
    sps = D.SucPro;
    t = D.Time;
    NumPlyStr = num2str (n_player);
    
    %---- Display -------------------
    TL = ['Success probabilities of ' num2str(n_player) '-players'];
    XL = 'Time';
    YL = 'Success probability';
    nvsdgplot(t,sps, TL, XL, YL);
    %--------------------------------


    %pcs = nvsdgfailprodgen (sps);
    [l0,n0] = size(sps);
    One1 = ones(l0,n0);
    pcs = One1-sps;

    %---- Display -------------------
    TL = 'Failure probabilities except for each dedicated player';
    YL = 'Product of failure probability';
    nvsdgplot(t,pcs, TL, XL, YL,1);
    %--------------------------------

else
    DISP = ['No data file.........'];
    disp(DISP);
end
