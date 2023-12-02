function y = sensingHt(b, gdmd)
    [M, N, S] = size(gdmd);
    L = size(b, 2) - N + 1;
    % y = zeros(M, N, L);
    % for j = 1:S
    %     for k = 1:L
    %         y(:, :, k) = y(:, :, k) + b(:, k:N + k - 1, j) .* gdmd(:, :, j);
    %     end
    % 
    % end

    % emmanuel version

    y = zeros(M, N, L);
    for k = 1:L
        y(:, :, k) = y(:, :, k) + sum(b(:, k:N + k - 1, :) .* gdmd, 3);
    end

