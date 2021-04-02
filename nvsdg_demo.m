% nvsdg_demo
% n-person stochastic duel game demo v.0.2
%---------------------------------------------------------
clear all;
nvsdg_demo_setup
home;
disp(['SamplePath = ' SamplePath]);
disp(['Preloaded File = ' FileName]);

%------------
line1 = '-----------------------------------------------------------------------\n';
enter1 = '\n';
enter2 = '\n \n';
%------------

comm1 = '         <<<< n-person Stochastic Duel Game Demo (New) >>>>\n';
comm2 = 'The demos are designed for analyzing nVSDG by using PRE-LOADED dataset\n';
comm3 = 'Made by Amang Kim [v0.2 || 1/20/20201]\n';
demo00 = '<a href = "matlab: nvsdg_demo_p1;">0. Go to the part 1 demo menu\n</a>';
demo99 = '<a href = "matlab: nvsdg_demo;">9. Go to the pre-loaded demo menu\n</a>';
%------------


demo01 = '\t <a href = "matlab: demo_plotsucprob;">1. Ploting the success probabilities of players \n</a>';
demo02 = '\t <a href = "matlab: demo_nvsdg_singleshooting;">2. Find the best shooting time for single player\n</a>';
demo03 = '\t <a href = "matlab: demo_nvsdg_shootingorder_full;">3. Find the sequence of shooting order of players\n</a>';
demo04 = '\t <a href = "matlab: demo_nvsdgengine_p2;">4. nVSDG First Shooting Analyizer Demo\n</a>';



%---------------------------------------------------------

Comm = [enter1 line1 comm1 enter1 comm2 comm3 line1 enter1];
Menu = [demo01 demo02 demo03 demo04 enter1];

fprintf(Comm);
fprintf(Menu);
fprintf([line1 demo00 demo99 enter2]);