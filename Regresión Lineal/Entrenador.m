%% Leemos datos
% Canal: TFM-entradas entrenamiento
ChannelIDEntradas = XXXXXX;
readAPIKeyEntradas = XXXXXX;

% Canal: TFM-respuestas entrenamiento
ChannelIDRespuestas = XXXXXX;
readAPIKeyRespuestas = XXXXXX;

X = thingSpeakRead(ChannelIDEntradas,'NumPoints',7000, 'ReadKey', readAPIKeyEntradas);
Y1 = thingSpeakRead(ChannelIDRespuestas,'Fields',1,'NumPoints',7000, 'ReadKey', readAPIKeyRespuestas);
Y2 = thingSpeakRead(ChannelIDRespuestas,'Fields',2,'NumPoints',7000, 'ReadKey', readAPIKeyRespuestas);
Y3 = thingSpeakRead(ChannelIDRespuestas,'Fields',3,'NumPoints',7000, 'ReadKey', readAPIKeyRespuestas);
Y4 = thingSpeakRead(ChannelIDRespuestas,'Fields',4,'NumPoints',7000, 'ReadKey', readAPIKeyRespuestas);
Y5 = thingSpeakRead(ChannelIDRespuestas,'Fields',5,'NumPoints',7000, 'ReadKey', readAPIKeyRespuestas);
%% Usamos la ecuación normal
c = ones(size(Y1,1),1);
X=[c X];
B1 = pinv((X'*X))*(X')*(Y1);
B2 = pinv((X'*X))*(X')*(Y2);
B3 = pinv((X'*X))*(X')*(Y3);
B4 = pinv((X'*X))*(X')*(Y4);
B5 = pinv((X'*X))*(X')*(Y5);

%% Escribimos los thetas al canal
% Canal: TFM-Thetas
ChannelIDThetas=XXXXXX;
writeAPIKeyThetas=XXXXXX;

d = datetime('now','Format','dd-MM-yyyy HH:mm:ss');

for i = 1:1:45
    Timestamps(i)=d+i;
end

thetas=[B1',B2',B3',B4',B5']'
data = table(Timestamps',thetas)
%%
% Escribimos los theta en el campo 1 del canal
thingSpeakWrite(ChannelIDThetas,data,"WriteKey",writeAPIKeyThetas)
pause(15); %esperar a consolidar datos en el canal

