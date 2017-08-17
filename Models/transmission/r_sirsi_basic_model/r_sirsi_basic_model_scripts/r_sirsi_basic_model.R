# DengueME Models Library
# @id r_sirsi_basic_model
# @name SIR-SI Basic Model
# @version 1.0
# @interpreter R v3.4.1
# @example A Susceptible-Infected-Recovered-Susceptible-Infected (SIR-SI) basic model.
# @authors Fellipe Prado, Tiago Lima
# @description SIR-SI basic model is a simplified version of the model proposed by Nishiura (2006). For a complete description of such model please see the paper Nishiura (2006), "Mathematical and Statistical Analyses of the Spread of Dengue", Dengue Bulletin, Volume 30, 2006.

# DEPENDENCIES
library('deSolve')

# ODE SIR-SI function
odeSIRSI <- function(time, state, parameters) {
  
  with(as.list(c(state, parameters)), {
    
    Nh <- Sh + Ih + Rh
    
    dSh <-  (-(betah * bitting)/Nh) * (Sh * Iv)
    dIh <-  ((betah * bitting)/Nh) * (Sh * Iv) - (gamma * Ih)
    dRh <-  (gamma * Ih)
    
    Nv <- Sv + Iv
    
    dSv <-  (-((betav * bitting)/Nh) * (Sv * Ih))
    dIv <-  (((betav * bitting)/Nh) * (Sv * Ih))
    
    return(list(c(dSh, dIh, dRh, dSv, dIv), Nh = Nh, Nv = Nv))
  })
}

# Initial conditions of the population
init <- c(Sh = Sh, Ih = Ih, Rh = Rh, Sv = Sv, Iv = Iv)
parameters <- c(betah = betah, betav = betav, gamma = gamma, bitting = bitting)
times <- seq(from = 0, to = steps, by = 1)

simulation <- as.data.frame(lsoda(y = init, times = times, func = odeSIRSI, parms = parameters))
head(simulation)
tail(simulation)

# Results
if(output){
  if(outChart){
    plot(x = simulation$time, y = simulation$Sh, type = outChartStyle[1], col = outChartColor[1], xlab = "Time", ylab = "", ylim = c(0, max(simulation)))
    lines(x = simulation$time, y = simulation$Ih, type = outChartStyle[2], col = outChartColor[2])
    lines(x = simulation$time, y = simulation$Rh, type = outChartStyle[3], col = outChartColor[3])
    lines(x = simulation$time, y = simulation$Sv, type = outChartStyle[4], col = outChartColor[4])
    lines(x = simulation$time, y = simulation$Iv, type = outChartStyle[5], col = outChartColor[5])
  }
  if(outChartHuman){
    plot(x = simulation$time, y = simulation$Sh, type = outChartHumanStyle[1], col=outChartHumanColor[1], xlab="Time", ylab = "Humans")
    lines(x = simulation$time, y = simulation$Ih, type = outChartHumanStyle[2], col=outChartHumanColor[2])
    lines(x = simulation$time, y = simulation$Rh, type = outChartHumanStyle[3], col=outChartHumanColor[3])
    lines(x = simulation$time, y = simulation$Nh, type = outChartHumanStyle[4], col=outChartHumanColor[4], pch=20)
  }
  if(outChartVector){
    plot(x = simulation$time, y = simulation$Sv, type = outChartVectorStyle[1], col=outChartVectorColor[1], xlab="Time", ylab = "Vector")
    lines(x = simulation$time, y = simulation$Iv, type = outChartVectorStyle[2], col=outChartVectorColor[2])
    lines(x = simulation$time, y = simulation$Nv, type = outChartVectorStyle[3], col=outChartVectorColor[3], pch=20)
    
  }
  if (outTextScreen) {
    lastRow <- simulation[nrow(simulation),]
    row.names(lastRow) <- NULL
    View(lastRow[ c("time", outTextScreenSelect) ])
  }
  if (outVisualTable)
    View(simulation[ c("time", outVisualTableSelect) ] )
  if (outLog)
    write.table(x = simulation[ c("time", outLogSelect) ], file = outLogFile, append = !outLogOverwrite, quote = FALSE, sep = outLogSeparator, col.names = TRUE)
}