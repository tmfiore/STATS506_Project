%% Data Preparation
%%%% STATS 506: Group Project on parametric and non-parametric ANOVA
%%%% Author: Hu Sun
%%%% Date: Nov 19, 2018

% Import dataset from working directory
filename = 'Diet.csv'
Diet = readtable(filename)
Diet = table2dataset(Diet)

% Remove observations with missing values
diet_miss = ismissing(Diet)
Diet = Diet(~any(diet_miss,2),:)

% Independent variable of interest: weightloss after 6 weeks
Diet.weightloss = Diet.pre_weight - Diet.weight6weeks

% Subset of data under each gender
Diet_female = Diet(Diet.gender==0,:)
Diet_male = Diet(Diet.gender==1,:)

%% Task 1: One-Way Anova
% anova for female data
[p_fe_aov,table_fe_aov,stats_fe_aov] = anova1(Diet_female.weightloss,Diet_female.Diet,'off')
% TukeyHSD method for multicomparison
[c_fe_aov,m_fe_aov,h_fe_aov,gnames] = multcompare(stats_fe_aov)

% anova for male data
[p_ma_aov,table_ma_aov,stats_ma_aov] = anova1(Diet_male.weightloss,Diet_male.Diet,'off')
% TukeyHSD method for multicomparison
[c_ma_aov,m_ma_aov,h_ma_aov,gnames] = multcompare(stats_ma_aov)



%% Task2: Two-way Anova

% In two way anova, we use the full sample and let gender and diet be the
% two categorical variables

[p_full,table_full,stats_full] = anovan(Diet.weightloss,{Diet.gender Diet.Diet},'model','interaction','varnames',{'gender' 'diet type'})

[c_full,m_full,h_full,gnames] = multcompare(stats_full,'Dimension',[1 2])


%% Task3: Kruskal-Wallis Test

[p_fe_kw,table_fe_kw,stats_fe_kw] = kruskalwallis(Diet_female.weightloss,Diet_female.Diet)
[p_ma_kw,table_ma_kw,stats_ma_kw] = kruskalwallis(Diet_male.weightloss,Diet_male.Diet)



