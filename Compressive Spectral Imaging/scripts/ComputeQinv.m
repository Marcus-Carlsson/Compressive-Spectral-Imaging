function [T, A] = ComputeQinv(Q, rho)
    [M, N, L] = size(Q, 1:3);
    e = ones(M, N);
    R = zeros(size(Q));
    T = zeros(size(Q));
    E = zeros(size(Q));
    
    for t = 1:L
        E(:, :, t, t) = e;
    end

    R = rho * E + Q;
    A = rho * E + Q;
    T = E;

    for t = 1:L
        Rtt = R(:, :, t, t);

        % this divides the tth row with r_tt
        for s = 1:L
            R(:, :, t, s) = R(:, :, t, s) ./ Rtt;
            T(:, :, t, s) = T(:, :, t, s) ./ Rtt;
        end
        
        % this withdraws a suitable multiple of the tth row from the remaining 
        for t1 = t + 1:L
            Rt1t = R(:, :, t1, t);
            for s = 1:L
                R(:, 1:N + t - t1, t1, s) = R(:, 1:N + t - t1, t1, s) - Rt1t(:, 1:N + t - t1) .* R(:, t1 - t + 1:N, t, s);
                T(:, 1:N + t - t1, t1, s) = T(:, 1:N + t - t1, t1, s) - Rt1t(:, 1:N + t - t1) .* T(:, t1 - t + 1:N, t, s);
            end

        end

    end
    
    %this piece does the final "upper triangular" elimination    
    for s = L:-1:2
        for t = s - 1:-1:1
            for s1 = 1:L
                T(:, s - t + 1:N, t, s1) = T(:, s - t + 1:N, t, s1) - R(:, s - t + 1:N, t, s) .* T(:, 1:N + t - s, s, s1);
            end

        end

    end
