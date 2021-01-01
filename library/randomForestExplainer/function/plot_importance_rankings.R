# Title     : plot_importance_rankings
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_importance_rankings.html





forest <- randomForest::randomForest(Species ~ ., data = iris, localImp = TRUE, ntree = 300)
frame <- measure_importance(forest, measures = c("mean_min_depth", "times_a_root"))
plot_importance_ggpairs(frame, measures = c("mean_min_depth", "times_a_root"))




#%% 回帰問題 --------------------------------------------------

# データロード
data(Boston, package = "MASS")
Boston$chas <- Boston$chas %>% as.logical()


# データ確認
Boston %>% as_tibble()
Boston %>% glimpse()


# ランダムフォレストの実行
forest_reg <- randomForest(medv ~ ., data = Boston, localImp = TRUE, ntree = 200)


# 変数重要度フレームの作成
imp_reg <-
  forest_reg %>%
    measure_importance(measures = c("mean_min_depth", "times_a_root"))


# プロット
imp_reg %>%
  plot_importance_rankings(measures = "mean_min_depth")




#%% 分類問題 --------------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, localImp = TRUE, ntree = 200)


# 変数重要度フレームの作成
imp_cls <-
  forest_cls %>%
    measure_importance(measures = c("mean_min_depth", "times_a_root"))


# プロット
imp_cls %>%
  plot_importance_rankings(measures = "mean_min_depth")