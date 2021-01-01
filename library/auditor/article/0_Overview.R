# Title     : Overview
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/index.html



library(tidyverse)
library(auditor)
library(randomForest)
data(mtcars)


# データ確認
mtcars %>% as_tibble()
mtcars %>% glimpse()


# モデル構築
# --- 線形回帰モデル
# --- ランダムフォレスト
set.seed(123)
model_lm <- lm(mpg ~ ., data = mtcars)
model_rf <- randomForest(mpg ~ ., data = mtcars)


# Explainerの作成
exp_lm <- model_lm %>% DALEX::explain(data = mtcars, y = mtcars$mpg, label = "lm", verbose = FALSE)
exp_rf <- model_rf %>% DALEX::explain(data = mtcars, y = mtcars$mpg, label = "rf", verbose = FALSE)


# 残差分析
mr_lm <- exp_lm %>% model_residual()
mr_rf <- exp_lm %>% model_residual()


# プロット作成
# --- x: wgt
plot_residual(mr_lm, mr_rf, variable = "wt", smooth = TRUE)


# プロット作成
# --- x: Target Variable
plot_residual(mr_lm, mr_rf, smooth = TRUE)