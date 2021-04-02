% nvsdg_simul
clear all;
nvsdg_demo_setup;

%++--------+---------+---------+-------++
%|| P1_idx |   Tgt   |   t^*   |  SPr  ||
%||  [1]   |   [2]   |   [3]   |  [4]  ||
%++--------+---------+---------+-------++
%  4.0000    2.0000    1.5000    0.1085
%  5.0000    2.0000    1.7000    0.0378
%  3.0000    2.0000    2.1000    0.1485
%  2.0000    3.0000    2.2000    0.3005
%  1.0000    2.0000    6.6000    0.2490

SP = load (FileName);
t = SP.Time;
sps0 = SP.SucPro;

ply = [1:4];
Bul = [1 1 1 0];

ply = [1 3:5];
Bul = [1 1 0 1];


sps = sps(:,ply);
n_players =length (ply);

pl_len = n_players;

player_leg = [];
p1 = ply_nm;

%singlepairwiseshooting(varargin)

%B = nvsdgfindshootingtime(sps,t,ply,Bul,0);
B1 = nvsdganalyzer(sps,t,p1,bul,1);
sps = B1.SuccessProbSet;

ply_idx = B1.ShootSq_Idx(:);
btm = B1.ShootTargetTimeMap;
SM = [ply_idx B1.tstar_Index(:) btm(:,3) btm(:,4) btm(:,2) btm(:,1)];  

B2 = nvsdgfindmixedoptimal(SM,sps,t,Bul,2,1);
%inputs={'ShootingMap', 'SuccessProb', 'Time', 'Bullet', 'DispOpn'};
%B2 =nvsdgfirstshootoptimal(SM,sps,t,Bul,1);

pl_len = SP.TotalPlayers;
drawshootingorder_ms
%-----------------------------------

%============================================

sps0 = sps;
Bullet = Bul;
sps = sps0*diag(Bullet);
n_player = length(ply);

%==========================
Ply0 = 2;
Ply = ply(Ply0);
pc = nvsdgfailprodgen (sps);
epsilon = 1/100;


p0 = sps(:,Ply0);
pc_a = pc(:,Ply0);

opt_idx0 = find(abs(p0-pc_a)<=(epsilon));
opt_idx = floor(mean(opt_idx0));
opt_val = [t(opt_idx) p0(opt_idx)]

%-----------------------------------------
figure
hold on
grid on
title ('First shooter optimal timing t*');
ylabel ('Shooting chance [0,1]');
xlabel ('Time');

plot (t, p0, 'b', 'linewidth',1.1);
plot(t, pc_a, 'c', 'linewidth',2);
plot(t(opt_idx), p0(opt_idx)+0.05,'rv','MarkerSize',8,'MarkerFaceColor','r');
Ply0Str = ['Player ' num2str(Ply)];
OptPly0 = ['Optimal @ ' num2str(opt_val(1))];
legend(Ply0Str,'All players fail', OptPly0,'Location','northwest');
hold off
%-----------------------------------------

%nvsdg_p_simul_ms
nvsdg_q_simul_ms
%==========================

