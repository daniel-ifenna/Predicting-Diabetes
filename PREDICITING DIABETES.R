Diabetes<- read.csv("data/diabetes_dataset.csv")
summary(Diabetes)
cor(Diabetes)
Diabetes$Labels<- factor(Diabetes$Outcome, levels =  c(0, 1),
                                            labels =  c("Not Diabetic", "Diabetic"))
# USING KNN TO DETERMINE THE OUTCOME 
library(rsample)
set.seed(1234)
Knn_split<- initial_split(Diabetes[-18], .85, Diabetes$Outcome)
Train_data<- training(Knn_split)
Test_data<- testing(Knn_split)
Test_labels<- factor(Test_data$Outcome, levels =  c(0, 1),
                     labels =  c("Not Diabetic", "Diabetic"))
Train_labels<- factor(Train_data$Outcome, levels =  c(0, 1),
                      labels =  c("Not Diabetic", "Diabetic"))
# Build the normalization function 
normalize<- function(x){
  return((x-min(x))/(max(x)-min(x)))
}
normalize(c(0,1,2,3,4))

Test_knn<- as.data.frame(lapply(Test_data[-17], normalize))
Train_knn<- as.data.frame(lapply(Train_data[-17], normalize))

library(class)
one_knn<- knn(Train_knn, Test_knn, cl = Train_labels, k = 5)
one<-table(one_knn, Test_labels)

Accuracy<- round((sum(diag(one))/(sum(one)))*100, digits = 1)
print(Accuracy)                 

Test_data$predicted<- one_knn

second_knn<- knn(Train_knn, Test_knn, cl = Train_labels, k = 15)
library(gmodels)
CrossTable(x= second_knn, y= Test_labels, prop.table= F)
second<-table(second_knn, Test_labels)

Accuracy_second<- round((sum(diag(second))/(sum(second)))*100, digits = 1)
print(Accuracy_second)   


third_knn<- knn(Train_knn, Test_knn, cl = Train_labels, k = 22)
third<-table(third_knn, Test_labels)

Accuracy_third<- round((sum(diag(third))/(sum(third)))*100, digits = 1)
print(Accuracy_third)   




#USING DECISION TREE
library(C50)
library(C50)
set.seed(257)
Test_Tree<- Test_data[-17]
Train_Tree<- Train_data
Train_Tree<- Train_Tree[-17]
Train_Tree$labels<- as.factor(Train_labels)
Test_Tree$labels<- as.factor(Test_labels)
Model<- C5.0(Train_Tree$labels~., data= Train_Tree, method = "class")
summary(Model)
Test_Tree$predict<- predict(Model, Test_Tree, type = "class")
s<- table(Test_Tree$predict, Test_Tree$labels)
T.Accuracy<- round((sum(diag(s)))/(sum(s))*100, digits = 1)
print(T.Accuracy)

library(partykit)

D.tree<- as.party(Model)

plot(D.tree, gp = gpar(fontsize = 8)) 


#USING ONERIP AND JRIP

library(RWeka)
Diabetes_one<- OneR(Train_Tree$labels~., data = Train_Tree)
summary(Diabetes_one)

Test_1R<- Test_Tree[-18]
Predict_1R<- predict(Diabetes_one, Test_1R)
R_One<-table(Predict_1R, Test_1R$predicted)
R_Accuracy<- round((sum(diag(R_One)))/(sum(R_One))*100, digits = 1)
print(R_Accuracy)
 

#JRIP
Diabetes_JRIP<- JRip(Train_Tree$labels~., data = Train_Tree)
summary(Diabetes_JRIP)
Jrip_predict<- predict(Diabetes_JRIP, Test_1R)
JRip_matrix<-table(Jrip_predict, Test_1R$predicted)
JRip_Accuracy<- round((sum(diag(JRip_matrix)))/(sum(JRip_matrix))*100, digits = 1)
print(JRip_Accuracy)
