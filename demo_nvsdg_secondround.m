% demo_nvsdg_secondround
% nvsdg_shootingorder_demo
% Shooting order demo for 5 players

clear all;
nvsdg_demo_setup;

SP = load (FileName);
t = SP.Time;
sps0 = SP.SucPro;


Ply_nm0 = [1:5];
%Bul = [1 1 1 1 1];

%sps = sps0*diag(Bul);


%-------------------------------------------------------------
shoot_suc = 1;
DISP0 = ['Player Set = ' num2str(Ply_nm0) '\n'];
DISP1 = ['Please, select the shooter and the target....\n'];
fprintf([DISP0 DISP1]);
shoot_target_idx = input('(ex. [Shooter Target]) : ');
shoot_suc = input('Success to shoot the target [0-No,1-Yes]? ');
%-------------------------------------------------------------

[t0s t0s_idx] = singlepairwiseshooting(sps0,t,shoot_target_idx,0);
[sps Ply_nm] = shootingaction(sps0,Ply_nm0,shoot_target_idx,shoot_suc);


%----------------------
n1 = length(t);
t1s_idx =[t0s_idx:n1]; 
%sps = sps([t0_idx:n1],:);
%----------------------

ply_len = length(Ply_nm);
Ply_idx  = [1:ply_len];

PairSet = [];
PS1 = [];
PS2 = [];
TS_idx = [];
TStar = [];

%===========================================
TS = [];
TS_Idx = [];
Ply0_NM = [];
Ply0_Idx = [];
Ply1_NM = [];
Ply1_Idx = [];
P0S = []; % The set of P0;
PC_A = [];
%i0 = Shooter_idx; % Shooting Player
%P0 = sps(:,i0);
%pca = [];



for i0 = 1:ply_len
    for i1=i0+1:ply_len
        [ts, ts_idx, p_st, pca] = singlepairwiseshooting(sps,t,[i0 i1],0);
        t_max = t(length(t));
        if ts>=0.95*t_max
            ts_idx = length(t);            
        end
        Ply0_Idx = [Ply0_Idx i0];
        Ply0_NM = [Ply0_NM Ply_nm(i0)];
        Ply1_Idx = [Ply1_Idx i1];
        Ply1_NM = [Ply1_NM Ply_nm(i1)];
        TS = [TS ts];
        TS_Idx = [TS_Idx ts_idx];
        
        %P0S = [P0S p_st];
        %PC_A = [PC_A pca(:)];
    end    
end


%=================================================
[t_opt_idx sply_idx]= sort(TS_Idx); % Sorted best shooting time
n = length(TS);

PairSet = [Ply0_NM(:) Ply1_NM(:)];
player_leg = [];
y = zeros(length(t),1);
y1 = y(t_opt_idx);
t1 = t(t_opt_idx);

%=================================================

figure 
%---- Graph setting
ax = gca;
ax.XLim = [t(1) t(max(TS_Idx))*1.2];
ax.YLim = [-0.2 0.4];
%------------------

if shoot_suc == 0
    %YLbe = ['Af'];
    Titl = ['Battle fields after failed shooting (s:' num2str(Ply_nm0(shoot_target_idx(1))) ': t:' num2str(Ply_nm0(shoot_target_idx(2))) ')'];
else
    %YLbe = ['Shooting Status: Success'];
    Titl = ['Battle fields after successful shooting (s:' num2str(Ply_nm0(shoot_target_idx(1))) ': t:' num2str(Ply_nm0(shoot_target_idx(2))) ')'];
end
%Titl = ['Battle field after shooting (shooting player-' num2str(Ply_nm0(shoot_target_idx(1))) ': target player-' num2str(Ply_nm0(shoot_target_idx(2))) ')'];



hold on
%title ('Best shooting moments of pairwise players');
title (Titl);
xlabel(['Time (t > ' num2str(t0s, '%2.2f') ')']);
%ylabel(YLbe);

grid on

for i1 =1:n
    t0 = t(t_opt_idx(i1));
    i3 = sply_idx(i1);

    
    ply0 = Ply0_NM(i3);
    ply1 = Ply1_NM(i3);
    %ply0 = PS1(i3);
    %ply1 = PS2(i3);
    y0 = y1(i3);

    if t0>=t0s %---------------------------------------
        if i1<n 
            t1 = t(t_opt_idx(i1+1));
            t0;        
            if t1 ~= t0             
                plot(t0, y0+0.05,'v','MarkerSize',10,'MarkerFaceColor',[0.9/(3*i1),0.9/i1,0.9/(10-i1)]);
                eachply = ['PairSet-(' num2str(ply0) ',' num2str(ply1) ') @ ' num2str(t0, '%2.2f')];
                player_leg = [player_leg; eachply];
            end
        else
            plot(t0, y0+0.05,'v','MarkerSize',10,'MarkerFaceColor',[0,0,0]);
        
            eachply = ['PairSet-[' num2str(ply0) ',' num2str(ply1) '] @ ' num2str(t0, '%2.2f')];
            player_leg = [player_leg; eachply];
        end
    end
    
end
plot(t,y,'b','linewidth',2);
legend (player_leg,'Location','northeast');
hold off