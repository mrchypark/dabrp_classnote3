if (!requireNamespace("nycflights13")) install.packages("nycflights13")
library(nycflights13)
nycflights13::flights # 어떤 패키지에 속해있는 데이트를 확인하기 위해 :: 사용

str(flights)

if (!requireNamespace("dplyr")) install.packages("dplyr")

library(dplyr)
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
select(flights, time_hour, air_time, everything())
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
flights_sml

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)


bind_rows(
  c(a = 1, b = 2),
  data_frame(a = 3:4, b = 5:6),
  c(a = 7, b = 8)
)

bind_rows(data.frame(x = 1:3), data.frame(y = 1:4))

flights2 <- select(flights, year:day, hour, origin, dest, tailnum, carrier)
flights2

left_join(flights2, airlines, by = "carrier")
