# Modeliavimas-lab3

## Užduotis: netiesinių lygčių sprendimas

Diodo voltamperinė charakteristika:

$$I = I_0\left(\exp\left(\frac{Ue}{kT}\right)-1\right),$$

kur **k = 1.38·10⁻²³**, **e = 1.602·10⁻¹⁹**, o **T = t + 273.15** kelvinais.

1. Sudarykite MATLAB programą parametrams I0 ir t nustatyti Niutono metodu.
2. Palyginkite rezultatą su MATLAB `fsolve()`.
3. Nubraižykite diodo charakteristiką su rastais parametrais.

Patikrinimo reikšmės iš užduoties:

| Kreivė | I0, µA | t, °C |
|---|---|---|
| 1, ištisinė | 1 | -10 |
| 2, brūkšninė | 5 | 30 |
| 3, brūkšninė-taškinė | 9 | 50 |

Šaltinis: dėstytojo pateiktas `NonLinear.pdf`.

## Pradiniai duomenys

PDF pateiktas tik grafikas, tikslios matavimo lentelės nėra. Skriptas naudoja **apytikriai nuo grafiko nuskaitytus, suapvalintus taškus**:

| Kreivė | I prie U=0.08 V, µA | I prie U=0.12 V, µA |
|---|---|---|
| 1 | 33 | 197 |
| 2 | 102 | 491 |
| 3 | 151 | 662 |

Todėl nustatyti parametrai yra apytikriai. Turint tikslius matavimo duomenis, pakeiskite `Udata` ir `Igraph`. Užduoties patikrinimo parametrai naudojami tik rezultatui palyginti po sprendimo.

## Paleidimas

Atidarykite [lab3_main.m](lab3_main.m) ir paspauskite **Run**. [newtons.m](newtons.m) turi būti tame pačiame aplanke. Funkcijai `fsolve()` reikalingas **Optimization Toolbox**. Be jo Niutono metodas veikia, o `fsolve()` lentelėje rodoma `NaN` ir pranešama, kad šis palyginimas nebuvo vykdytas.

Pagal nutylėjimą sprendžiamos visos trys kreivės (`variants = 1:3`).

Paaiškinimas: [SOLUTION.md](SOLUTION.md).
