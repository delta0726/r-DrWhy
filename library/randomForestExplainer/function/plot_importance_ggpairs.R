# Title     : plot_importance_ggpairs
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_min_depth_distribution.html



# ＜構文＞
# plot_importance_ggpairs(
#  importance_frame,
#  measures = NULL,
#  main = "Relations between measures of importance"
#  )



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
  plot_importance_ggpairs(measures = c("mean_min_depth", "times_a_root"))




#%% 分類問題 --------------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, localImp = TRUE, ntree = 200)


# 変数重要度フレームの作成
imp_cls <-
  forest_cls %>%
    measure_importance(measures = c("mean_min_depth", "times_a_root"))

# プロット
imp_cls %>%
  plot_importance_ggpairs(measures = c("mean_min_depth", "times_a_root"))
