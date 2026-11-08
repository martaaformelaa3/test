names(dane)
dane %>%
  filter(grepl("Comedy", Genre) & grepl("Polish", Languages)) %>%
  arrange(desc(IMDb.Score)) %>%
  select(Title, IMDb.Score) %>%
  head(3)