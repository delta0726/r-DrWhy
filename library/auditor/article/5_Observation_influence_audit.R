# Title     : Observation influence audit
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/articles/observation_influence_audit.html


# ＜ポイント＞
# - クックの距離は、モデルに悪影響を与える可能性がある観測を識別するためのツール（予測の外れ値）
# - クックの距離は、データからi番目の観測値を削除してモデルを再計算することによって計算される
# - 個々のデータが回帰式の推定に及ぼす影響を表した距離
# - lmおよびglm以外のモデルクラスの場合、距離は定義から直接計算される
#   ⇒計算が非常に重くなる


# ＜参考＞
# https://my-log-pll97u88.hatenablog.com/entry/2018/11/28/134553



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



# クック距離 -----------------------------------------------------

# LMとGLMのみ計算可能
lm_exp %>% score_cooksdistance(verbose = TRUE)
lm_cd <- lm_exp %>% model_cooksdistance()
lm_cd %>% plot()


## 他のオブジェクトでは実質的に動かない
#rf_exp %>% score_cooksdistance(verbose = TRUE)
#rf_cd <- rf_exp %>% model_cooksdistance()
#rf_cd %>% plot()
