# install data.table r 설치
if (!requireNamespace("data.table")) install.packages("data.table")
# install DB Package
if (!require(devtools)) install.packages("devtools")
if (!require(DBI)) devtools::install_github("rstats-db/DBI")
if (!require(RSQLite)) devtools::install_github("rstats-db/RSQLite")

# load package
library(data.table)
library(DBI)
library(RSQLite)

#get channel val from chennel.csv
chennel<-fread("./data/recomen/chennel.csv")

#connect to DB
conn <- dbConnect(RSQLite::SQLite(), dbname = "./FolderForClass2/db_ChangsuuHa.sqlite")
conn

#get table list
dbListTables(conn)

#write table that chennel to dbchen
dbWriteTable(conn, "dbchen", chennel, overwrite = T)

#read DBtable dbchen and compare  r value
if(identical(dbReadTable(conn, "dbchen"),chennel)){
  #same object!
}
