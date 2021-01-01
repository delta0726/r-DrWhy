# Title     : min_depth_distribution
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/min_depth_distribution.html



# ＜ポイント＞
# - 木の数ごとに最小深度を計算する
# - plot_min_depth_distribution()でプロット作成も可能
# - 回帰問題と分類問題の両方に対応している


# ＜構文＞
# min_depth_distribution(forest)


# ＜引数＞
# forest: {randomForest}又は{ranger}のオブジェクト、



library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)


# データ確認
iris %>% as_tibble()
iris %>% glimpse()


#%% 回帰問題 ---------------------------------------------

# データロード
data(Boston, package = "MASS")
Boston$chas <- Boston$chas %>% as.logical()


# データ確認
Boston %>% as_tibble()
Boston %>% glimpse()


# ランダムフォレストの実行
forest_reg <- randomForest(medv ~ ., data = Boston)


# 最小深度の分布
result_reg <- forest_reg %>% min_depth_distribution()


# 確認
result_reg$variable %>% table()
result_reg$minimal_depth %>% table()
result_reg %>% pivot_wider(names_from = variable, values_from = minimal_depth)




#%% 分類問題 ---------------------------------------------

# ランダムフォレストの実行
forest <- randomForest(Species ~ ., data = iris, ntree = 100)


# ランダムフォレスト内のすべての木の最小深度値を取得
min_depth_frame <- forest %>% min_depth_distribution()
min_depth_frame %>% as_tibble()


# 確認
min_depth_frame$variable %>% table()
min_depth_frame$minimal_depth %>% table()
min_depth_frame %>% pivot_wider(names_from = variable, values_from = minimal_depth)
