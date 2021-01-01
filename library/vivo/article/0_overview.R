# Title     : Overview
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/vivo/


# ＜概要＞
# - Ceteris Paribus(セトリス・パリバス)はラテン語で｢他のことは一定に保たれる｣｢他のすべては変更されない｣という意味
# - Ceteris Paribusプロットは、他の変数を変更せずにモデルの応答が単一の入力変数の変化にどのように依存するかを示す
# - これらはあらゆる機械学習モデルで機能し、モデル比較により、ブラックモデルの動作をよりよく理解できます。



library(tidyverse)
library(DALEX)
library(vivo)
library(randomForest)
library(ingredients)

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




#%% Ceteris Paribusプロファイル --------------------------------------

# 新しいレコード
new_apartment <- data.frame(construction.year = 1998, surface = 88, floor = 2L, no.rooms = 3)
new_apartment %>% print()


# 新しいレコードのプロファイル
# --- ceteris_paribus()
profiles <- explainer_rf %>% ceteris_paribus(new_apartment)
profiles %>% print()


# プロット
# --- 変数の感応度をラインで表示
# --- 新しいレコードをプロットで表示
profiles %>%
  plot() +
  show_observations(profiles)



#%% Vivoプロファイル --------------------------------------

#  local variable importance via oscillation based on Ceteris Paribus
measure <-
  profiles %>%
    local_variable_importance(apartments,
                              absolute_deviation = TRUE,
                              point = TRUE,
                              density = TRUE)

measure %>% plot()


