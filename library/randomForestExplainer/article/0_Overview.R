# Title     : Overview
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/randomForestExplainer/index.html




library(tidyverse)
library(randomForest)
library(ranger)
library(randomForestExplainer)


# データロード
data(Boston, package = "MASS")
Boston$chas <- Boston$chas %>% as.logical()


# データ確認
Boston %>% as_tibble()
Boston %>% glimpse()


# ランダムフォレストの実行
# --- {randomForest}
set.seed(2017)
forest_rf <- randomForest(medv ~ ., data = Boston, localImp = TRUE)
forest_rf %>% print()


# ランダムフォレストの実行
# --- {ranger}
set.seed(2017)
forest_rg <- ranger(medv ~ ., data = Boston, importance = "impurity")
forest_rg %>% print()


# モード
forest <- forest_rf
forest <- forest_rg



#%% 最小深度値 -------------------------------------------------

# ランダムフォレスト内のすべての木の最小深度値を取得
min_depth_frame <- forest %>% min_depth_distribution()
min_depth_frame %>% as_tibble()


# 確認
min_depth_frame$variable %>% table()
min_depth_frame$minimal_depth %>% table()
min_depth_frame %>% pivot_wider(names_from = variable, values_from = minimal_depth)


# 最小深度の分布をプロット
min_depth_frame %>% plot_min_depth_distribution()


# 最小深度の分布をプロット
# --- 最小深度を指定
min_depth_frame %>%
  plot_min_depth_distribution(mean_sample = "relevant_trees", k = 15)




#%% 変数重要度 -------------------------------------------------

# 変数重要度フレームを取得
importance_frame <- forest %>% measure_importance()
importance_frame %>% as_tibble()


# plot_multi_way_importance(forest, size_measure = "no_of_nodes") # gives the same result as below but takes longer
importance_frame %>%
  plot_multi_way_importance(size_measure = "no_of_nodes")


importance_frame %>%
  plot_multi_way_importance(x_measure = "mse_increase",
                            y_measure = "node_purity_increase",
                            size_measure = "p_value",
                            no_of_labels = 5)




# plot_importance_ggpairs(forest) # gives the same result as below but takes longer
importance_frame %>% plot_importance_ggpairs()



# plot_importance_rankings(forest) # gives the same result as below but takes longer
importance_frame %>% plot_importance_rankings()



# 変数重要度フレームから重要度の高い説明変数を取得
# --- 変数重要度フレームから計算
vars <-
  importance_frame %>%
    important_variables(k = 5,
                        measures = c("mean_min_depth", "no_of_trees"))


# --- RFオブジェクトから実行すると変数重要度フレームの作成も同時に行われる
vars <-
  forest %>%
    important_variables(k = 5,
                        measures = c("mean_min_depth", "no_of_trees"))




#%% 条件付き最小深度の平均 -------------------------------------------------

# ＜ポイント＞
# - 変数重要度の最も高い変数セットを見つけたら、それらに関する相互作用を分析する。


# 条件付き最小深度
interactions_frame <- forest %>% min_depth_interactions(vars)


# 確認
interactions_frame[order(interactions_frame$occurrences, decreasing = TRUE), ] %>% head()


# プロット
interactions_frame %>% plot_min_depth_interactions()




interactions_frame <-
  forest %>%
    min_depth_interactions(vars,
                           mean_sample = "relevant_trees",
                           uncond_mean_sample = "relevant_trees")


interactions_frame %>% plot_min_depth_interactions()



#%% グリッド上の森林の予測 -------------------------------------------------


# - 2つの変数の値のグリッドに対して予測値をプロット
forest %>% plot_predict_interaction(Boston, "rm", "lstat")
forest$predictions %>% as_tibble()



# Rmarkdownレポートの作成---------------------------------------

# forest %>% explain_forest(interactions = TRUE, data = Boston)


