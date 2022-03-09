
%% How to operate with multidimensional arrays (Einstein summation)?
%% https://www.mathworks.com/matlabcentral/answers/371283-how-to-operate-with-multidimensional-arrays-einstein-summation
% A=rand(3,4,2,2)
% B=rand(2,2)
%    
% C=reshape(A,12,4)*B(:); 
% C=reshape(  C   ,3,4);

% A=rand(3,4,2,2,6,5); B=rand(2,2,7,8);
% Ap=permute(A,[1,2,5,6,3,4]); 
% Apr=reshape(Ap,[],4); Br=reshape(B,4,[]);
% C=reshape(Apr*Br,[3,4,6,5,7,8]);
% 