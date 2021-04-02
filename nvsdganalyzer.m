function BSTTM = nvsdganalyzer(varargin)
% n-person Vesatile Stochastic Duel Game (nVSDG) Analyzer
% BSTTM (Best Shooting Target Time Map)
%
% Usage:
%	[BSTTM] = nvsdganalyzer(SucessProb, Time, Player, Bullet, DispOtp)
%
% Output: BSTTM (Best Shooting Target Time Map)
%   BSSTM.Player: Players who join the nVSDG
%   BSSTM.ShootingMap : Shooting-Target Map of Players;
%   +-----------------+--------------+----------+-------------+
%   | Player (sorted) | Target (k_m) |    t*    | Succ. Prob. |
%   +-----------------+--------------+----------+-------------+
%
%   BSTTM.ShootOrger = Shooting Order of players
%   BSTTM.TargetOrder = Target by sorted by shooting order
%   BSTTM.tstar_Index = Index of t*
%
% Input:
%   SucessProb  : The set of success Probability [time-by-player]
%   Time        : Time duration with the range [Start, End]
%   Player      : Player index who join the game
%   DispOpt     : Diplay option (ON-1, OFF-0)
%
% Note:
%   - Required m-codes : nvsdgfailprod, nvsdgfindshootingtime
%   - Defult display option : OFF
%   - 'Bullet' is added
%	
% Made by Amang Kim [v0.3 || 1/03/2021]

%-----------------------------------------------
inputs={'SucPro', 'Time', 'Player' ,'Bullet', 'DispOtp'};
Time = [];
Player = [];
Bullet =[];
DispOtp = 0;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

t = Time;
sps0 = SucPro;
ply = Player;
ply_len = length(Player);

%---------------------
if isempty(Bullet)
    Bullet = ones (ply_len,1);    % Fully loaded
end
sps = sps0*diag(Bullet);
%---------------------

%-------------------------------------------------------
B = nvsdgfindshootingtime(sps,t,ply,Bullet,0);
% BTSM.ShootingMap : Shooting Map of Players;
% B.Player : Players who join the game
% | Player | Shooting Order | Time Index | Shooting Time | Success Prob. |
% BTSM.ShootPlayersOrdered: Shooting order based on success probability
% B.TimeIndexOrdered: Time index which sorted by shooting time
% B.ShootTimeOrdered: Sorted shooting time
% B.SuccessProbOrdered: Sucess Prob. which sorted by shooting time
%B.Player = sm(:,1);
%B.ShootingMap = sm;
%B.ShootPlayersOrdered = SO0;
%B.TimeIndexOrdered = sm(SO0,3);
%B.ShootTimeOrdered = sm(SO0,4);
%B.SuccessProbOrdered = sm(SO0,5);
%B.SuccessProbSet
%-------------------------------------------------------
ply = B.Player;
ply_shoot = B.ShootingMap(:,2);
%shootorder = B.ShootPlayersOrdered;
shootorder = B.ShootPlayersSq;
bul = Bullet;
player_idx = [1:length(ply)];
%player_idx =ply;
t_val = B.ShootingMap(:,4);
n_player = length(player_idx);
sm = B.ShootingMap;

shootingtarget = [];
pc_set =[];
shootorder_new = [];
sft =0;
nobull_ply = [];
yesbull_ply = [];

for i2 = 1:n_player
    shoot_idx = shootorder(i2);
    bul_flag = bul(shoot_idx);
    if (bul_flag==0)
        %nbp = ply(shoot_idx);
        nbp = player_idx(shoot_idx);        
        %nobull_ply = [nobull_ply nbp];
        nobull_ply = [nobull_ply ply(nbp)];
        no_bul_play = ply(nbp);
    
    %if (bul_flag~=0)
    else    
        %j0 = ply(shoot_idx);
        j = shoot_idx;
        tau_nu = t_val(shoot_idx);
        j_t = find(t == tau_nu);    
        p0 = sps(:,j);
        p0_nu = p0(j_t);
    
        pc_set = [];
    
        for k = 1:n_player
            if j~=k
                pc = 1-sps(:,k);
                pc_nu = pc(j_t);
            else
                pc_nu =1.5;
            end
        
            pc_set = [pc_set pc_nu];
            
        %opt_idx = min(find(abs(pk-pc0)<=0.005));        
        end
        ybp = player_idx(shoot_idx);
        %---- ply(ybp)
        yesbull_ply = [yesbull_ply ply(ybp)];
    end
    
	[dd sh_pl] = min(pc_set);    
	%shootingtarget = [shootingtarget ply(sh_pl)];
    shootingtarget = [shootingtarget sh_pl];

end
%shootingtarget = unique(shootingtarget, 'first')
sm = B.ShootingMap;
%ply_shoot
%bul
%nobull_ply
%yesbull_ply 
% | Player | Shooting Order | Time Index | Shooting Time | Success Prob. |

    %bt10 = B.ShootPlayersOrdered(:);
    bt10 = B.ShootPlayersSq(:);
    bt2k0 = shootingtarget(:);    

bul0 = bul;
OffSet = 0;
if (sum(bul)<1 && length(ply)<3)
    sur_idx = [yesbull_ply nobull_ply(1)]; 
	Player = ply(sur_idx)';
    bt1 = sur_idx';
    bt2k = zeros(length(sur_idx),1);
    bul = zeros(1,length(sur_idx));
    %sm=sm(sur_idx,:)    
else
    bt1 = bt10;
    bt2k = bt2k0;
    OffSet = 1;
end

%Shooting-Target Map | ShootOrder | Target |
%diag(bul)*ply_shoot


stm = [bt1 bt2k];


% | Shooting Order | Next Shooter (i_(m+1)) | Next Target (km) | Shooting Time | Success Prob. |
% | Shooting Order | Next Target (km) | Shooting Time | Success Prob. |
%bt2i = [bt1(2:length(bt1)); 0];
%bt1
bt3 = sm(bt1,4);
bt4 = sm(bt1,5);

%btm = [bt1 bt2i bt2k bt3 bt4 bt5];
if OffSet == 1
    bt11=ply(bt1)';
    bt2k1= ply(bt2k)';
    btm = [bt11 bt2k1 bt3 bt4];
    %B1.ShootTargetTimeMap = btm;
    %OffSet == 0;
    %bul(bt1)
end

tstar_idx = sm(bt1,3);
B1.Players = ply;
B1.Bullet = Bullet;

B1.ShootSq_Idx = bt1';
B1.SortedShooter = ply(bt1);
B1.SortedBullet = bul(bt1);
B1.SortedTarget = ply(bt2k);
B1.tstar_Index = tstar_idx';
B1.SuccessProbSet = sps;
%ShootPlayersSq
B1.ShootTargetTimeMap = btm;

B1.ShootOrder = bt1'; %---- v0.1
%B1.ShootOrder = B.ShootPlayersOrdered(:);
%B1.Target_Player = bt2k';

%B1.ShootOrger = sort(ply(bt1));
%bul0
%B1.ShootOrger = bt1'*diag(bul0);
%B1.NewPlayer = ply(bt1);
%B1.NewBullet = bul;


if DispOtp == 1
    %Cont1 = '\n || [1] Player (sorted) | [2] Target (k_m) | [3] t* | [4] Success Prob. ||';    
    Cont1 = '\n  || Shooter |   Tgt   |   t^*   |  SPr  ||';
    Cont2 = '\n  ||   [1]   |   [2]   |   [3]   |  [4]  ||';
    Ln =    '\n  ++---------+---------+---------+-------++'; 
    fprintf([Ln Cont1 Cont2 Ln]);
    btm
end


BSTTM = B1;

end

