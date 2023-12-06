function [T, A] = ComputePinv(P, rho)
[M, NplusLminus1, S] = size(P, 1:3);
e = ones(M, NplusLminus1);
E = zeros(size(P));

for t = 1:S
    E(:, :, t, t) = e;
end

R = rho * E + P;
A = rho * E + P;
T = E;

% we first work the lower diagonal rows, just as in standard gaussian
% elimination
for t = 1:S
    Rtt = R(:, :, t, t);

    % this divides the t'th row with r_tt
    for s = 1:S
        R(:, :, t, s) = R(:, :, t, s) ./ Rtt;
        T(:, :, t, s) = T(:, :, t, s) ./ Rtt;
    end

    % this withdraws a multiple of the t'th row from the remaining 
    for u = t + 1:S
        % this is the multiple in question
        Rut = R(:, :, u, t);
        % and here comes the elimination step
        for s = 1:S
            R(:, :, u, s) = R(:, :, u, s) - Rut .* R(:, :, t, s);
            T(:, :, u, s) = T(:, :, u, s) - Rut .* T(:, :, t, s);
        end
    end
end

% this piece does the final "upper triangular" elimination    
for s = S:-1:2
    for t = s - 1:-1:1
        for s1 = 1:S
            T(:, :, t, s1) = T(:, :, t, s1) - R(:, :, t, s) .* T(:, :, s, s1);
        end
        R(:, :, t, s) = R(:, :, t, s) - R(:, :, t, s) .* R(:, :, s, s);
    end
end
