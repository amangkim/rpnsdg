function [SPM] = nvsdgmatrixgen(varargin)
% Generating the matrix form of success probability
%
% Usage:
%	[SPM] = nvsdgmatrixgen(Player, Duration, Scale)
%
% Output: SPM (Success Prob. Matrix)
%   SPM.TotalPlayers : Total number of players
%   SPM.Time         : Time sequence [du0 du1] with the scale
%   SPM.FcnIdx       : Function index
%   SPM.SucPro       : Matrix form success probaility [t-by-p]
%
% Input:
%   Player      : Number of player (default = 9)
%   Duration    : Time duration [Start End]
%   Scale       : Scale of time duction (default = 0.1)
%
% Note:
%   - Required m-file: nvsdgfcngen
%   - This function is generating a time-by-player matrix
%   - The number of players should be up to 10
%   - This function is generating functions of N players
%   - Saving Option is added (default = OFF)
%	
% Made by Amang Kim [v0.2 || 8/25/2020]


%------------{'Player', 'Duration', 'Scale'}
inputs={'Player', 'Duration', 'Scale', 'SaveOpt'};
Player = 5;
Duration = [0 30];
Scale = 1/10;
SaveOpt = 0;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

y = [];
a_b = [];
FcnIdx = [];

d0 = Duration(1);
d1 = Duration(2);
n_player = Player;
epsilon = Scale;

sp = nvsdgfcngen(d1,n_player,epsilon,0);

%epsilon
syms t

t = [d0:epsilon:d1]';
l_t = length(t);


for i = 1:n_player
    
    fcntype = sp(i).FunctionType;
    
    
    for j = 1:l_t
        t0 = t(j);
        y1 = sp(i).fcn(t0);
        y(j,i) = y1;
    end
    %fcnab = [sp(i).FunctionType; sp(i).ab(1); sp(i).ab(2)];
    %Fcn_a_b = [Fcn_a_b fcnab];
    ab = [sp(i).ab(1); sp(i).ab(2)];
    a_b = [a_b ab];
    FcnIdx = [FcnIdx fcntype];
        
    
end

%SP = y;
%-----------------------------------------
SPM.TotalPlayers = n_player;
SPM.Scale = epsilon;
SPM.Time = t;
SPM.FcnIdx = FcnIdx;
SPM.SucPro = y;
%-----------------------------------------

if SaveOpt == 1
    durstr = num2str(d1);
    %SaveName  = ['spset_' num2str(n_player) '_ply_' durstr '_tm_VSDG_amg.mat'];
    fprintf('\n The generated success probability set has been saved................ \n');
    SaveName  = ['nvsdg_successprob_set_amg.mat'];
    save(SaveName,'-struct','SPM');
end



end

