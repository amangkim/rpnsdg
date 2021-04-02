function [ts, ts_idx, p_star, pca] = singlepairwiseshooting(varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%-----------------------------------------------
inputs={'SucPro', 'Time', 'Ply_idx', 'DispOtp', 'Ply_nm'};
Time = [];
Ply_idx = [1 2];
Ply_nm = [];
DispOtp = 1;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------
t = Time;
epsilon = 1/100;

if isempty (Ply_nm)
    Ply_nm = [1:max(Ply_idx)];
end

ply0_idx  = Ply_idx(1);
ply1_idx  = Ply_idx(2);
ply_i = Ply_nm (ply0_idx);
ply_j = Ply_nm (ply1_idx);

sps = SucPro;
p0 = sps(:, ply0_idx);
p1 = sps(:, ply1_idx);
pc_a = ones(length(p0),1)-p1;

opt_idx0 = find(abs(p0-pc_a)<=(epsilon));
opt_idx = floor(mean(opt_idx0));    

%t(opt_idx)
%p0(opt_idx)

opt_val = [t(opt_idx) p0(opt_idx)];


if DispOtp == 1 %-----------------------------------------
    Ply0 = ply_i;
    Ply1 = ply_j;
    
    figure
    hold on
    grid on
    title (['Best shooting moment of Player-' num2str(Ply0)]);
    %title ('Finding optimal timing t*');
    ylabel ('Shooting chance [0,1]');
    xlabel ('Time');

    plot (t, p0, 'b', 'linewidth',1.1);
    plot(t, pc_a, 'c', 'linewidth',2);
    plot(t(opt_idx), p0(opt_idx)+0.05,'rv','MarkerSize',8,'MarkerFaceColor','r');
    Ply0Str = ['Player-' num2str(Ply0)];
    Ply1Str = ['Player-' num2str(Ply1) ' fails'];
    OptPly0 = ['Optimal @ ' num2str(opt_val(1))];
    legend(Ply0Str,Ply1Str, OptPly0,'Location','northwest');
    hold off
end %-----------------------------------------


ts = t(opt_idx);
ts_idx = opt_idx;
p_star = p0(opt_idx);
pca = pc_a;
end

