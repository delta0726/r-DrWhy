# Title     : min_depth_interactions
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/min_depth_interactions.html



# ＜ポイント＞
# - 変数のベクトルに関して条件付き最小深さの平均を計算する


# ＜構文＞
# min_depth_interactions(
#  forest,
#  vars = important_variables(measure_importance(forest)),
#  mean_sample = "top_trees",
#  uncond_mean_sample = mean_sample
#  )


# ＜引数＞
# forest: {randomForest}又は{ranger}のオブジェクト、



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
forest_reg %>% print()


# 条件付き最小深度の取得
result_reg <- forest_reg %>% min_depth_interactions(c("medv", "lstat"))
result_reg %>% as_tibble()




#%% 分類問題 ---------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, ntree = 100)
forest_cls %>% print()


# 条件付き最小深度の取得
result_cls <- forest_cls %>% min_depth_interactions(c("Petal.Width", "Petal.Length"))
result_cls %>% as_tibble()

