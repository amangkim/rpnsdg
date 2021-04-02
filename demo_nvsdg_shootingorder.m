% demo_nvsdg_shootingorder
% nvsdg_shootingorder_demo
% Shooting order demo for 5 players


clear all;
nvsdg_demo_setup;

SP = load (FileName);
t = SP.Time;
sps0 = SP.SucPro;


Ply_nm = [1:5];
Bul = [1 1 1 1 1];


ply_len = length(Ply_nm);
sps = sps0*diag(Bul);
Ply_idx  = [1:ply_len];

PairSet = [];
PS1 = [];
PS2 = [];
TS_idx = [];
TStar = [];

for i0 = 1:ply_len

    pair0 = Ply_nm(i0);
    %B = findbestshooting(sps, t, i0,[],Ply_nm);
    B = nvsdgbestshooting(sps,t,i0,Bul,[],ply_nm);
    tstar_idx = B.FirstTarget(3);

    pair2 = B.ShtTgt_nm(1);
    pair2 = B.ShtTgt_nm(2);
    
    TS_idx = [TS_idx tstar_idx];        
    TStar = [TStar t(tstar_idx)];
    PS1 = [PS1 pair0];
    PS2 = [PS2 pair2];
    

end


%=================================================
n = length(PS1);
PairSet = [PS1(:) PS2(:)];
player_leg = [];

y = zeros(length(t),1);
[t_opt_idx sply_idx]= sort(TS_idx);
y1 = y(t_opt_idx);
t1 = t(t_opt_idx);


figure 
%---- Graph setting
ax = gca;
ax.XLim = [t(1) t(max(TS_idx))*1.2];
ax.YLim = [-0.2 0.4];
%------------------

hold on
title ('Best shooting moments of pairwise players');
xlabel('Time');
grid on

for i1 =1:n
    t0 = t(t_opt_idx(i1));
    i3 = sply_idx(i1);

    ply0 = PS1(i3);
    ply1 = PS2(i3);
    y0 = y1(i3);


    %-----------------
    %plot(t0, y0+0.05,'v','MarkerSize',10,'MarkerFaceColor',[0.9/(3*i1),0.9/i1,0.9/(10-i1)]);
    %eachply = ['PairSet-(' num2str(ply0) ',' num2str(ply1) ') @ ' num2str(t0, '%4.2e')];
    %player_leg = [player_leg; eachply];    
    %-----------------
    
    if i1<n
       t1 = t(t_opt_idx(i1+1));
       t0;        
       if t1 ~= t0             
            plot(t0, y0+0.05,'v','MarkerSize',10,'MarkerFaceColor',[0.9/(3*i1),0.9/i1,0.9/(10-i1)]);
            eachply = ['PairSet-(' num2str(ply0) ',' num2str(ply1) ') @ ' num2str(t0, '%2.2f')];
            player_leg = [player_leg; eachply];
       end
    else
        plot(t0, y0+0.05,'v','MarkerSize',10,'MarkerFaceColor',[0.9/(3*i1),0.9/i1,0.9/(10-i1)]);
        eachply = ['PairSet-[' num2str(ply0) ',' num2str(ply1) '] @ ' num2str(t0, '%2.2f')];
        player_leg = [player_leg; eachply];
    end
    
end
plot(t,y,'b','linewidth',2);
legend (player_leg,'Location','northeast');
hold off


%legend(player_leg,'Location',LPo);
%------------------
%hold on
%plot(t1, y1+0.05,'rv','MarkerSize',8,'MarkerFaceColor','r');
%plot(t,y,'k');
%hold off
%------------------
%=================================================