function y = IMVM(P, b)
    %this is an image-matrix vector multiplicator, i.e. it executes formula (5) in the paper
    % ?can we write this operation avoiding the for loop?
%     S=size(P, 4);
%     y=zeros(size(P, 1:3));
%     for t = 1:S
%         for s = 1:S
%             y(:, :, t) = y(:, :, t) + P(:, :, t, s) .* b(:, :, s);
%         end
%         
%     end

    % emmanuel version - broadcasting
    
    % output = permute(P, [1 2 4 3]) .* permute(b, [1 2 4 3]);  % matrix-vector
    % y = sum(output, 4);

    % output = P .* b;  % matrix'-vector'
    [M, N, S] = size(b);
    y = sum(P .* reshape(b, M, N, 1, S), 4);
