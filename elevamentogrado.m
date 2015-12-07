function [newV] = elevamentogrado(V,n)
%function [newV] = elevamentogrado(V,n)
%Algoritmo di elevamento di grado
%   INPUT
%           V = vertici di controllo della curva di Bèzier iniziale
%           n = grado della curva di Bèzier iniziale
%
%   OUTPUT
%           newV = nuovi vertici di controllo

newV(1,:) = V(1,:); 
for i=2:n+1
    newV(i,:) = ( ((i-1)/(n+1)) * V(i-1,:) ) +( ( 1 - ((i-1)/(n+1))) * V(i,:));
end
newV(n+2,:) = V(n+1,:);

end

