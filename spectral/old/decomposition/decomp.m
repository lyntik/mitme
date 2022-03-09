
function [f, fval]=decomp(INC, ATT, Rij, D)

materials = size(ATT, 1);

% guess. (RTK)
% MAT_NUM = materials;
% DEPOS = INC' * Rij';
% ATTMEAN = sum(reshape((ATT(:, 3:27) .* repmat(INC(3:27)', MAT_NUM, 1))', 5, 5, MAT_NUM), 1) ./ repmat(sum(reshape(INC(3:27), 5, 5), 1), [1, 1, MAT_NUM]);
% L = repmat(log(sum(reshape(DEPOS(1:25), 5, 5), 1) ./ DETBINS(:, 1)'), [1 1 MAT_NUM]) ./ ATTMEAN


integrals = zeros(materials, 1);
% 
%      integrals(1) = 5;
%      integrals(2) = 0.2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


A = [];
b = [];
Aeq = [];
beq = [];
nonlcon = [];

lb = [];
ub = [];
lb = zeros(materials, 1);
ub = zeros(materials, 1);
for i = 1:size(ub, 1)
    lb(i) = 0;
    ub(i) = 5;
end

fminunc
lsqlin
%[integrals, fval, exitflag] = fmincon(@(integrals) cost(integrals, INC, D,Rij,ATT), double(integrals), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals',10000000, 'MaxIter', 100000, 'TolX', 0.0000000001, 'Display', 'None', 'Algorithm', 'active-set' ) );
[integrals, fval, exitflag] = linprog(@(integrals) cost(integrals, INC, D,Rij,ATT), double(integrals), A, b, Aeq, beq, lb, ub, nonlcon, optimset('MaxFunEvals',10000000, 'MaxIter', 100000, 'TolX', 0.0000000001, 'Display', 'None', 'Algorithm', 'active-set' ) );
%[integrals, fval, exitflag] = fminsearch(@(integrals) cost(integrals, INC,D,Rij,ATT), double(integrals), optimset('MaxFunEvals',10000000, 'MaxIter', 300, 'TolX', 0.0001, 'Display', 'none') );



f = integrals;


