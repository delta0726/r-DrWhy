# Title     : plot_min_depth_distribution
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_min_depth_distribution.html





# ＜構文＞
# plot_min_depth_distribution(
#  min_depth_frame,
#  k = 10,
#  min_no_of_trees = 0,
#  mean_sample = "top_trees",
#  mean_scale = FALSE,
#  mean_round = 2,
#  main = "Distribution of minimal depth and its mean"
#  )


# ＜引数＞
# min_depth_frame
# - {randomForest}又は{ranger}のオブジェクト、
# - min_depth_distributionのオブジェクト


library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)



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

# プロット作成
result_reg %>% plot_min_depth_distribution()



#%% 分類問題 ---------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, ntree = 300)

# 最小深度の分布
result_cls <- forest_cls %>% min_depth_distribution()

# プロット作成
result_cls %>% plot_min_depth_distribution()

