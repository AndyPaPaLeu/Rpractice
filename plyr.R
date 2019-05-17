library(dplyr)
head(baseball)
View(baseball)
dim(baseball)
str(baseball)

baseball$sf[baseball$year<1954] <- 0
any(is.na(baseball$sf)) #�w�LNA��

sum(is.na(baseball$hbp)) #�ݴX��true(�X��na) 377��
   #�H�������ާ�XNA��
baseball$hbp[is.na(baseball$hbp)]  
baseball$hbp[is.na(baseball$hbp)] <- 0
sum(is.na(baseball$hbp)) #�w�Lna��

#�u�O�d�@�u�����Ʀܤ֬�50�����
baseball <- baseball[baseball$ab >= 50,]

#�s�W�W�S�v�����
baseball$OBP <- with(baseball, (h+bb+hbp)/(ab+bb+hbp+sf))
head(baseball, 20)
   #�o�̬O�p��ӿ����~���W�S�v

sum(baseball$h+baseball$bb)
sum(baseball$h)
sum(baseball$bb)


#�p��Y���ͲPOBP

nrow(as.data.frame((unique(baseball$id)))) #�@1118�W���
nrow(baseball)   #14828�����~���
  #��Ƥ����C�ӿ��C�~���ƾ�

any(is.na(baseball$ab))
any(is.na(baseball$bb))
any(is.na(baseball$hbp))
any(is.na(baseball$sf))
any(is.na(baseball$hbp))
any(is.na(baseball$bb))
any(is.na(baseball$ab))

obp <- function(data){
  c(OBP= with(data, sum(h+bb+hbp)/sum(ab+bb+hbp+sf)),nothing=with(data,sum(h+bb)/sum(ab+bb))) 
  
        #�n��c()�N���G���_��,�̫�ddply�X�Ӫ����G�~�|���OBP�����???????????????,
        #why???????????
  
        #�ͲPOBP,�ҥH�n��sum
        #��Ƥ����C�ӿ��C�~���ƾ�
        #with���,���w�@��dataframe,�N�ઽ���ϥΨ���찵�B��
}
      #�ϥ�ddply�w��C�ӿ��('id'),�p���Ӵβy�ͲP��OBP
careerOBP <- ddply(baseball, .variables = 'id', .fun = obp)
View(careerOBP)
str(careerOBP)
############ �º�m��
df <- as.data.frame(x =careerOBP$OBP, row.names = unique(careerOBP$id) ) 
colnames(df)[1] <- "careerOBP"
View(df)   ######################


w<- cbind(id=careerOBP$id,
          careerOBP =careerOBP[order(careerOBP$OBP, decreasing = TRUE),"OBP"],
          rank=1:nrow(careerOBP)) %>% as.data.frame()

# order(careerOBP$OBP, decreasing = TRUE) �^�ǱƦW�����ު�

View(w)
str(w)
dim(w)

View(careerOBP)
colnames(careerOBP)

a<- matrix(1:16,4)
a
class(a)
b <- 1:5
b
class(b)

the_list <- list(a,b,c=matrix(1:4,2))
result<- llply(the_list,sum)
class(result)
class(result$c)
result[[1]]

#########################  plyr�����U��� ##############################
library(ggplot2)
library(magrittr)
library(plyr)
View(diamonds)

  # each ��ƱN�h�ӻE�X�ާ@�����,�޶i��aggregate��Ƥ� 
df <- aggregate(price ~ cut, diamonds, each(mean,median))
         #�ؼ�: ��ܦU�ؤ���(cut) ����(price)�����ƻP������
class(df$price) #matrix ,why?????????????
class(df$cut) # "ordered" ,"factor" 

temp <- df$price %>% as.data.frame()

df <- cbind(
  cut=as.character(df$cut),    #�쥻�Ofactor�নcharacter�A��^�h
  price_median=temp$median,
  price_mean=temp$mean
) 
str(df)
class(df)
View(df)

  #dataframe �ন idataframe �`�ٰO����ϥ�,��֩�����
ibaseball <- idata.frame(baseball)
          #�ؼ�: �ݦP�@��ID �U���X������
ilist <- dlply(ibaseball,.variables = "id",.fun = nrow)

idf <- ddply(ibaseball,.variables = "id",.fun = nrow)
system.time(ddply(ibaseball,.variables = "id",.fun = nrow))
idf2 <- ddply(baseball,.variables = "id",.fun = nrow)
system.time(ddply(baseball,.variables = "id",.fun = nrow))
str(ilist)
View(ilist)
str(idf)   
idf <- idf %>% rename(row_number=V1)  # tidyverse::dplyr::rename()
View(idf)



