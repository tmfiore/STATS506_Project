#STATS 506 Group Project

#One Way ANOVA

diet.R = read.csv("./diet.csv", header = TRUE)
diet.R = na.omit(diet.R)

diet.R$Diet = as.factor(diet.R$Diet)
diet.R$gender = factor(diet.R$gender,c(0,1))

diet.R$weightlost = diet.R$pre.weight - diet.R$weight6weeks

head(diet.R)

Diet.female = subset(diet.R, gender==0)
Diet.male = subset(diet.R, gender==1)

head(Diet.female)

anovaFemale = aov(weightlost~Diet, data = Diet.female)
summary(anovaFemale)

anovaMale = aov(weightlost~Diet, data = Diet.male)
summary(anovaMale)

TukeyHSD(anovaFemale)
TukeyHSD(anovaMale)

library(gplots)
plotmeans(weightlost~Diet, data = Diet.female)
plotmeans(weightlost~Diet, data = Diet.male)

kruskal.test(weightlost~Diet, data = Diet.female)
kruskal.test(weightlost~Diet, data = Diet.male)


#Two-way ANOVA

anova2 = aov(weightlost~gender*Diet,data=diet.R)
summary(anova2)

