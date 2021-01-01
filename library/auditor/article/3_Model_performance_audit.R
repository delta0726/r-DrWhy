# Title     : Model Performance audit
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/articles/model_performance_audit.html

# ＜ポイント＞
# - 半正規プロットは、統計モデルの適合度を評価するために設計されたツール
# - 半正規分布からの理論的次数統計に対してプロットされた標準化残差の順序付き絶対値に対応します。


library(tidyverse)
library(randomForest)
library(DALEX)
library(auditor)


# データロード
data(dragons)


# データ確認
dragons %>% as_tibble()
dragons %>% glimpse()


# モデル構築
# --- 線形回帰モデル
# --- ランダムフォレスト
set.seed(59)
lm_model <- lm(life_length ~ ., data = dragons)
rf_model <- randomForest(life_length ~ ., data = dragons)


# Explainer構築
lm_exp <- lm_model %>% explain(label = "lm", data = dragons, y = dragons$life_length)
rf_exp <- rf_model %>% explain(label = "rf", data = dragons, y = dragons$life_length)



#%% 通常メトリックで比較 --------------------------------------------------------

# モデルパフォーマンス
lm_mp <- lm_exp %>% model_performance()
rf_mp <- rf_exp %>% model_performance()


# 確認
lm_mp
rf_mp


# プロット
plot(lm_mp, rf_mp)



#%% 独自定義のメトリックで比較 --------------------------------------------------------

# 新しいスコアを定義
new_score <- function(object) sum(sqrt(abs(object$residuals)))


# モデルパフォーマンス
lm_mp2 <- model_performance(lm_exp,
                          score = c("mae", "mse", "rec", "rroc"),
                          new_score = new_score)

rf_mp2 <- model_performance(rf_exp,
                          score = c("mae", "mse", "rec", "rroc"),
                          new_score = new_score)



# プロット
plot(lm_mp2, rf_mp2)

