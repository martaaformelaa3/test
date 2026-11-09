#**CHALLENGE 3:** 
#Dla produkcji z lat 2019 oraz 2020 jaki jest średni czas między premierą a pojawieniem się na Netflixie?


dane %>%
  mutate(
    Release.Date = mdy(Release.Date),
    Netflix.Release.Date = mdy(Netflix.Release.Date),
    rel_year = year(Release.Date),
    time_diff = Netflix.Release.Date - Release.Date
  ) %>%
  filter(rel_year %in% c(2019, 2020)) %>%
  group_by(rel_year) %>%
  summarise(avg_time = round(mean(time_diff, na.rm = TRUE), 0))