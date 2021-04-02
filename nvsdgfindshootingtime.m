function BSTM = nvsdgfindshootingtime(varargin)
% Finding the best shooting of n-players
% BSTM (Best Shooting Time Map)
%
% Usage:
%	[BSTM] = nvsdgfindshootingtime(SucessProb, Time, Player, Bullet, DispOtp)
%
% Output: BSTM (Best Shooting Time Matrix)
%   BTSM.ShootingMap : Shooting Map of Players;
%   +----------------------------------------------------------------------+
%   | Player | Shooting Order | Time Index | Shooting Time | Success Prob. |
%   +----------------------------------------------------------------------+
%
%   BSTM.Player : Players who join the game
%   BSTM.ShootPlayersOrdered: Shooting order based on success probability
%   BSTM.TimeIndexOrdered: Time index which sorted by shooting time
%   BSTM.ShootTimeOrdered: Sorted shooting time
%   BSTM.SuccessProbOrdered: Sucess Prob. which sorted by shooting time
%
% Input:
%   SucessProb  : The set of success Probability [time-by-player]
%   Time        : Time duration with the range [Start, End]
%   Player      : Player index who join the game
%   DispOpt     : Diplay option (ON-1, OFF-0)
%
% Note:
%   - Required m-codes : nvsdgfailprod
%   - Defult display option : ON
%	
% Made by Amang Kim [v0.25 || 1/04/2021]

%-----------------------------------------------
inputs={'SucPro', 'Time', 'Player' ,'Bullet', 'DispOtp'};
Time = [];
Player = [];
Bullet =[];
DispOtp = 1;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

sps0 = SucPro;
[t0_len pl0] = size(sps0);

%----------------------------------------
if isempty(Player)
    n_player = pl0;
    Player = [1:n_player];
else
    p_len = length(Player)
    if p_len ~= pl0
        fprintf ('\n The number of players are DIFFRENT between players and a success probability set.\n Please, press [ENTER] Key......\n');
        p_len
        length(Player)
        pause;
    end
    n_player = min(p_len,pl0);    
end

PlayerSet = Player([1:n_player]);

if isempty(Time)
    t = [0:t0_len-1];
else
    t = Time;    
end

%---------------------
if isempty(Bullet)
    Bullet = ones (p_len,1);    % Fully loaded
end
sp = sps0*diag(Bullet);
%[t0_len pl0] = size(sp);
%---------------------


epsilon = 1/100;
pc = nvsdgfailprod (sp);
%----------------------------------------

player_nm = [];
t_val = [];
sp_val = [];
time_idx = [];


for i = 1:n_player
    p0 = sp(:,i);
    pc_a = pc(:,i);
    
    %opt_idx = min(find(abs(p0-pc_a)<=epsilon)); %----- v0.1
    %---------- v0.25
    opt_idx0 = find(abs(p0-pc_a)<=(epsilon));
    opt_idx = floor(mean(opt_idx0));    
    %----------

    opt_val = [t(opt_idx) p0(opt_idx)];
    player_nm = [player_nm PlayerSet(i)];
    
    if isempty(opt_idx)
        p_fl = p0-pc_a;
        if p_fl >= 0
            opt_idx = 1;
        else
            opt_idx = length(t);
        end
    end
    
    p01 = p0(opt_idx);
    
    %----- v0.25
    if p0(1) == 0
        opt_idx=length(t);    
    end
    %-----
    
    t1 = t(opt_idx);
    t_val = [t_val t1];
    sp_val = [sp_val p01];
    time_idx = [time_idx opt_idx];        
        
end


[t_sort,SO0]  = sort(t_val);
SO1 = zeros(1,n_player);
SO1(SO0) = player_nm([1:n_player]);

%sm = [player_idx; SO1; time_idx; t_val; sp_val]';
sm = [player_nm; SO1; time_idx; t_val; sp_val]';

if DispOtp == 1
    %Cont1 = '\n | Player | Shooting OBrder | Time Index (3)| Shooting Time (4)| Success Prob. (5)|';
    Cont1 = '\n  || P_nm  |   Ord   |   Idx    |   t^*   |  SPr  ||';
    Cont2 = '\n  ||  [1]  |   [2]   |   [3]    |   [4]   |  [5]  ||';
    Ln =    '\n  ++-------+---------+----------+---------+-------++'; 
    fprintf([Ln Cont1 Cont2 Ln]);    
    sm
end

% ShootingMap
%| Player | Shooting Order | Time Index | Shooting Time | Success Prob. |

%----------------------------
B.Player = sm(:,1)';
B.ShootingMap = sm;
%B.ShootPlayersOrdered = SO0; ---- v0.1
B.ShootPlayersSq = SO0;
B.ShootPlayersOrdered = player_nm(SO0);
B.TimeIndexOrdered = sm(SO0,3)';
B.ShootTimeOrdered = sm(SO0,4)';
B.SuccessProbOrdered = sm(SO0,5)';
%B.SuccessProbSet = sp;
%----------------------------

BSTM = B;

end

