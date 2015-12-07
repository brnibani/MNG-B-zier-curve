%Progetto di MNG (Metodi Numerici per la Grafica)
%   Argomento : Curve di Bézier

close all
clear

while(true)
    text = {'Inserisci il grado della curva di Bézier che si desideri ottenere:'};
    title = 'Progetto MNG';
    num_lines = 1;
    answer = inputdlg(text,title,num_lines);
    n = str2double(answer{1});
    if(n > 0)
        break;
    end
end

disp('Il grado della curva di Bézier che si desidera ottenere è pari a :');
n

%Il numero dei vertici del poligono di controllo relativo alla Curva di
%Bézier è pari al grado della curva + 1
nV = n + 1; % nV rappresenta il numero dei vertici del poligono di controllo

V = zeros(nV,2); %Si inizializza a zero il vettore dei vertici del poligono di controllo

figure('Name','Inserisci le coordinate dei punti di controllo');
axis equal
V = ginput(nV); %funzione che permette all'utente di specificare le
                %posizioni dei vari vertici del poligono di controllo
close(1)

disp('Ecco le coordinate dei vertici di controllo da te inserite :');
V

%Fissiamo t, ossia l'insieme di parametri in cui valutare la curva
t = 0:0.05:1;

%Facciamo partire l'algoritmo di de Casteljau
C = zeros(length(t), size(V,2)); %Inizializzo a 0 tutti gli elementi di C
for j=1:length(t) %Scorro tutti gli indici in cui voglio valutare la curva
    C(j,:) = Casteljau(V,n,t(j));
end

%Disegniamo i vertici di controllo
figure('Name','Curva di Bézier con relativi vertici di controllo');
movegui('northwest'); %si sposta il grafico nella parte in alto a sinistra dello schermo (nord-ovest)
plot(V(:,1),V(:,2),'o--','MarkerFaceColor','b');
hold on;
grid on;
axis equal;

%Disegnamo la curva di Bézier
plot(C(:,1),C(:,2),'r');
legend('Vertici di controllo (V)','Curva di Bézier (C)','Location','southwest')

while(true)
    text2 = {'Inserisci il parametro compreso tra 0 ed 1 in cui suddividere la curva:'};
    title2 = 'Progetto MNG';
    num_lines2 = 1;
    answer2 = inputdlg(text2,title2,num_lines2);
    tstar = str2double(answer2{1});
    if(tstar > 0 && tstar < 1)
        break;
    end
end

disp('Il parametro (compreso tra 0 ed 1) in cui suddividere la curva è pari a :');
tstar

%Suddividiamo la curva di Bèzier utilizzando l'algoritmo di De Casteljau
[V1, V2] = SuddCasteljau(V,n,tstar);

%Facciamo partire l'algoritmo di De Casteljau per disegnare le due curve di
%Bézier che si toccano le punto tstar
C1 = zeros(length(t), size(V,2));
C2 = zeros(length(t), size(V,2));
for j=1:length(t)
    C1(j,:)=Casteljau(V1,n,t(j));
end

for j=1:length(t)
    C2(j,:)=Casteljau(V2,n,t(j));
end

%Disegniamo i vertici di controllo
figure('Name','Curva di Bézier suddivisa nel punto tstar');
movegui('northeast');%si sposta il grafico nella parte in alto a destra dello schermo (nord-est)
plot(V1(:,1),V1(:,2),'o--','MarkerFaceColor','b');
hold on;
grid on;
axis equal;
plot(V2(:,1),V2(:,2),'o--','MarkerFaceColor','r');
%Disegnamo la curva di Bézier
plot(C1(:,1),C1(:,2),'b');
plot(C2(:,1),C2(:,2),'r');
legend('Vertici di controllo della prima curva di Bézier(V1)',...
    'Vertici di controllo della seconda curva di Bézier(V2)',...
    'Prima curva di Bézier (C1)', 'Seconda curva di Bézier (C2)',...
    'Location','southwest')


%Adesso, incrementiamo il grado della Curva di Bézier iniziale
%fino ad un nuovo grado (newn) inserito dall'utente tramite tastiera a
%runtime

while(true)
    text3 = {'Inserisci il nuovo grado della curva di Bézier:'};
    title3 = 'Progetto MNG';
    num_lines3 = 1;
    answer3 = inputdlg(text3,title3,num_lines3);
    newn = str2double(answer3{1});
    if(newn > n)
        break;
    end
end

disp('Il nuovo grado della curva di Bézier è pari a : ');
newn

newV = V;
for i=n:newn-1  %Ci si ferma a newn-1 perché l'ultima volta che si usa
                %l'algoritmo di elevamento del grado è quando da newn-1
                %si incrementa il grado di 1 e si ottiene dunque una curva
                %di Bézier di grado newn
    newV = elevamentogrado(newV,i);
end

%Calcoliamo la nuova Curva di Bézier aumentata di grado
newC = zeros(length(t), size(newV,2)); %Inizializzo a 0 tutti gli elementi di C
for j=1:length(t) %Scorro tutti gli indici in cui voglio valutare la curva
    newC(j,:) = Casteljau(newV,newn,t(j));
end


%Disegniamo i vertici di controllo
figure('Name','Curva di Bézier aumentata di grado');
plot(newV(:,1),newV(:,2),'o--','MarkerFaceColor','b');
hold on;
grid on;
axis equal;
%Disegnamo la curva di Bézier
plot(newC(:,1),newC(:,2),'r');
legend('Vertici di controllo della curva di Bézier aumentata di grado(newV)',...
    'Curva di Bézier aumentata di grado (newC)', 'Location','southwest')
