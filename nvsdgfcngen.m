function [ SPS ] = nvsdgfcngen(varargin)
% Generating the probability functions of players (up to 10)
%
% Usage:
%	[SuccessFunction (SF)] = nvsdgfcngen(TimeLength, Player, Scale, SaveOpt)
%
% Output: SPS (Success Prob. Structre)
%   SPS(player).TimeEnd: End time of the function
%   SPS(player).FunctionType: Function Type (1 ~ 10)
%   SPS(player).ab: the parameters (a & b) of each function 
%   SPS(player).fcn(t): the function of a success probability 
%
%-- Function Types -----------------------------
%  f0(1).fcn = @(t,a,b) a*t^2 + b;        %--------- Type 1
%  f0(2).fcn = @(t,a,b) a*t^3 + b;        %--------- Type 2
%  f0(3).fcn = @(t,a,b) a*exp(t) + b;     %--------- Type 3 
%  f0(4).fcn = @(t,a,b) exp(a*t) + b;     %--------- Type 4
%  f0(5).fcn = @(t,a,b) a*t + b;          %--------- Type 5
%  f0(6).fcn = @(t,a,b) a*t^(1/2) + b;    %--------- Type 6  
%  f0(7).fcn = @(t,a,b) a*t^(1/3) + b;    %--------- Type 7  
%  f0(8).fcn = @(t,a,b) a*t^(1/4) + b;    %--------- Type 8
%  f0(9).fcn = @(t,a,b) a*sqrt(t) + b;    %--------- Type 9
%  f0(10).fcn = @(t,a,b) sqrt(a*t) + b;   %--------- Type 10
%------------------------------------------------
%
% Input:
%   TimeLength : Time duration of a function
%   Player: Number of player (default = 9)
%   Scale: Scale of time duction (default = 0.01)
%   SaveOpt: Saving the generated functions of players [OFF: 0, ON: 1]
%
% Note:
%   - This function is generating functions of N players
%   - The number of players should be up to 10
%   - This function is generating functions of N players
%   - Save option is added (default = OFF)
%	
% Made by Amang Kim [v0.3 || 8/14/2020]


%------------{'TimeLength', 'Player', 'Scale', 'SaveOpt'}
inputs={'TimeLength', 'Player', 'Scale', 'SaveOpt'};
Player = 9;
Scale = 1/100;
SaveOpt = 0;

for n=1:nargin
    if(~isempty(varargin{n}))
        eval([inputs{n} '=varargin{n};'])
    end
end
%-----------------------------------------------

t_max = TimeLength;
n = Player;
epsilon =  Scale;


ab = [];
fi = [];
b = [];
%fi = ceil(rand(1,n)*n);
fi = ceil(rand(1,n)*10);
%   b = rand(1,n)/2;

fun_indx = fi;

%----------------- Function Type I
syms t 
f0(1).fcn = @(t,a,b) a*t^2 + b;        %--------- Type 1
f0(2).fcn = @(t,a,b) a*t^3 + b;        %--------- Type 2
f0(3).fcn = @(t,a,b) a*exp(t) + b;     %--------- Type 3 
f0(4).fcn = @(t,a,b) exp(a*t) + (b-1); %--------- Type 4
f0(5).fcn = @(t,a,b) a*t + b;          %--------- Type 5
f0(6).fcn = @(t,a,b) a*t^(1/2) + b;    %--------- Type 6  
f0(7).fcn = @(t,a,b) a*t^(1/3) + b;    %--------- Type 7  
f0(8).fcn = @(t,a,b) a*t^(1/4) + b;    %--------- Type 8
f0(9).fcn = @(t,a,b) a*sqrt(t) + b;    %--------- Type 9
f0(10).fcn = @(t,a,b) sqrt(a*t) + b;   %--------- Type 10
%-----------------

a0 = 0;
a_set = [];

for i = 1:n
    j = fi(i);
    %b0 = rand(1)/2;
    b0 = rand(1)*.1;
    leq = f0(j).fcn;
    
    syms a
    a=solve(leq(t_max, a, b0)==1,a);
    
    f1(i).PlayerIndex = i;
    
    a0 = double(a);    
    f1(i).TimeEnd = t_max;
    f1(i).FunctionType = j;
    f1(i).ab = [a0 b0];
    f1(i).fcn = @(t) leq(t,a0,b0);
    
    a_set = [a_set a0];
    b = [b b0];
    
end

ab = [a_set; b];
SPS = f1;

if SaveOpt == 1
    fprintf(['The generated success probability fuctions are saved................ \n \n']);
    save(['spfcn_' num2str(n) '_players_amg.mat'], 'SPS');
end


end
