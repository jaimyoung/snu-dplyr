install.packages("nycflights13")

library(nycflights13)

help(package="nycflights13")

glimpse(flights)



library(ggplot2)
library(dplyr)
library(tidyr)
library(data.table)
library(babynames)

rowwise()

(by_tailnum = group_by(flights, tailnum))
delay = summarise(by_tailnum,
                  count = n(),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE))
delay = filter(delay, count > 20, dist < 2000)
delay


library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()

(df1 <- data_frame(x = c(1, 2), y = 2:1))
(df2 <- data_frame(x = c(1, 3), a = 10, b = "a"))

df1 %>% inner_join(df2)
df1 %>% left_join(df2)
df1 %>% right_join(df2)
df1 %>% full_join(df2)


(flights2 = flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier))
airlines


flights2 %>% left_join(airlines)
