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
  ## Chart
  if(outChart){
    
    outChartData = out
    
    if(any(outChartSelect == "Nh")){
      outChartData <- cbind(out, rowSums(out))
      colnames(outChartData)[4] <- "Nh"
    }
    
    if(all(outChartSelect != "Sh")){
      outChartData = out$Sh <- NULL
    }
    
    if(all(outChartSelect != "Ih")){
      outChartData = out$Ih <- NULL
    }
    
    if(all(outChartSelect != "Rh")){
      outChartData = out$Rh <- NULL
    }
    
    png(filename = outChartFile, width = 1000, height = 875, res = 113)
    
    matplot(x = times, y = outChartData, type = "l",
            xlab = outChartXLabel, ylab = outChartYLabel, main = outChartTitle,
            col = outChartColor, bty = "l", lty = 1, lwd = 2)
    legend("right", legend = outChartLabel, lty = 1, lwd = 2, col = outChartColor, bty = "n")
    dev.off()
  }
  
  ## Text Screen
  if(outTextScreen){
    
    outTextScreenData = out
    
    if(all(outTextScreenSelect != "Sh")){
      outTextScreenData = out$Sh <- NULL
    }
    
    if(all(outTextScreenSelect != "Ih")){
      outTextScreenData = out$Ih <- NULL
    }
    
    if(all(outTextScreenSelect != "Rh")){
      outTextScreenData = out$Rh <- NULL
    }
    
    print(outTextScreenData)
  }
  
  ## Visual Table
  if(outVisualTable){
    outVisualTableData = out
    
    if(all(outVisualTableSelect != "Sh")){
      outVisualTableData = out$Sh <- NULL
    }
    
    if(all(outVisualTableSelect != "Ih")){
      outVisualTableData = out$Ih <- NULL
    }
    
    if(all(outVisualTableSelect != "Rh")){
      outVisualTableData = out$Rh <- NULL
    }
    
    print(outVisualTableData)
  }
  
  ## Log
  if(outLog){
    outLogData = out
    
    if(any(outLogSelect == "Nh")){
      outNh <- matrix(Nh, nrow = dim(out)[1], ncol = 1)
      colnames(outNh) <- "Nh"
      outLogData <- cbind(out, outNh)
    }
    
    if(all(outLogSelect != "Sh")){
      outLogData = out$Sh <- NULL
    }
    
    if(all(outLogSelect != "Ih")){
      outLogData = out$Ih <- NULL
    }
    
    if(all(outLogSelect != "Rh")){
      outLogData = out$Rh <- NULL
    }
    
    write.table(outLogData, file = outLogFile, row.names = FALSE, sep = outLogSeparator)
  }
}