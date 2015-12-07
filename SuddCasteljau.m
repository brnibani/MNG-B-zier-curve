function [V1, V2] = SuddCasteljau( V, n, tstar)
%function [V1, V2] = SuddCasteljau( V, n, tstar)
%Algoritmo di De Casteljau per la suddivisione di una curva
%   INPUT
%       n = grado della curva di Bézier
%       V = V0,...,Vn = vertici di controllo della curva di Bézier iniziale
%       tstar = parametro in cui voglio valutare la curva
%   OUTPUT
%       V1 = vertici di controllo della curva 1
%       V2 = vertici di controllo della curva 2

V1=zeros(size(V,1),size(V,2));
V2=zeros(size(V,1),size(V,2));
count1=1;
count2=size(V,1);
Q=V;
V1(count1,:)=V(1,:);
V2(count2,:)=V(size(V,1),:);
for k=1:n %Inizio l'algoritmo di De Casteljau
    for i=1:n-k+1
        Q(i,:)=(1.0-tstar)*Q(i,:)+tstar*Q(i+1,:);
        if(i==1)
            count1 = count1 +1;
            V1(count1,:) = Q(i,:);
        end
        if(i==n-k+1)
           count2 = count2 -1;
           V2(count2,:) = Q(i,:);
        end
    end
end
end

