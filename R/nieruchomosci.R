library(dplyr)
library(tidyr)

adres_nieruchomosci <- paste0(
  "https://raw.githubusercontent.com/kflisikowsky/pandas_exercises/",
  "62863036107888c0c7273c40e8d309a43f4da3a9/data/models/real_estate.csv"
)
raw_nier <- read.csv(adres_nieruchomosci, check.names = FALSE)
stopifnot(nrow(raw_nier) == 414, ncol(raw_nier) == 7)

nier <- raw_nier
names(nier) <- c("id", "wiek_lat", "metro_m", "sklepy", "lat", "lon",
                 "cena_10k_twd_ping")
head(nier)

##Zadanie 1

# Sprawdź liczbę rekordów i kolumn, typy danych, liczbę braków oraz podstawowe statystyki. 
dim(nier) #liczba rekordów i kolumn
str(nier) #typ danych: int-liczby calkowite, num-liczby z cyfra dziesiętną
summary(nier) #podstawowe statystyki

# Zweryfikuj, czy `id` jest unikatowe. 
colSums(is.na(nier)) #braki danych w wszystkich kolumnach w 'nier'
anyDuplicated(nier$id) #wynik 0 oznacza że nie ma powtórzeń, 'id' jest unikatowe

head(nier)

#Wskaż zmienne liczbowe, których nie powinno się interpretować jako zwykłych miar ilościowych (np. identyfikator).
# id - bo to identyfikator
# lat i lon - szerokość/latitude i długość/longitude geograficzna
