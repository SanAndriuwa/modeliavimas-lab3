# Sprendimas: diodo parametrų nustatymas

Kiekvienai kreivei [lab3_main.m](lab3_main.m) sudaro dvi netiesines lygtis iš dviejų grafiko taškų:

$$I_0(\exp(U_1e/(kT))-1)-I_1=0,$$
$$I_0(\exp(U_2e/(kT))-1)-I_2=0.$$

Temperatūra formulėje matuojama kelvinais; tik rezultatų lentelėje ji paverčiama į Celsijaus laipsnius.

Kad skirtingi vienetai nepablogintų skaičiavimo, x1 yra I0 mikroamperais, o x2=T/100. Lygties liekanos dalijamos iš atitinkamų stebimų srovių.

[newtons.m](newtons.m) apskaičiuoja Jakobio matricą centriniais skirtumais, sprendžia **J·Δx=-F(x)** ir atnaujina **x←x+Δx**. Jei liekanos norma nemažėja ar parametras tampa neigiamas, žingsnis dalijamas pusiau. Sustojama, kai maksimali santykinė liekana mažesnė už 10⁻¹⁰; riba yra 100 iteracijų.

## MATLAB R2026a rezultatai

| Kreivė | I0, µA | t, °C | Iteracijos | Maks. santykinė liekana |
|---|---|---|---|---|
| 1 | 1.0028 | -9.5914 | 6 | 8.214e-16 |
| 2 | 4.9767 | 29.570 | 4 | 2.363e-14 |
| 3 | 9.1137 | 50.877 | 6 | 4.913e-16 |

Rezultatai artimi PDF patikrinimo reikšmėms (1,5,9 µA ir -10,30,50 °C). Skirtumai tikėtini, nes įėjimo taškai nuskaityti iš grafiko ir suapvalinti. Tai nėra tikslūs eksperimentiniai matavimai.

## Palyginimas su fsolve

Skripte pateiktas `fsolve()` iškvietimas sprendžia **tas pačias lygtis su ta pačia pradine reikšme [3,3]**. Jei Optimization Toolbox įdiegtas, atspausdinami abiejų metodų rezultatai, jų skirtumas ir braižomos abi kreivės.

Šiame kompiuteryje Optimization Toolbox neįdiegtas. Todėl faktiškai patikrintas Niutono metodas visoms trims kreivėms; **`fsolve()` palyginimas nebuvo vykdytas**, o jo lentelės reikšmės pažymėtos `NaN`. Tai aiškiai pranešama vykdymo metu.

Niutono metodas yra pateiktos `newtons.m` idėjos adaptacija: ištaisytas Jakobio išėjimo formos apdorojimas, taikomas pilnas mažinantis žingsnis ir tikrinama konvergencija. MATLAB statinis analizatorius pastabų nerado.
