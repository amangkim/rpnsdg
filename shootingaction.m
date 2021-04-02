function [NSucPro NPlySet] = shootingaction(varargin)

%-----------------------------------------------
inputs={'SucPro', 'PlayerSet', 'shooter_target_idx', 'shootresult','DispOtp'};
PlayerSet = [];
shooter_target_idx = [];
shootresult = 1;
DispOtp = 1;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

[dum n_ply] = size(SucPro);

if isempty(PlayerSet)
    PlayerSet = [1:n_ply];
end


if isempty(shooter_target_idx)
    shooter_target_idx = [1 2];
end

%if isempty(Bullet)
%    Bullet = ones (n_ply,1);    % Fully loaded
%end

sps0 = SucPro;
sht_idx = shooter_target_idx(1);
tgt_idx = shooter_target_idx(2);

Ply_sht = PlayerSet(sht_idx);
Ply_tgt = PlayerSet(tgt_idx);

%-----------------------
NPlySet = [];
NSucPro = [];
%-----------------------
sps0(:,sht_idx)=0;

for i = 1:n_ply
    sp = sps0(:,i);
    ply = PlayerSet(i); 
    if tgt_idx ~= i
        NSucPro = [NSucPro sp];
        NPlySet = [NPlySet ply];
    end
end

if shootresult ~= 1
	NSucPro = sps0;
	NPlySet = PlayerSet;    
end

%N.SucPro = NSucPro;
%N.PlySet = NPlySet;
%NewSet = N;

end