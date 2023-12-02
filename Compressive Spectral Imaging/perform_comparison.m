function result = perform_comparison(M, N, L, S)

%% CAs

CAs = double(rand(M, N, S) <= 0.5);

%% Traditional approach

H = [];

for i = 1:S
    CA = repmat(CAs(:, :, i), 1, 1, L);
    [Ad, ~, ~, ~] = Atranspose(M, N, L, CA, M * (N + L - 1)); % H matrix
    H = [H; Ad];
end

rhoI_HHstar = speye(size(H, 1)) + H * H';
rhoI_HstarH = speye(size(H, 2)) + H' * H;

%% Proposed method

P = Computep(CAs, L);
Q = Computeq(CAs, L);

%% Speed Comparison

rho = 1;

%% Block-Diagonal

disp('--------------------------------------------')
disp('Computing Block-Diagonal ...')
disp('--------------------------------------------')

[R1, ~] = CASSI_R([N N L]);
[R2, ~] = Y_R([N, N + L - 1, S]);

H1    = R2 * H * R1';
H1H1t = H1 * H1';

disp('Computing (I+HH*)^{-1} ...')

tic
inv_rhoIHHstar = inv_Block_v1(H1H1t, rho, N, L, S, 1);
timeBlockDiagonalHHstar = toc;

disp(['Elapsed time: ' num2str(timeBlockDiagonalHHstar)])
disp('Computing I-H*(I+HH*)^{-1}H ...')

tic
inv_rhoIHstarH = speye(size(H1, 2)) - H1' * inv_rhoIHHstar * H1;
timeBlockDiagonalHstarH = toc + timeBlockDiagonalHHstar;

disp(['Elapsed time: ' num2str(timeBlockDiagonalHstarH)])
disp('Computing inversion accuracy ...')

inv_rhoIHHstar = R2' * inv_rhoIHHstar * R2;
inv_rhoIHstarH = R1' * inv_rhoIHstarH * R1;

errorBlockDiagonalHHstar = norm(inv_rhoIHHstar * rhoI_HHstar - speye(size(rhoI_HHstar, 2)), 'F');
errorBlockDiagonalHstarH = norm(inv_rhoIHstarH * rhoI_HstarH - speye(size(rhoI_HstarH, 2)), 'F');

disp(['Inversion acuracy (I+HH*)^{-1}:     ' num2str(errorBlockDiagonalHHstar)])
disp(['Inversion acuracy I-H*(I+HH*)^{-1}H:' num2str(errorBlockDiagonalHstarH)])

clear inv_rhoIHHstar inv_rhoIHstarH

%% QR Factorization

disp('--------------------------------------------')
disp('Computing QR Factorization ...')
disp('--------------------------------------------')

disp('Computing (I+HH*)^{-1} ...')

tic
[Q1, R] = qr(rhoI_HHstar);
inv_rhoIHHstar = R \ Q1';
timeQRHHstar = toc;

disp(['Elapsed time: ' num2str(timeQRHHstar)])
disp('Computing I-H*(I+HH*)^{-1}H ...')

tic
inv_rhoIHstarH = speye(size(H, 2)) - H' * inv_rhoIHHstar * H;
timeQRHstarH = toc + timeQRHHstar;

disp(['Elapsed time: ' num2str(timeQRHstarH)])
disp('Computing inversion accuracy ...')

errorQRHHstar = norm(inv_rhoIHHstar * rhoI_HHstar - speye(size(rhoI_HHstar, 2)), 'F');
errorQRHstarH = norm(inv_rhoIHstarH * rhoI_HstarH - speye(size(rhoI_HstarH, 2)), 'F');

disp(['Inversion acuracy (I+HH*)^{-1}:     ' num2str(errorQRHHstar)])
disp(['Inversion acuracy I-H*(I+HH*)^{-1}H:' num2str(errorQRHstarH)])

clear inv_rhoIHHstar inv_rhoIHstarH

%% Cholesky Decomposition

disp('--------------------------------------------')
disp('Computing Cholesky ...')
disp('--------------------------------------------')

disp('Computing (I+HH*)^{-1} ...')

tic
[Lc, ~] = chol(rhoI_HHstar, 'lower');
inv_Lc = Lc \ speye(size(Lc, 2));
inv_rhoIHHstar = inv_Lc' * inv_Lc;
timeCholeskyHHstar = toc;

disp(['Elapsed time: ' num2str(timeCholeskyHHstar)])
disp('Computing I-H*(I+HH*)^{-1}H ...')

tic
inv_rhoIHstarH = speye(size(H, 2)) - H' * inv_rhoIHHstar * H;
timeCholeskyHstarH = toc + timeCholeskyHHstar;

disp(['Elapsed time: ' num2str(timeCholeskyHstarH)])
disp('Computing inversion accuracy ...')

errorCholeskyHHstar = norm(inv_rhoIHHstar * rhoI_HHstar - speye(size(rhoI_HHstar, 2)), 'F');
errorCholeskyHstarH = norm(inv_rhoIHstarH * rhoI_HstarH - speye(size(rhoI_HstarH, 2)), 'F');

disp(['Inversion acuracy (I+HH*)^{-1}:     ' num2str(errorCholeskyHHstar)])
disp(['Inversion acuracy I-H*(I+HH*)^{-1}H:' num2str(errorCholeskyHstarH)])

clear inv_rhoIHHstar inv_rhoIHstarH

%% Proposed method

disp('--------------------------------------------')
disp('Computing Proposed Method ...')
disp('--------------------------------------------')

disp('Computing (E+P)^{-1} ...')

tic
[invP, ~] = ComputePinv(P, rho);
timePinv = toc;

disp(['Elapsed time: ' num2str(timePinv)])
disp('Computing E-H*(I+P)^{-1}H ...')

tic
Y = sensingHt(ones(M, N + L - 1, S), CAs);
invQ = Y - sensingHt(IMVM(invP, sensingH(Y, CAs)), CAs);
timeQinv = toc + timePinv;

disp(['Elapsed time: ' num2str(timeQinv)])
disp('Computing inversion accuracy ...')

d = ones(M, N, L);
b = sensingH(d, CAs);

HHstarb = sensingH(sensingHt(b, CAs), CAs);
InvertedMeasurement = IMVM(invP, rho * b + HHstarb);

[invQ1, ~] = ComputeQinv(Q, rho);
invQ2 = IMVMS(invQ1, Y);

errorPinv = norm(b(:) - InvertedMeasurement(:));
errorQinv = norm(invQ(:) - invQ2(:));

disp(['Inversion acuracy (E+P)^{-1}:     ' num2str(errorPinv)])
disp(['Inversion acuracy E-H*(I+P)^{-1}H:' num2str(errorQinv)])

clear invP invQ

end
