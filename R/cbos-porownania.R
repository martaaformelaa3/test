install.packages(c("dplyr", "tidyr", "haven"))
library(dplyr)
library(tidyr)
library(haven)
adres_cbos <- paste0("https://raw.githubusercontent.com/kflisikowsky/sad/",
                     "main/data/CBOS_201733_331_SPSS.sav")
plik_cbos <- tempfile(fileext = ".sav")
download.file(adres_cbos, plik_cbos, mode = "wb", quiet = TRUE)
cbos_raw <- read_sav(plik_cbos)
unlink(plik_cbos)

cbos <- cbos_raw %>% transmute(
  plec = as_factor(plec),
  miejscowosc = as_factor(klm6),
  kierunek = as_factor(q24),
  prognoza = as_factor(q25),
  wyksztalcenie = as_factor(q15)
)
dim(cbos)
head(cbos)

### Zadanie 7 — wieś i duże miasta
#Wybierz respondentów z kategorii `miejscowosc` równych `"wieś"` i `"miasto 500 000 i więcej"`
cbos_wies_miasto <- cbos %>% 
  filter(miejscowosc == "wieś" | miejscowosc == "miasto 500 000 i więcej")
#Dla każdej z tych dwóch grup policz **procent**  odpowiedzi na pytanie `kierunek` (procent w obrębie grupy, nie w całej tabeli).
cbos_procenty <- cbos_wies_miasto %>% 
  group_by(miejscowosc) %>% 
  count(kierunek) %>% 
  mutate(procent = n / sum(n) * 100)

cbos_procenty
#Czy udział odpowiedzi „W złym” był taki sam?

# Nie – mieszkańcy miast 500k+ znacznie częściej uważają, że sprawy idą w złym kierunku (61.4%) 
# w porównaniu do mieszkańców wsi (28.1%).

#Sprawdź liczbę respondentów w obu grupach. Samo porównanie procentów bez liczebności może być mylące.

cbos_liczebnosc <- cbos_wies_miasto %>% 
  count(miejscowosc, name = "lacznie_respondentow")

cbos_liczebnosc

#filter(...), count(miejscowosc, kierunek), group_by(miejscowosc)
