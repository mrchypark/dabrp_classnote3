# data.table 패키지가 있는지 확인하고 없으면 설치합니다.
if (!requireNamespace("data.table")) install.packages("data.table")
# data.table 패키지를 사용할 수 있게 불러옵니다.
library(data.table)
# tran.csv 파일이 data/recomen 폴더에 있는지 확인 합니다.
chk<-dir("./data/recomen", pattern = "tran.csv")
# 없으면 다운로드합니다.
if(identical(chk,character(0))){
  recoment<-"http://rcoholic.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
  download.file(recoment,destfile="./data/recomen/tran.csv",mode='wb')
}
# fread 함수를 이용해서 csv 파일을 R객체로 불러옵니다.
chennel<-fread("./data/recomen/chennel.csv")
competitor<-fread("./data/recomen/competitor.csv")
customer<-fread("./data/recomen/customer.csv")
item<-fread("./data/recomen/item.csv")
membership<-fread("./data/recomen/membership.csv")
tran<-fread("./data/recomen/tran.csv")

#메모리 로드된 객체를 바로 호출하여 사용 가능함
head(tran)
tail(tran)

#맥에서 한글 깨짐현상 설정방법
#Sys.getlocale()
#Sys.setlocale("LC_ALL","ko_KR.UTF-8")




