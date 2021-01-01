# Title     : Model residuals audit
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/articles/model_residuals_audit.html



# ＜ポイント＞
# -




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


# 残差分析
lm_mr <- lm_exp %>% model_residual()
rf_mr <- rf_exp %>% model_residual()


# 確認
lm_mr %>% glimpse()
rf_mr %>% glimpse()



#%% Observed vs predicted ----------------------------------------------

# 正解値と予測値の比較
plot(rf_mr, lm_mr, type = "prediction", abline = TRUE)



plot(rf_mr, lm_mr, variable = "scars", type = "prediction")
plot(rf_mr, lm_mr, variable = "height", type = "prediction")






#%% Observed vs predicted ----------------------------------------------

plot(lm_mr, rf_mr, type = "residual")
plot(rf_mr, lm_mr, type = "residual", variable = "_y_hat_")
plot(rf_mr, lm_mr, type = "residual", variable = "scars")

# alternative:
# plot_residual(rf_mr, lm_mr, variable = "_y_hat_")
# plot_residual(rf_mr, lm_mr, variable = "scars")


# Density of Residuals --------------------------------------------------


plot(rf_mr, lm_mr, type = "residual_density")


plot_residual_density(rf_mr, lm_mr, variable = "colour")


# Boxplot Residuals -----------------------------------------------------


plot(lm_mr, rf_mr, type = "residual_boxplot")



# Autocorrelation function of residuals ----------------------------------

plot(lm_mr, type = "acf", variable = "year_of_discovery")

plot(rf_mr, type = "autocorrelation")



# Correlation ----------------------------------

plot(rf_mr, lm_mr, type = "correlation")


# PCA ----------------------------------

plot(rf_mr, lm_mr, type = "pca")



# Regression error characteristic curve (REC) ----------------------

plot(rf_mr, lm_mr, type = "rec")



# Regression receiver operating characteristic (RROC) -----------

plot(rf_mr, lm_mr, type = "rroc")


# Scale location


plot(rf_mr, lm_mr, type = "scalelocation")


# Two-sided empirical cumulative distribution function (TSECDF) ----------

plot(rf_mr, lm_mr, type = "tsecdf")

