library(plyr)
library(ggplot2)
library(data.table)
View(diamonds)
diamondsDT<- data.table(diamonds)
colnames(diamondsDT)
  #####data.table�i�H�V��Ʈw�@�˯���################
            # ����select ��� , ��character���w���n�� with=FALSE
diamondsDT[,list(color,clarity,depth)]
diamondsDT[,c('color','clarity','depth'),with=FALSE]
            # ��ؼg�k���i�H
            
            #���� ���s
            #�w�����U������,�̤�����쪺������s
            #��cut��XIdeal
            #��color��XE
            #��select����즳cut,color.carat,price
setkey(diamondsDT, cut, color)
diamondsDT[J("Ideal","E"),list(cut,color,carat,price)]
             
             #�Ӥ��s�]�i�h��,�u�n��C()�a�J�Y�i
diamondsDT[J("Ideal",c("E","D")),list(cut,color,carat,price)]

             #data.table�� select() sum,mean,MaX.......
            # select cut , mean(price) as price
            # from diamondsDT 
            # group by cut
diamondsDT[,list(price=mean(price)),by=cut]

            #group by cut,color ,��Price��mean, ��carat�]��mean
            #��list�N�Q�nselect���F��]�_��
            #�̫�]��dataframe
df <- diamondsDT[,
           list(price.mean=mean(price),carat.mean=mean(carat)),
           by=list(cut,color)] %>% 
  data.frame(stringsAsFactors = FALSE)
str(df)

