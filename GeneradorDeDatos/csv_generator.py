import csv
import random
import datetime

# Cojemos el horario actual
now = datetime.datetime.now()

# Funcion que añade X segundos a un datatime seleccionado
def addSecs(tm, secs):
    fulldate = datetime.datetime(tm.year, tm.month, tm.day, tm.hour, tm.minute
                                 ,tm.second)
    fulldate = fulldate + datetime.timedelta(seconds=secs)
    return fulldate


with open('data_entradas.csv', 'w') as entradas, open('data_respuesta.csv', 'w') as respuestas:
    filewriter_entradas = csv.writer(entradas, delimiter=',', quotechar='|',
                            quoting=csv.QUOTE_MINIMAL)
    filewriter_respuestas = csv.writer(respuestas, delimiter=',', quotechar='|',
                            quoting=csv.QUOTE_MINIMAL)

    for i in range(0,7000):
        randPrecipitacion = 0 # normalmente no llueve
        randRadiacion = random.uniform(5.35,6.45)
        randTempAtm = random.randint(-9,32)
        randHumAtm = random.randint(60,75)
        randPresAtm = random.randint(895,946)
        randTempSuelo = random.randint(5,28)
        randHumSuelo = random.randint(15,60)
        randUva = random.randint(20,55)

        # dias de precipitacion medios entre un 5% - 30% al mes
        n = random.randint(5,30)

        if(random.choice(['N']*(100-n) +['S']*n) == 'S'):
            randPrecipitacion = random.randint(1,20)
            randRadiacion = random.uniform(4.45,5.35) # menor radiacion
            randTempAtm = random.randint(-9,24) # temperaturas altas mas moderadas
            randHumAtm = random.randint(85,93) # mayor humedad
            randPresAtm = random.randint(925,946) # mayor presion atmosferica
            randHumSuelo = random.randint(35,70)

        # se supone que estos datos se deben de recopilar durante un largo
        # tiempo para hacer predicciones exactas
        randGradBaume = random.uniform(10.1,13.5)
        randPh = random.uniform(3.2,3.7)
        randAcidez = random.uniform(5.2,8.9)
        randPeso = random.randint(195,225)
        randAntocianos = random.randint(400,600)

        now = addSecs(now, i)
        timestamp = now.strftime("%Y-%m-%d %H:%M:%S") + " UTC"

        filewriter_entradas.writerow([timestamp,randPrecipitacion,randRadiacion,randTempAtm,
                             randHumAtm,randPresAtm,randTempSuelo,randHumSuelo,
                             randUva])
        filewriter_respuestas.writerow([timestamp,randGradBaume,randPh,randAcidez,randPeso,
                            randAntocianos])
