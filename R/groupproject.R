#STATS 506 Group Project

#One Way ANOVA

diet.R = read.csv("./diet.csv", header = TRUE)
diet.R<-na.omit(diet.R)

diet.R$Diet = as.factor(diet.R$Diet)
diet.R$gender <- factor(diet.R$gender,c(0,1))

diet.R$weightlost<-diet.R$pre.weight - diet.R$weight6weeks

head(diet.R)

Diet.female = subset(diet.R, gender==0)
Diet.male = subset(diet.R, gender==1)

head(Diet.female)

anovaFemale<-aov(weightlost~Diet, data = Diet.female)
summary(anovaFemale)

anovaMale<-aov(weightlost~Diet, data = Diet.male)
summary(anovaMale)

#confint(anovaFemale)
#plot(confint(anovaFemale))

library(ggplot2)
#ggplot(anovaFemale, aes(x=Diet, y=weightlost)) + 
#  geom_point(size = 4) + 
#  geom_errorbar(aes(ymax = stuff, ymin = stuff))

kruskal.test(weightlost~Diet, data = Diet.female)
kruskal.test(weightlost~Diet, data = Diet.male)


#Two-way ANOVA

anova2 <- aov(weightlost~gender*Diet,data=diet.R)
summary(anova2)
