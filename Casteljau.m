function [R] = Casteljau( V, n, t)
%function [R] = Casteljau( V, n, t)
%Algoritmo di De Casteljau
%   INPUT
%       n = grado della curva di Bézier
%       V = V0,...,Vn = vertici di controllo della curva di Bézier
%       t = parametro in cui voglio valutare la curva
%   OUTPUT
%       R = curva valutata nel parametro t

Q=V;
for k=1:n %Inizio l'algoritmo di De Casteljau
    for i=1:n-k+1
        Q(i,:)=(1.0-t)*Q(i,:)+t*Q(i+1,:);
    end
end
R=Q(1,:); %Memorizzo il risultato appena ottenuto in R
end
