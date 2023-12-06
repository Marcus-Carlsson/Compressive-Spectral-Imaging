function [H,Img,Ind,Val] = Atranspose(M,N,L,dmd,Sh)

%  
% Atranspose.m
%
% This function design the forward CASSI sensing function (H matrix)
%
% -----------------------------------------------------------------------
% Copyright (2012): Gonzalo R. Arce
% 
% CASSI_UD is distributed under the terms
% of the GNU General Public License 2.0.
% 
% Permission to use, copy, modify, and distribute this software for
% any purpose without fee is hereby granted, provided that this entire
% notice is included in all copies of any software which is or includes
% a copy or modification of this software and in all copies of the
% supporting documentation for such software.
% This software is being provided "as is", without any express or
% implied warranty.  In particular, the authors do not make any
% representation or warranty of any kind concerning the merchantability
% of this software or its fitness for any particular purpose."
% ----------------------------------------------------------------------
% 
%
%   ===== Required inputs =====
%
%   M:      Rows of Hyperspectral datacube
%   N:      Columns of Hyperspectral datacube 
%   L:      Bands of Hyperspectral datacube  
%   dmd:    Coded aperture    
%   Sh:     CASSI measurement length
%
% 	===== Output =====
%   H:    Forward CASSI function (H matrix)
%   Img:  Contain the rows, columns and values of the H matrix
%   Ind:  Indices of H matrix to do the inverse transform (H^-1)
%   Val:  Values of H matrix to do the inverse transform (H^-1)
%
% ========================================================

at=[]; bt=[]; vt=[];
for r=1:L
    img = zeros(M,N*L);
    img(:,(r-1) + 1:N + (r-1)) = dmd(:,:,r);
    [a,b] = find(img);
    ax = a(:) + (b(:)-1)*M;   
    bx = (r-1)*(M*N) + (b(:)-1-(r-1))*M + a(:);    
    at = [at; ax(:)];
    bt = [bt; bx(:)];
end

H = sparse(at,bt,1,Sh,M*N*L);
[R1,R2,R3] = find(H);
Img=[]; Img{1}=R1; Img{2}=R2; Img{3}=R3;
%% Compact
[M1,L2]=sort(R1);
M2=R2(L2(:));
M3=R3(L2(:));

cont=1; cont2=1;
Ind=ones(Sh,L)*(M*N*L+1);
Val=zeros(Sh,L);

while cont2<=length(R1)
    k=1;
    Ind(M1(cont2),k)=M2(cont2);
    Val(M1(cont2),k)=M3(cont2);
    
    if (cont2<length(R1))
        while (M1(cont2)==M1(cont2+1))
            Ind(M1(cont2),k+1)=M2(cont2+1);
            Val(M1(cont2),k+1)=M3(cont2+1);
            
            cont2=cont2+1;
            k=k+1;
            if cont2>=length(R1)
                break;
            end
        end
    end
    
    cont2=cont2+1;
    cont=cont+1;
end


