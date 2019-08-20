clear all; close all;

% Carga de la red entrenada
load netTransferUvas

% Canal: TFM-entradas test
ChannelIDVinedos = XXXXXX;
writeAPIKeyVinedos = XXXXXX;

% Tamaño de las imagenes recortadas (227x227x3(RGB))
sz = netTransfer.Layers(1).InputSize;

%%
% seleccionar fichero
[aa bb]=uigetfile({'*.*','All files'});

% Tamaños de la imagen y la mostramos
I=imread([bb aa]);
[M,N,c] = size(I);
figure(1); imshow(I); impixelinfo

% Recorremos la imagen original en bloques de 200x200 y analizamos

w = 200; % ancho del recuadro

% Array que acumula el porcentaje de cada clase detectada en cada imagen
% recortada
Procentajes = zeros(1,size(size(netTransfer.Layers(25,1).Classes, 1),2)); % indica el numero de clases
CuadrosImagen = 0;
for i=1:w:M-w+1
  for j=1:w:N-w-1
    Rec = I(i:i+w-1,j:j+w-1,:);
    % Redimensionamos a 227x227
    Ir = imresize(Rec, [227 227]);
    [label, Error]  = classify(netTransfer,Ir);
    CuadrosImagen = CuadrosImagen + 1;
    Procentajes = Procentajes + Error;
  end
end

PorcentajeMedio = Procentajes/CuadrosImagen;
disp('Porcentajes Promedio = '); disp(PorcentajeMedio)

% Mostramos grafica de porcentajes totales de las clases en la imagen 
h = figure;
a = axes('parent', h);
hold(a, 'on')

colors = {'r', 'b', 'g','y','k'};
nombres = {'Cielo'; 'Hojas'; 'Tierra'; 'Uvas-blancas';'Uvas-negras'}; 

for i = 1:numel(PorcentajeMedio)
    b = bar(i, PorcentajeMedio(i), 1.0, 'stacked', 'parent', a, 'facecolor', colors{i});
end

a.XTick = 1:5;
a.XTickLabels = nombres;

ylabel('Porcentaje Clases')

%% Escribimos en el canal
ratioUvasHojas = PorcentajeMedio(5)/PorcentajeMedio(2);

thingSpeakWrite(ChannelIDVinedos,'Values',ratioUvasHojas,'Fields',8,'Writekey',writeAPIKeyVinedos);
pause(15); %esperar a consolidar datos en el canal


