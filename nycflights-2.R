install.packages("nycflights13")
library(nycflights13)
help(package="nycflights13")


dplyr::glimpse()
dplyr::glimpse(flights)

str(flights)
head(flights)

library(dplyr)
glimpse(flights)
class(flights)

flights[1:10,]
as.data.frame(flights[1:10,])

iris
tbl_df(iris)

filter(flights, month==1 & day==1)
flights %>% filter(month==1 & day==1)

flights[flights$month==1 & 
          flights$day==1,]

arrange(flights, year, month, day)


flights[, c("year", "month", "day")]
flights %>% select(year, month, day)

tmp = flights

flights %>% 
  summarize(delay=mean(dep_delay, na.rm=TRUE),
            delay_min = min(dep_delay, na.rm=TRUE),
            delay_max = max(dep_delay, na.rm=TRUE))


fl_summary = flights %>% 
  group_by(origin, dest) %>%
  summarise(n=n(),
            delay=mean(dep_delay, na.rm=TRUE),
            distance=mean(distance)) %>%
  arrange(desc(n))

tmp = fl_summary %>%
  inner_join(airports %>% 
               select(faa, name) %>% 
               rename(origin_name=name,
                      origin=faa)) %>%
  inner_join(airports %>% 
               select(faa, name) %>% 
               rename(dest_name=name,
                      dest=faa)) 


setdiff(fl_summary$origin, airports$faa)

(faa_diff = 
  setdiff(fl_summary$dest, airports$faa))

fl_summary %>% filter(dest %in% faa_diff)

?"%in%"

fl_summary$dest %in% faa_diff
