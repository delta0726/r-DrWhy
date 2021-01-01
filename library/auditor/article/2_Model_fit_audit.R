# Title     : Model fit audit
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/articles/model_fit_audit.html

# ＜ポイント＞
# - 半正規プロットは、統計モデルの適合度を評価するために設計されたツール
# - 半正規分布からの理論的次数統計に対してプロットされた標準化残差の順序付き絶対値に対応します。


library(tidyverse)
library(randomForest)
library(DALEX)
library(auditor)



#%% 回帰問題 ---------------------------------------------

# データロード
data(corn, package = "hnp")


# データ確認
corn %>% as_tibble()
corn %>% glimpse()


# プロット作成
corn %>%
  ggplot(aes(x = m, y = y, color = extract)) +
  geom_point() +
  facet_wrap(~extract)


# モデル構築
# --- GEM回帰
set.seed(123)
model_bin <- glm(cbind(y, m - y) ~ extract, family = binomial, data = corn)
model_bin %>% print()


# Explainerの作成
bin_exp <- model_bin %>% explain(data = corn, y = corn$y)


# 正規性分析
bin_hnp <- bin_exp %>% model_halfnormal()


# プロット
# --- 正規性を確認
bin_hnp %>% plot(sim = 500)


# プロット
# --- 正規性を確認
bin_hnp %>% plot(quantiles = TRUE)




#%% 分類問題 ---------------------------------------------


# モデル構築
# --- ランダムフォレスト
iris_rf <- randomForest(Species ~ ., data = iris)
iris_rf %>% print()


# Explainerの作成
iris_rf_exp <- iris_rf %>% explain(data = iris, y = as.numeric(iris$Species) - 1)


# 正規性分析
iris_rf_hnp <- iris_rf_exp %>% model_halfnormal()
iris_rf_hnp %>% dim()


# プロット
iris_rf_hnp %>% plot_halfnormal()


