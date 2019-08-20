%% Leer thetas
% Canal: TFM-Thetas y respuestas predichas
ChannelIDThetas=XXXXXX
readAPIKeyThetas=XXXXXX
writeAPIKeyThetas=XXXXXX
thetas = thingSpeakRead(ChannelIDThetas,'Fields',1,'NumPoints',45, 'ReadKey', readAPIKeyThetas);

B1=thetas(1:9)
B2=thetas(10:18)
B3=thetas(19:27)
B4=thetas(28:36)
B5=thetas(37:45)

%%
% Canal: TFM-entradas test
ChannelIDEntradas = XXXXXX;
readAPIKeyEntradas = XXXXXX;
X = thingSpeakRead(ChannelIDEntradas,'NumPoints',30, 'ReadKey', readAPIKeyEntradas);
c = ones(30,1);
X=[c X];

%% Para cada Theta predecir la media mensual
Graduacion_pred = mean(X*B1);
Ph_pred = mean(X*B2);
Acidez_pred = mean(X*B3);
Peso_pred = mean(X*B4);
Antocianos_pred = mean(X*B5);

%% Cuanto a acertado
ChannelIDRespuestas = XXXXXX;
readAPIKeyRespuestas = XXXXXX;
Y = thingSpeakRead(ChannelIDRespuestas,'NumPoints',30,'ReadKey',readAPIKeyRespuestas);
100 - mean(abs((X*B1)-Y(:,1)))
100 - mean(abs((X*B2)-Y(:,2)))
100 - mean(abs((X*B3)-Y(:,3)))
100 - mean(abs((X*B4)-Y(:,4)))
100 - mean(abs((X*B5)-Y(:,5)))



%%
thingSpeakWrite(ChannelIDThetas,'Fields',[2,3,4,5,6],'Values',{Graduacion_pred,Ph_pred,Acidez_pred,Peso_pred,Antocianos_pred},'WriteKey',writeAPIKeyThetas)
pause(15); %esperar a consolidar datos en el canal