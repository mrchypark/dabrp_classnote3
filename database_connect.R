#라이브러리 설치
if (!require(devtools)) install.packages("devtools") ## Loading required package: devtools
if (!require(DBI)) devtools::install_github("rstats-db/DBI") ## Loading required package: DBI
if (!require(RSQLite)) devtools::install_github("rstats-db/RSQLite") ## Loading required package: RSQLite
#라이브러리 호출
library(DBI) 
library(RSQLite) 
library(data.table)

#연결
conn <- dbConnect(RSQLite::SQLite(), dbname = "./data/ForderForClass2/class2.sqlite") 
#연결 확인
conn
#테이블 조회
dbListTables(conn)

#테이블 만들기 - mtcars는 R에서 기본 제공하는 데이터테이블 객체임
dbWriteTable(conn, "mtcars", mtcars, overwrite=T) 
dbListTables(conn)
dbReadTable(conn, "mtcars")
#테이블 삭제
dbRemoveTable(conn, "mtcars") 
dbListTables(conn)
