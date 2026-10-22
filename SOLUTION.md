# Niutono metodas

Naudojama formulė `x_naujas = x - f(x)/f'(x)`.

Kiekvienoje iteracijoje apskaičiuojamas naujas įvertis ir patikrinama:

- `abs(f(x_naujas)) <= tolY`;
- `abs(x_naujas-x) <= tolX`.

Pakanka vienos sąlygos. Jei nė viena neįvykdoma, atliekama daugiausia N iteracijų ir grąžinamas paskutinis įvertis. Pradinis tikslus sprendinys grąžinamas su 0 iteracijų. Kai išvestinė lygi nuliui, pateikiamas aiškus pranešimas pakeisti x0.

9 variantui f(x)=exp(x)-2, f'(x)=exp(x). Kai x0=1 ir abi tolerancijos 1e-8, gaunama maždaug 0.693147180560 per 4 iteracijas. Lyginių laipsnių funkcijoms teigiamas pradinis artinys randa teigiamą šaknį; neigiamai šakniai reikia neigiamo x0.
