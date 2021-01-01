# Title     : measure_importance
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/measure_importance.html



# ＜ポイント＞
# - 指定された変数重要度に基づいて、ランキング上位の変数名を取得する
# - 回帰問題と分類問題の両方に対応している


# ＜構文＞
# measure_importance(
# forest,
# mean_sample = "top_trees",
# measures = NULL
# )


# ＜引数＞
# forest: {randomForest}又は{ranger}のオブジェクト、
#       : measure_importance()のオブジェクト


# ＜出力＞
# 回帰問題: mean_min_depth, accuracy_decrease, gini_decrease, no_of_nodes, times_a_root
# 分類問題: mean_min_depth, mse_increase, node_purity_increase, no_of_nodes, times_a_root




library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)



#%% 回帰問題 ----------------------------------------------------

# データロード
data(Boston, package = "MASS")
Boston$chas <- Boston$chas %>% as.logical()


# ランダムフォレストの実行
forest_reg <- randomForest(medv ~ ., data = Boston)


# 変数重要度上位の変数名を取得
# --- measure_importance()の結果を使用
result_reg <- forest_reg %>% measure_importance()


# 確認
result_reg %>% print()
result_reg %>% glimpse()



#%% 分類問題 ----------------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, localImp = TRUE, ntree = 300)


# 変数重要度上位の変数名を取得
# --- measure_importance()の結果を使用
result_cls <- forest_cls %>% measure_importance()


# 確認
result_cls %>% print()
result_cls %>% glimpse()

