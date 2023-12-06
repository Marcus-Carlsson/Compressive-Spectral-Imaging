function inverse = blockDiagonal(H1H1t, rho, N, L, shots_m)
% Block diagonal
inverse = speye(shots_m * N * (N + L - 1)) - speye(shots_m * N * (N + L - 1));
n_blck = N;

blocks  = 1;
for i = 1:n_blck / blocks
    sz_block = (1 + (i - 1) * blocks * shots_m * (N + L - 1)):(i * blocks * shots_m * (N + L - 1));
    inverse(sz_block, sz_block) = pinv(full(H1H1t(sz_block, sz_block) + rho * speye(blocks * shots_m * (N + L - 1))));
end
