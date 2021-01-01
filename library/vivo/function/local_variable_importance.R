# Title     : local_variable_importance
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/vivo/reference/local_variable_importance.html


# ＜ポイント＞
# - 変数のベクトルに関して条件付き最小深さの平均を計算する


# ＜構文＞
# local_variable_importance(
#  profiles,
#  data,
#  absolute_deviation = TRUE,
#  point = TRUE,
#  density = TRUE,
#  grid_points = 101
#  )

# absolute_deviation
# TRUE : absolute deviation
# FALSE: root from average squares

# point
# TRUE : distance from f(x)
# FALSE: a distance from average profiles

# density
# TRUE : weighted based on the density of variable
# FALSE: not weighted




library(tidyverse)
library(DALEX)
library(vivo)
library(randomForest)
library(ingredients)


data(apartments)


# データロード
data(apartments)


# データ確認
apartments %>% as_tibble()
apartments %>% glimpse()


# モデル構築
apartments_rf_model <-
  randomForest(m2.price ~ construction.year + surface + floor + no.rooms,
               data = apartments)


# モデル解釈(DALEX)
explainer_rf <-
  apartments_rf_model %>%
    explain(data = apartmentsTest[,2:5], y = apartmentsTest$m2.price)


# 新しいレコード
new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)
new_apartment %>% print()


# 新しいレコードのプロファイル
# --- ceteris_paribus()
profiles <- explainer_rf %>% ceteris_paribus(new_apartment)
profiles %>% print()



#%% ローカル変数重要度の計算 ----------------------------------------------

profiles %>%
  local_variable_importance(apartments[,2:5],
                            absolute_deviation = TRUE,
                            point = TRUE,
                            density = TRUE)


profiles %>%
  local_variable_importance(apartments[,2:5],
                            absolute_deviation = TRUE,
                            point = TRUE,
                            density = FALSE)

profiles %>%
  local_variable_importance(apartments[,2:5],
                            absolute_deviation = TRUE,
                            point = FALSE,
                            density = TRUE)


#%% プロット ----------------------------------------------

# ローカル変数重要度
measure <-
  profiles %>%
    local_variable_importance(apartments[,2:5],
                              absolute_deviation = TRUE,
                              point = TRUE,
                              density = TRUE)

# プロット
measure %>% plot()


