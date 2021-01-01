# Title     : important_variables
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/important_variables.html



# ＜ポイント＞
# - 指定された変数重要度に基づいて、ランキング上位の変数名を取得する
# - 回帰問題と分類問題の両方に対応している


library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)





#%% randomForest ----------------------------------------------------

# ランダムフォレストの実行
forest <- randomForest(Species ~ ., data = iris, localImp = TRUE, ntree = 300)


# 変数重要度上位の変数名
forest %>%
  measure_importance() %>%
  important_variables(k = 2)





#%% ranger ----------------------------------------------------

# ランダムフォレストの実行
forest <- ranger(Species ~ ., data = iris, localImp = TRUE, ntree = 300)


# 変数重要度上位の変数名
forest %>%
  measure_importance() %>%
  important_variables(k = 2)


