function [ inv_v1] = inv_Block_v1( Bm1Bm1t, rho, N, L, shots_m, arch )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
if arch ==1
	inv_v1 = speye(shots_m*N*(N + L - 1)) - speye(shots_m*N*(N + L - 1)) ;    % CASSI
    n_blck = N;
elseif arch == 2 
	inv_v1 = speye(shots_m*N*(N)) - speye(shots_m*N*(N )) ;                            % patterned
    n_blck = N^2;
elseif arch == 3
	inv_v1 = speye(shots_m*N*(N)) - speye(shots_m*N*(N )) ;                            % patterned
    n_blck = N^2;    
else
    disp('error: you need to select an architecture')
end

blocks  = 1;

for i=1:n_blck/blocks
    % disp(['Block ' num2str(i) ' of ' num2str(n_blck/blocks)])
%     if i/n_blck<0.1
%     fprintf('Percentage %f \n',i/n_blck)
%     end
%     if i/n_blck>0.9
%         fprintf('Percentage %f \n',i/n_blck)
%     end    
    if arch ==1
        sz_block = (1+(i-1)*blocks*shots_m*(N + L - 1)):(i*blocks*shots_m*(N + L - 1)); %CASSI
        inv_v1(sz_block,sz_block) = pinv(full(Bm1Bm1t(sz_block,sz_block) + rho*speye(blocks*shots_m*(N + L - 1)))); %CASSI
    elseif arch == 2 || arch == 3
        sz_block = (1+(i-1)*blocks*shots_m*(1)):(i*blocks*shots_m*(1)); %patterned
        inv_v1(sz_block,sz_block) = pinv(full(Bm1Bm1t(sz_block,sz_block) + rho*speye(blocks*shots_m*(1))));     %patterned
    else
        disp('error: you need to select an architecture')
    end    
end


