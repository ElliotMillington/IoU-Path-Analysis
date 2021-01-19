library(lavaan)
library(semPlot)
library(simulator)
library(tidyverse)

n <- 100
mu <- 0
sd <- 0

None.Data <- tibble(
  SUR = rnorm(n),
  SOR = rnorm(n),
  IoU = rnorm(n),
  Anx = rnorm(n),
  RMB = rnorm(n),
  SRB = rnorm(n)
)

Wigham.Model <- "SUR =~ RMB + SRB
                 SOR =~ RMB + IoU
                 IoU =~ Anx
                 Anx =~ SRB"

Alt.Wigham.Model <- "SUR =~ RMB + SRB
                     SOR =~ RMB + IoU
                     IoU =~ Anx
                     Anx =~ SRB + SOR"

semPaths(semPlotModel_lavaanModel(Wigham.Model))
semPaths(semPlotModel_lavaanModel(Alt.Wigham.Model))

Wigham.Fit <- sem(Wigham.Model, data = None.Data, estimator = "MLR")

Wigham.data <- simulateData(Wigham.Model, sample.nobs = 100)
fitted(sem(Wigham.Model))