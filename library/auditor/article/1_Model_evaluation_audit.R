# Title     : Model evaluation audit
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/19
# URL       : https://modeloriented.github.io/auditor/articles/model_evaluation_audit.html


library(tidymodels)
library(randomForest)
library(DALEX)
library(auditor)

# データ確認
titanic_imputed %>% as_tibble()
titanic_imputed %>% glimpse()


# モデル構築
# --- GLM
# --- Random Forest
model_glm <- glm(survived ~ ., data = titanic_imputed, family = "binomial")
model_rf  <- randomForest(survived ~ ., data = titanic_imputed)


# Explainer構築
exp_glm <- model_glm %>% explain(data = titanic_imputed, y = titanic_imputed$survived, verbose = FALSE)
exp_rf  <- model_rf %>% explain(data = titanic_imputed, y = titanic_imputed$survived, verbose = FALSE)


# モデル評価
eva_glm <- exp_glm %>% model_evaluation()
eva_rf  <- exp_rf  %>% model_evaluation()


# プロット
plot(eva_glm, eva_rf, type = "roc")
plot(eva_glm, eva_rf, type = "lift")