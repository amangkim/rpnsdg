%nvsdgdemosetup_ms

%nvsdg_demo_setting

% clear all

n_player = 5;
duration = 30;
epsilon = 0.1;
%epsilon = 0.01;

SamplePath = pwd;
%FileName  = ['nvsdg_successprob_set_amg.mat'];
%FileName = ['five_matrix_30mon_r02_amg.mat'];
FileName = ['five_matrix_30mon_r00_amg.mat'];



%SP = nvsdgmatrixgen(n_player, [0 duration], epsilon);
%-----------------------------------------
%SP.TotalPlayers = n_player;
%SP.Time = t;
%SP.FcnIdx = FcnIdx;
%SP.SucPro = y;
%-----------------------------------------

%PL = [1:SP.TotalPlayers];
%t = SP.Time;
%sps = SP.SucPro;
n = n_player;
ply_nm = [1:n];
bul = ones(1,n);