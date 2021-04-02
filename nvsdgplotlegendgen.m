function nvsdglegend = nvsdgplotlegendgen( Players )
% Create the legend of players for plotting
%
% [Usage] nvsdglegend = nvsdgplotlegendgen( Players )
%
% [Output] nvsdglegend : The set of lengend
% [Input]  Player      : Number of players (default = 9)
%
% [How-To-Use] legend(nvsdglegend,'Location','northwest');
%	
% Made by Amang Kim [v0.1 || 8/14/2020]

player_leg = [];
n = Players;

for l =1:n
    eachply = ['Player ' num2str(l,'%02.0f')];
    player_leg = [player_leg; eachply];      
end


% Return Value: player_leg
% Usage: legend(player_leg,'Location','northwest');
%--------------------------------

nvsdglegend = player_leg;

end

