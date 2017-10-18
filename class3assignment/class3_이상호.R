# 패키지 불러오기
library(data.table)
library(dplyr)

# 파일 불러오기
chennel <-
  fread("./data/recomen/chennel.csv",
        header = T,
        stringsAsFactors = F)
competitor <-
  fread("./data/recomen/competitor.csv",
        header = T,
        stringsAsFactors = F)
customer <-
  fread("./data/recomen/customer.csv",
        header = T,
        stringsAsFactors = F)
item <-
  fread("./data/recomen/item.csv",
        header = T,
        stringsAsFactors = F)
membership <-
  fread("./data/recomen/membership.csv",
        header = T,
        stringsAsFactors = F)
tran <-
  fread("./data/recomen/tran.csv",
        header = T,
        stringsAsFactors = F)

# 데이터 상태 확인
head(chennel)
head(competitor)
head(customer)
head(item)
head(membership)
head(tran)

str(chennel)
str(competitor)
str(customer)
str(item)
str(membership)
str(tran)

# 1번 문제 - 답: 154121
tranForQ1 <- filter(tran, `receiptNum` ==  6998419)
sum(tranForQ1$`amount`)
rm(tranForQ1)

# 2번 문제 - 답: 명품 명품잡화
tranForQ2 <-
  distinct(tran, `cate_1`, `cate_2`, `cate_3`, `amount`) %>% arrange(desc(`amount`))
tranForQ2$amount[1] == tranForQ2$amount[2]
item$cate_2_name[which(
  item$cate_1 == tranForQ2$cate_1[1] &
    item$cate_2 == tranForQ2$cate_2[1] &
    item$cate_3 == tranForQ2$cate_3[1]
)]
item$cate_3_name[which(
  item$cate_1 == tranForQ2$cate_1[1] &
    item$cate_2 == tranForQ2$cate_2[1] &
    item$cate_3 == tranForQ2$cate_3[1]
)]
rm(tranForQ2)

# 3번 문제 - 답: MOBILE/APP (MOBILE/APP: 106988, ONLINEMALL: 12748)
unique(chennel$chennel)
chennelForQ3 <- chennel
chennelForQ3$chennel[grep("MOBILE/APP", chennelForQ3$chennel)] <- "MOBILE/APP"
chennelForQ3$chennel[grep("ONLINEMALL", chennelForQ3$chennel)] <- "ONLINEMALL"
group_by(chennelForQ3, `chennel`) %>% summarise(sum = sum(`useCnt`, na.rm = T))
rm(chennelForQ3)

# 4번 문제 - 답: storeCode = 1
tranForQ4 <- filter(tran, `date` >= 20150301 & `date` < 20150401) %>% group_by(`storeCode`) %>% summarise(sum = sum(`amount`, na.rm = T)) %>% arrange(desc(sum))
tranForQ4$storeCode[1]
rm(tranForQ4)

# 5번 문제 - 답: 여성 (여성: 22517, 남성: 5642)
competitorForQ5 <- left_join(competitor, select(customer, `cusID`, `sex`), by = "cusID") %>% group_by(`sex`) %>% summarise(count = n()) %>% arrange(desc(`count`))
competitorForQ5$sex[1]
rm(competitorForQ5)

# 6번 문제 - 답: B100305 (223660회 포함)
tranForQ6 <- tran
targetReceiptNum <- count(tranForQ6, receiptNum) %>% filter(`n` > 2)
tranForQ6 <- left_join(tranForQ6, targetReceiptNum, by = "receiptNum")
tranForQ6 <- tranForQ6[which(!is.na(tranForQ6$n)), ]
tranForQ6 <- tranForQ6 %>% group_by(`cate_3`) %>% summarise(count = n()) %>% arrange(desc(`count`))
tranForQ6$count[1] == tranForQ6$count[2]
tranForQ6$cate_3[1]
