# Title     : How to use multilabel classification and DALEX?
# Objective : TODO
# Created by: Owner
# Created on: 2020/06/21
# URL       : https://modeloriented.github.io/DALEX/articles/multilabel_classification.html



library("DALEX")
data(HR)
head(HR)


library("ranger")
model_HR_ranger <- ranger(status~.,  data = HR, probability = TRUE, num.trees = 50)
model_HR_ranger


library("DALEX")
explain_HR_ranger <- explain(model_HR_ranger,
                              data = HR[,-6],
                              y = HR$status,
                              label = "Ranger Multilabel Classification",
                              colorize = FALSE)



library("DALEX")
explain_HR_ranger_new_y <- explain(model_HR_ranger,
                              data = HR[,-6],
                              y = HR$status,
                              label = "Ranger Multilabel Classification",
                              colorize = FALSE)


mp <- model_parts(explain_HR_ranger_new_y, loss_function = loss_cross_entropy)
plot(mp)



mp_p <- model_profile(explain_HR_ranger, variables = "salary", type = "partial")
mp_p$color <- "_label_"
plot(mp_p)


mp_a <- model_profile(explain_HR_ranger, variables = "salary", type = "accumulated")
mp_a$color = "_label_"
plot(mp_a)



bd <- predict_parts(explain_HR_ranger, HR[1,], type = "break_down")
plot(bd)


shap <- predict_parts(explain_HR_ranger, HR[1,], type = "shap")
plot(shap)


(mp <- model_performance(explain_HR_ranger))


plot(mp)


pd_all <- predict_diagnostics(explain_HR_ranger, HR[1,])
plot(pd_all)


pd_salary <- predict_diagnostics(explain_HR_ranger, HR[1,], variables = "salary")
plot(pd_salary)