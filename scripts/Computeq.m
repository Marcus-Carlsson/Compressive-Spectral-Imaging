function q = Computeq(f, L)
[M, N, S] = size(f);
q = zeros(M, N, L, L);
% we first evaluate the first row of q's, so k=1 below
for l = 1:L
    % (Commented) This loop corresponds to the formula above (9), i.e. sum_{s=1}^S
    % S_{l-1}(f_s).*f_s
    % for s = 1:S
    %     q(:, l:N, 1, l) = q(:, l:N, 1, l) + f(:, 1:N - l + 1, s) .* f(:, l:N, s);
    % end

    % fast implementation
    q(:, l:N, 1, l) = sum(f(:, 1:N - l + 1, :) .* f(:, l:N, :), 3);
end

% We now compute remaining indices using the symmetry remarks at
% the endo of section 3.4
for k = 1:L
    for l = k:L
        % This line uses the Teoplitz structure to get the upper
        % diagonal elements
        q(:, :, k, l) = q(:, :, 1, l - k + 1);
        % And this line the formula q_{l,k}=S_{k-l}(q_{k,l}),
        % to get the lower diagonal elements
        q(:, 1:N - l + k, l, k) = q(:, l - k + 1:N, k, l);
    end
end


