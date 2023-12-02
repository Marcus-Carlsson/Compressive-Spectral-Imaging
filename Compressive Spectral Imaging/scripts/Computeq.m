function q = Computeq(f, L)
    [M, N, S] = size(f);
    q = zeros(M, N, L, L);
    % we first evaluate the first row of q's, so k=1 below
    for l = 1:L
        % This loop corresponds to the formula above (8), i.e. sum_{s=1}^S
        % S_{l-1}(f_s).*f_s
%         for s = 1:S
%             q(:, l:N, 1, l) = q(:, l:N, 1, l) + f(:, 1:N - l + 1, s) .* f(:, l:N, s);
%         end

        % emmanuel version
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

%     % emmanuel version
% 
%     % all different images
% 
%     images = zeros(M, N, L);
% 
%     for l = 1:L
%         aux = zeros(M, N);
%         aux(:, l:end) = sum(f(:, 1:end - l + 1, :) .* f(:, l:end, :), 3);
%         images(:, :, l) = aux;
% 
%     end
% 
%     % compute q
% 
%     q1 = zeros(M, N, L, L);
% 
%     % indices = logical(ones(M, N, L, L) .* reshape(eye(L), 1, 1, L, L));
%     % q1(indices) = repmat(images(:, :, 1), 1, 1, L);
% 
% 
%     % diagonal
% 
%     for l = 1:L
%         q1(:, :, l, l) = images(:, :, 1);
%     end
% 
%     for k = 1:L
%         for l = k:L
% 
%         end
%     end



