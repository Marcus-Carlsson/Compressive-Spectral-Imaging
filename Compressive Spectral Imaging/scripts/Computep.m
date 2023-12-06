function P = Computep(f, L)
[M, N, S] = size(f);
P = zeros(M, N + L - 1, S, S);
for t = 1:S
    for s = t:S
        % This loop corresponds to the formula (5), i.e. sum_{l=1}^L S^Z_{l-1}(f_t).*S^Z_{l-1}(f_s)
        for l = 1:L
            P(:, l:N + l - 1, t, s) = P(:, l:N + l - 1, t, s) + f(:, :, t) .* f(:, :, s);
        end
        % Here we use the fact that the matrix is "self-adjoint", so we do not need
        % to compute lower diagonal images
        P(:, :, s, t) = P(:, :, t, s);
    end
end
