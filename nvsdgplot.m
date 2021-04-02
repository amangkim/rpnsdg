function SuccProb = nvsdgplot(varargin)
% Ploting the graph of n-person versatile stochast duel game
% Enriched command of 'plot'
%
% [Usage]
%   nvsdgdisplay(X-value, Y-value set, Heading, X-Label, Y-Label)
%
% Note:
%   - Enriched command of 'plot'
%   - Position of legend [0-NW, 1-NE]
%	
% Made by Amang Kim [v0.1 || 8/14/2020]

%------------{'x', 'y_set' , 'Head' , 'x_label' , 'y_label'};
inputs={'x','y_set','Head' , 'x_label' , 'y_label', 'Lpo'};
Head = 'nVSDG plot sample by Dr. Amang Kim';
x_label = 'X-axis';
y_label = 'Y-axis';
Lpo = 0;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

t = x;
sps = y_set;

%----------------- Legend Position

if Lpo == 0
    LPo = 'northwest';
else
    LPo = 'northeast';
end


%---------------------------------    
    
[t_len n_player] = size(sps);
player_leg = nvsdgplotlegendgen(n_player);



%---- Display -------------------
figure

%---- Graph setting
ax = gca;
ax.XLim = [t(1) t(length(t))];
%ax.YLim = 

%------------------

hold on
grid on 
title (Head);
xlabel (x_label);
ylabel (y_label);
plot(t,sps);
legend(player_leg,'Location',LPo);
hold off
%--------------------------------

SuccProb = sps;

end

