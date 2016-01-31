# 자료 설치
install.packages("nycflights13")

library(nycflights13)

help(package="nycflights13")

#-------------------
# 0. 패키지 로딩
library(dplyr)
library(ggplot2)
library(nycflights13)


# 자료 훑어보기
glimpse(flights)


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



#------------------------------
# join 예제
(df1 <- data_frame(x = c(1, 2), y = 2:1))
(df2 <- data_frame(x = c(1, 3), a = 10, b = "a"))

df1 %>% inner_join(df2)
df1 %>% left_join(df2)
df1 %>% right_join(df2)
df1 %>% full_join(df2)


flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)



(flights2 = flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier))
airlines


flights2 %>% left_join(airlines)

#--------------------------
# 날짜별 항공편 회수, 연착 추세 연구
install.packages("lubridate")

library(lubridate)

(per_day = flights %>%
  group_by(year, month, day) %>%
  summarize(flights = n(),
            distance = mean(distance),
            arr = mean(arr_delay, na.rm = TRUE),
            dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  mutate(dt_str = sprintf("%04d-%02d-%02d",
                          year, month, day),
         dt = parse_date_time(dt_str, "ymd",tz = "US/Eastern"),
         dow = wday(dt, label=TRUE)))


per_day %>% ggplot(aes(dt, flights)) +
  geom_line() + geom_point() + geom_smooth()

per_day %>% ggplot(aes(dow, flights)) +
  geom_boxplot()

per_day %>% ggplot(aes(dt, dep)) +
  geom_line() + geom_point() + geom_smooth()

per_day %>% ggplot(aes(dow, dep)) +
  geom_boxplot()

per_day %>% ggplot(aes(dt, distance)) +
  geom_line() + geom_point() + geom_smooth()

per_day %>% ggplot(aes(dow, distance)) +
  geom_boxplot()
