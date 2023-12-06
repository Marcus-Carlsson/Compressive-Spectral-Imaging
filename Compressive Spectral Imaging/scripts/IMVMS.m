function y = IMVMS(Q, d)
%this is an image-matrix vector multiplicator with shifts, i.e. it executes formula (7) in the paper
[M, N, L] = size(Q, 1:3);
y = zeros(M, N, L);
for k = 1:L
    for l = 1:k
        y(:, 1:N + l - k, k) = y(:, 1:N + l - k, k) + Q(:, 1:N + l - k, k, l) .* d(:, k - l + 1:N, l);
    end
    
    for l = k + 1:L
        y(:, l - k + 1:N, k) = y(:, l - k + 1:N, k) + Q(:, l - k + 1:N, k, l) .* d(:, 1:N - l + k, l);
    end

end