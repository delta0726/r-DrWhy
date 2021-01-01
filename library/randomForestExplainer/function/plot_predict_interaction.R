# Title     : plot_predict_interaction
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_predict_interaction.html



# ＜ポイント＞
# - 2つの説明変数と予測値に対するヒートマップを作成する
# - 回帰問題と分類問題の両方に対応している



# ＜構文＞
# plot_predict_interaction(
# forest,
# data,
# variable1,
# variable2,
# grid = 100,
# main = paste0("Prediction of the forest for different values of ",
# paste0(variable1, paste0(" and ", variable2))),
# time = NULL)


# ＜引数＞
# forest: {randomForest}又は{ranger}のオブジェクト



library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)



#%% 回帰問題 -----------------------------------------------------

# データロード
data(Boston, package = "MASS")
Boston$chas <- Boston$chas %>% as.logical()


# ランダムフォレストの実行
forest <- randomForest(medv ~ ., data = Boston)
forest %>% print()
forest %>% class()


# 2変数と予測値のヒートマップ
forest %>%
  plot_predict_interaction(data = Boston, "rm", "lstat")




# ランダムフォレストの実行
forest_ranger <- ranger(medv ~ ., data = Boston)


# 2変数と予測値のヒートマップ
forest_ranger %>%
  plot_predict_interaction(data = Boston, "rm", "lstat")



#%% 分類問題 -----------------------------------------------------

# ランダムフォレストの実行
forest <- randomForest(Species ~., data = iris)
forest %>% print()
forest %>% class()


# 2変数と予測値のヒートマップ
forest %>%
  plot_predict_interaction(data = iris, "Petal.Width", "Sepal.Width")




# ランダムフォレストの実行
forest_ranger <- ranger(Species ~., data = iris, probability = TRUE)


# 2変数と予測値のヒートマップ
forest_ranger %>%
  plot_predict_interaction(data = iris, "Petal.Width", "Sepal.Width")



