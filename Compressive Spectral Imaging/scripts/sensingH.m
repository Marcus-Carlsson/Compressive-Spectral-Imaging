function y = sensingH(hyperimg, gdmd)
[M, N, L] = size(hyperimg);
S = size(gdmd, 3);
y = zeros(M, N + L - 1, S);

% % (Commented) this is image-matrix vector multiplicator, which executes
% % equation (2) from paper
% for j = 1:S
%     temp = zeros(M, N + L - 1);
%     for k = 1:L
%         temp(:, k:N + k - 1) = temp(:, k:N + k - 1) + hyperimg(:, :, k) .* gdmd(:, :, j);
%     end
%     y(:, :, j) = temp;
% 
% end

% fast implementation
y_noshift = hyperimg .* reshape(gdmd, M, N, 1, S);
for k = 1:L
    y(:, k:N + k - 1, :) = y(:, k:N + k - 1, :) + squeeze(y_noshift(:, :, k, :));
end
