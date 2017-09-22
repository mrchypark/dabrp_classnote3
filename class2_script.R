# 처음에 내 로컬에서 강사님 git과 동기화방법
# git remote -v 로 확인
# 땡겨올 주소 추가: git remote add root http://github.com/mrchypark/dabrp_classnote3
# 이후 확인해 보면 내주소는 origin, 위에 추가한건 root로 되어 있음을 확인
# 그후 git pull origin master 를 입력하면 동기화가 완료됨


# data.table 패키지가 있는지 확인하고 없으면 설치합니다.
if (!requireNamespace("data.table")) install.packages("data.table")

# data.table 패키지를 사용할 수 있게 불러옵니다.
library(data.table)

# tran.csv 파일이 data/recomen 폴더에 있는지 확인 합니다.
chk <- dir("./data/recomen", pattern = "tran.csv")

# 없으면 다운로드합니다.
if (identical(chk, character(0))) {
  recoment <-
    "http://rcoholic.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
  download.file(recoment, destfile = "./data/recomen/tran.csv", mode = 'wb')
}

# fread 함수를 이용해서 csv 파일을 R객체로 불러옵니다.
chennel <- fread("./data/recomen/chennel.csv")
competitor <- fread("./data/recomen/competitor.csv")
customer <- fread("./data/recomen/customer.csv")
item <- fread("./data/recomen/item.csv")
membership <- fread("./data/recomen/membership.csv")
tran <- fread("./data/recomen/tran.csv")



if (!require(devtools)) install.packages("devtools")
## Loading required package: devtools
if (!require(DBI)) devtools::install_github("rstats-db/DBI") 
## Loading required package: DBI
if (!require(RSQLite)) devtools::install_github("rstats-db/RSQLite") 
## Loading required package: RSQLite


library(DBI) 
library(RSQLite) 
library(data.table)

conn <- dbConnect(RSQLite::SQLite(), dbname = "./ForderForClass2/class.sqlite")
conn

dbListTables(conn)
dbWriteTable(conn, "mtcars", mtcars, overwrite = T)
dbListTables(conn)
dbReadTable(conn, "mtcars")

dbRemoveTable(conn, "mtcars")
dbListTables(conn)

#교재 40p 실습
conn <- dbConnect(RSQLite::SQLite(), dbname = "./ForderForClass2/db_kwangho.sqlite")
conn

dbListTables(conn)

chen <- as.data.frame("data/recomen/chennel.csv")
#library(readr)
#chen <- read_csv("data/recomen/chennel.csv")

dbWriteTable(conn, "dbchen", chen, overwrite = T)
dbListTables(conn)

identical(chen, dbReadTable(conn, "dbchen"))

