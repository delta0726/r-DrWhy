# Title     : plot_min_depth_interactions
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/randomForestExplainer/reference/plot_min_depth_interactions.html




# ＜構文＞
# plot_min_depth_interactions(
#  interactions_frame,
#  k = 30,
#  main = paste0("Mean minimal depth for ", paste0(k," most frequent interactions"))
#  )




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
result_reg %>% plot_min_depth_interactions()


# プロット
result_reg %>% plot_min_depth_interactions()



#%% 分類問題 ---------------------------------------------

# ランダムフォレストの実行
forest_cls <- randomForest(Species ~ ., data = iris, ntree = 100)
forest_cls %>% print()


# 条件付き最小深度の取得
result_cls <- forest_cls %>% min_depth_interactions(c("Petal.Width", "Petal.Length"))
result_cls %>% as_tibble()


# プロット
result_cls %>% plot_min_depth_interactions()



