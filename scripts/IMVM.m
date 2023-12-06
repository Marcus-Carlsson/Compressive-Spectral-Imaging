function y = IMVM(P, b)
% (Commented) this is an image-matrix vector multiplicator, i.e. it executes formula (7) in the paper
% S = size(P, 4);
% y = zeros(size(P, 1:3));
% for t = 1:S
%     for s = 1:S
%         y(:, :, t) = y(:, :, t) + P(:, :, t, s) .* b(:, :, s);
%     end
% 
% end

% fast implementation
[M, N, S] = size(b);
y = sum(P .* reshape(b, M, N, 1, S), 4);
