# DengueME Models Library
# @id r_seir_basic_model
# @name SEIR Basic Model
# @version 1.0
# @interpreter R v3.4.1
# @example A Susceptible-Exposed-Infected-Recovered (SEIR) basic model
# @authors Fellipe Prado, Tiago Lima
# @description SEIR model is an elaboration over the basic SIR model. For a complete description of such model please see the paper Aron, Joan & Schwartz, Ira. (1984). Seasonality and period-doubling bifurcations in an epidemic model. Journal of theoretical biology. 110. 665-79. 10.1016/S0022-5193(84)80150-2

# DEPENDENCIES
library('deSolve')

# ODE SEIR function
odeSEIR <- function(times, state, parameters){
  
  with(as.list(c(state, parameters)), {
    
    Nh <- Sh + Eh + Ih + Rh
    
    dSh <- -(beta * Sh * (Ih/Nh))
    dEh <- (beta * Sh * (Ih/Nh)) - (sigma * Eh)
    dIh <- (sigma * Eh) - (gamma * Ih)
    dRh <- gamma * Ih
    
    return(list(c(dSh, dEh, dIh, dRh), Nh = Nh))
  })
}

# Initial conditions of the population
init <- c(Sh = Sh, Eh = Eh, Ih = Ih, Rh = Rh)
parameters <- c(beta = beta, gamma = gamma, sigma = sigma)
times <- seq(from = 0, to = steps, by = 1)

simulation <- as.data.frame(lsoda(y = init, times = times, func = odeSEIR, parms = parameters))
head(simulation)
tail(simulation)

# Results
if (output) {
  if (outChart) {
    plot(x = simulation$time, y = simulation$Sh, type = outChartStyle[1], col=outChartColor[1], xlab="Time", ylab = "Humans")
    lines(x = simulation$time, y = simulation$Eh, type = outChartStyle[2], col=outChartColor[2])
    lines(x = simulation$time, y = simulation$Ih, type = outChartStyle[3], col=outChartColor[3])
    lines(x = simulation$time, y = simulation$Rh, type = outChartStyle[4], col=outChartColor[4])
    lines(x = simulation$time, y = simulation$Nh, type = outChartStyle[5], col=outChartColor[5], pch=20)
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