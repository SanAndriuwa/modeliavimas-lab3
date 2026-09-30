# Sprendimas: diodo parametrų nustatymas

Kiekvienai kreivei [lab3_main.m](lab3_main.m) sudaro dvi netiesines lygtis iš dviejų grafiko taškų:

$$I_0(\exp(U_1e/(kT))-1)-I_1=0,$$
$$I_0(\exp(U_2e/(kT))-1)-I_2=0.$$

Temperatūra formulėje matuojama kelvinais; tik rezultatų lentelėje ji paverčiama į Celsijaus laipsnius.

Kad skirtingi vienetai nepablogintų skaičiavimo, x1 yra I0 mikroamperais, o x2=T/100. Lygties liekanos dalijamos iš atitinkamų stebimų srovių.

[newtons.m](newtons.m) naudoja pateikto failo `jacob()` centriniais skirtumais apskaičiuotą Jakobio matricą ir sprendžia **J·Δx=-F(x)**. Išlaikytas pateiktas slopinimas: prieš pirmą bandymą žingsnis dalijamas pusiau; jei liekanos norma nesumažėja, atliekama iki trijų bandymų, kas kartą dar dalijant žingsnį pusiau.

Pagal pateiktą funkciją sustojama, kai žingsnio norma mažesnė už `TolX=10⁻¹⁰` arba liekanos norma mažesnė už `eps`. Didžiausias iteracijų skaičius yra 100. Pagrindinis skriptas papildomai tikrina galutinę santykinę liekaną, kuri turi būti mažesnė už 10⁻⁸.

## MATLAB R2026a rezultatai

| Kreivė | I0, µA | t, °C | Iteracijos | Maks. santykinė liekana |
|---|---|---|---|---|
| 1 | 1.0028 | -9.5914 | 34 | 2.897e-11 |
| 2 | 4.9767 | 29.570 | 35 | 1.137e-11 |
| 3 | 9.1137 | 50.877 | 36 | 1.041e-11 |

Rezultatai artimi PDF patikrinimo reikšmėms (1,5,9 µA ir -10,30,50 °C). Skirtumai tikėtini, nes įėjimo taškai nuskaityti iš grafiko ir suapvalinti. Tai nėra tikslūs eksperimentiniai matavimai.

## Palyginimas su fsolve

Skripte pateiktas `fsolve()` iškvietimas sprendžia **tas pačias lygtis su ta pačia pradine reikšme [3,3]**. Jei Optimization Toolbox įdiegtas, atspausdinami abiejų metodų rezultatai, jų skirtumas ir braižomos abi kreivės.

Šiame kompiuteryje Optimization Toolbox neįdiegtas. Todėl faktiškai patikrintas Niutono metodas visoms trims kreivėms; **`fsolve()` palyginimas nebuvo vykdytas**, o jo lentelės reikšmės pažymėtos `NaN`. Tai aiškiai pranešama vykdymo metu.

Pagrindinis skriptas iš tikrųjų kviečia pateikto `newtons.m` adaptaciją atskirame faile. Išlaikyti jo Jakobio skaičiavimas, trys slopinimo bandymai ir stabdymo kriterijai. Pataisytas eilutės ir stulpelio liekanų apdorojimas, rezervuota istorijos atmintis ir išlaikytas papildomas konvergencijos patikrinimas pagrindiniame skripte.
