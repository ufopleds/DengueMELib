# Load OR download deSolve package
if(any(installed.packages() == "deSolve")){
  require(deSolve)
}else{
  install.packages("deSolve")
  require(deSolve)
}

# SIR function
sir <- function(times, state, parameters) {
  
  with(as.list(c(state, parameters)), {
    
    Nh <-  (Sh + Ih + Rh)
    new_infections <- (beta * ((Sh * Ih)/Nh))
    
    if(new_infections > Sh) new_infections = Sh
    
    dSh <- -new_infections
    dIh <-  new_infections - (gamma * Ih)
    dRh <-  gamma * Ih
    
    return(list(c(dSh, dIh, dRh)))
  })
}

# Set parameters
## Proportion in each compartment: Susceptible, Infected, Recovered
init       <- c(Sh = Sh, Ih = Ih, Rh = Rh)
## beta: infection parameter; gamma: recovery parameter
parameters <- c(beta = beta, gamma = gamma)
## Time frame
times = times
## Solve using ode (General Solver for Ordinary Differential Equations)
out <- ode(y = init, times = times, func = sir, parms = parameters)
## change results to data frame
out <- as.data.frame(out)
## Delete time variable from the results
out$time <- NULL


# RESULTS
## Check to see if there's a desired output
if(output){
  ### Chart
  if(outChart){
    
    outChartData = out
    
    if(any(outChartSelect == "Nh")){
      outChartData <- cbind(outChartData, rowSums(outChartData))
      colnames(outChartData)[4] <- "Nh"
    }
    
    if(all(outChartSelect != "Sh")){
      outChartData = outChartData$Sh <- NULL
    }
    
    if(all(outChartSelect != "Ih")){
      outChartData = outChartData$Ih <- NULL
    }
    
    if(all(outChartSelect != "Rh")){
      outChartData = outChartData$Rh <- NULL
    }
    
    png(filename = outChartFile, width = 1000, height = 875, res = 113)
    
    matplot(x = times, y = outChartData, type = "l",
            xlab = outChartXLabel, ylab = outChartYLabel, main = outChartTitle,
            col = outChartColor, bty = "l", lty = 1, lwd = 2)
    legend("right", legend = outChartLabel, lty = 1, lwd = 2, col = outChartColor, bty = "n")
    dev.off()
  }
  
  ### Text Screen
  if(outTextScreen){
    
    outTextScreenData = out
    
    if(all(outTextScreenSelect != "Sh")){
      outTextScreenData = outTextScreenData$Sh <- NULL
    }
    
    if(all(outTextScreenSelect != "Ih")){
      outTextScreenData = outTextScreenData$Ih <- NULL
    }
    
    if(all(outTextScreenSelect != "Rh")){
      outTextScreenData = outTextScreenData$Rh <- NULL
    }
    
    print(outTextScreenData)
  }
  
  ### Visual Table
  if(outVisualTable){
    
    outVisualTableData = out
    
    if(all(outVisualTableSelect != "Sh")){
      outVisualTableData = outVisualTableData$Sh <- NULL
    }
    
    if(all(outVisualTableSelect != "Ih")){
      outVisualTableData = outVisualTableData$Ih <- NULL
    }
    
    if(all(outVisualTableSelect != "Rh")){
      outVisualTableData = outVisualTableData$Rh <- NULL
    }
    
    print(outVisualTableData)
  }
  
  ### Log
  if(outLog){
    
    outLogData = out
    
    if(any(outLogSelect == "Nh")){
      outLogData <- cbind(outLogData, rowSums(outLogData))
      colnames(outLogData)[4] <- "Nh"
    }
    
    if(all(outLogSelect != "Sh")){
      outLogData = outLogData$Sh <- NULL
    }
    
    if(all(outLogSelect != "Ih")){
      outLogData = outLogData$Ih <- NULL
    }
    
    if(all(outLogSelect != "Rh")){
      outLogData = outLogData$Rh <- NULL
    }
    
    write.table(outLogData, file = outLogFile, row.names = FALSE, sep = outLogSeparator)
  }
}