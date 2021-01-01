# Title     : plot_multi_way_importance
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_multi_way_importance.html




# ＜構文＞
# plot_multi_way_importance(
#  importance_frame,
#  x_measure = "mean_min_depth",
#  y_measure = "times_a_root",
#  size_measure = NULL,
#  min_no_of_trees = 0,
#  no_of_labels = 10,
#  main = "Multi-way importance plot"
#  )




forest <- randomForest::randomForest(Species ~ ., data = iris, localImp = TRUE)
plot_multi_way_importance(measure_importance(forest))




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


# 変数重要度フレームの出力
result_reg <- forest_reg %>% measure_importance()
result_reg %>% print()


# プロット
result_reg %>% plot_multi_way_importance()



#%% 分類問題 ---------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, ntree = 100)
forest_cls %>% print()


# 変数重要度フレームの出力
result_cls <- forest_cls %>% measure_importance()
result_cls %>% as_tibble()


# プロット
result_cls %>% plot_multi_way_importance()



