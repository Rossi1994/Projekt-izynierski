#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
AC1 = (Pa - Pe)/(1 - Pe)

Pa = (1/n`) * for i in n`:
           for k in q:
            (Rik * (Rik - 1))/Ri(Ri - 1)
      
Pe = (1/(q - 1)) * for k in q:
                    "Pi"k * (1 - "Pi"k)
               
"Pi"k = (1/n) * for i in n:
                    Rik/Ri
"""                    
# AC1 - współczynnik (zgodności decyzji dla dowolnej ilość oceniających oraz kategorii) Gwet'a
# r - liczba oceniających [liczba operatorów + ekspert]
# q - liczba kategorii [liczba cech]
# k - kategoria
# n - liczba wszystkich obiektów w badaniu [liczba części]
# n` - liczba wszystkich obiektów w badaniu, które oceniło co najmniej 2 oceniających 
# Pa - udział zaobserwowanych zgodnych decyzji w odniesieniu do liczby możliwych decyzji zespołu oceniających
# Pe - szansa (prawdopodobieństwo) na zgodność przypadkową
# Rik - liczba oceniających, którzy zaklasyfikowali obiekt i do kategorii k [przypisanie]
# Ri - liczba oceniających, którzy ocenili obiekt i
# "Pi"k - prawdopodobieństwo wskazania kategorii k przez dowolnego oceniającego dla dowolnej części [1/n]

# AC1 - ZGODNOŚĆ WEWNĘTRZNA (WŁASNA) OPERATORA LUB EKSPERTA


'''Przykład:
3 operatorów + 1 ekspert (3 oceniających ???) = r
można ocenić: "dobry" lub "zły" (2 kategorie = cechy)
kategoria 1., 2.
3 różnych części
n` = n
R[i] = liczba oceniających, którzy ocenili obiekt i
R[0] = R[1] = R[2] = r = 3
R[i][k] = liczba oceniających, którzy zaklasyfikowali obiekt i do kategorii k
R[0][0] = 1, R[0][1] = 2, R[1][0] = 2, R[1][1] = 1, R[2][0] = 1, R[2][1] = 2
"Pi"1 = "Pi"2 = "Pi"3 = "Pi"4 = 1/n = 1/30
'''

# Na wymogi przykładu:
n2 = 30.0
nP2 = 30.0
q2 = 2.0
r = 2.0

R1 = [[0.0 for x in range(2)] for y in range(30)]
R2 = [0.0 for z in range(30)]

for i in range(8):
    R1[i][1] = 2.0
for i in range(8, 10):
    R1[i][0] = 2.0
for i in range(10, 17):
    R1[i][1] = 2.0
for i in range(17, 19):
    R1[i][0] = 2.0
for i in range(19, 20):
    R1[i][1] = 2.0
for i in range(20, 21):
    R1[i][0] = 2.0
for i in range(22, 25):
    R1[i][0] = 2.0
for i in range(25, 27):
    R1[i][1] = 2.0
for i in range(27, 28):
    R1[i][0] = 2.0
for i in range(28, 30):
    R1[i][0] = 1.0
R1[21][0] = 1.0
R1[21][1] = 1.0

for i in range(30):
    R2[i] = r
    
'''
n2 = 3.0
nP2 = 3.0
q2 = 2.0
r = 3.0

R1 = [[0.0 for x in range(2)] for y in range(3)]
R2 = [0.0 for z in range(3)]

R1[0][0] = 1.0 
R1[0][1] = 2.0
R1[1][0] = 2.0
R1[1][1] = 1.0 
R1[2][0] = 1.0
R1[2][1] = 2.0

R2[0] = r
R2[1] = r
R2[2] = r
'''
#----------------------------------
def OblPik(k, n):
    suma = 0.0
    for i in range(int(n)):
        suma += R1[i][k] / R2[i]
    Pik = suma / n
    print "suma " + str(suma)
    print "n " + str(n) 
    print "Pik " + str(Pik)
    return Pik

def OblPa(nP, q):
    suma = 0.0
    for i in range(int(nP)):
        for k in range(int(q)):
            suma += (R1[i][k] * R1[i][k] - R1[i][k]) / (R2[i] * R2[i] - R2[i])
    Pa = suma / nP
    print "Pa " + str(Pa)
    print "suma " + str(suma)
    print "n` " + str(nP)
    return Pa
    
def OblPe(q, n):
    suma = 0.0
    for k in range(int(q)):
        suma += OblPik(k, n) * (1.0 - OblPik(k, n))
    Pe = suma / (q - 1.0)
    print "Pe " + str(Pe)
    print "suma " + str(suma)
    print "q " + str(q)
    return Pe
    
def ObliczanieWspGweta(nP, q, n):
    print "OblPe " + str(OblPe(q, n))
    print "OblPa " + str(OblPa(nP, q))
    AC1 = (OblPa(nP, q) - OblPe(q, n)) / (1.0 - OblPe(q, n))
    return AC1

print ObliczanieWspGweta(nP2, q2, n2)

# RAPORT:
# Dodać do tabeli ARKUSZE wydział_firmy; zamienić firma na nazwa_firmy
# PYTANIA:
# Czy umożliwić obliczanie 3 wsp., czy może najbardziej uniwersalnego (Gwet'a)?
# Przykład obliczania zgodności wewnętrznej operatora, eksperta, zgodności operator-ekspert,
# operator-operator oraz zgodności łącznej, w szczególności przykładu 
# zawartego w dokumencie "Magdalena_DIERING_IZIP_2016.pdf" w Tabeli 3. odnośnie Operatora 1.
# Co to jest w raporcie "NR KATALOGU BŁĘDÓW..."?
# Co to jest ta wartość referenycyjna w raporcie?
# Co oznacza "ŁĄCZNY POZIOM ZGODNOŚCI" bez wartości refer. oraz z uwzględnieniem tej wartości?
# Co oznacza REF w "ZGODNOŚĆ WEWNĘTRZNA"?
# Co oznacza "POZIOM ZGODNOŚCI OPERATORÓW I WARTOŚCI REFERENYCYJNEJ"?
# Co ma być zawarte w "UWAGI"?
# Co powinno się znaleźć w "PROPOZYCJE DZIAŁAŃ KORYGUJĄCYCH" zależnie od wyników kontroli?
# Co to jest "ZAŁĄCZNIK 2" i o co chodzi tutaj z wartością referencyjną?
# Czy zakładamy, że każdy przedmiot oceniła ta sama liczba operatorów?
# Dokładność obliczeń do ilu miejsc po przecinku?
# Czy może być dopuszczenie wpisania wartości "nn"?