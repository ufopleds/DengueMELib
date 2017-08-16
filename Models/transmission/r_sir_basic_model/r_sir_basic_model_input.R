# DengueME Models Library
# @id r_sir_basic_model
# @name SIR Basic Model
# @version 1.0
# @interpreter R v3.4.1
# @example A Susceptible-Infected-Recovered (SIR) basic model. 
# @authors Tiago Lima, Lucas Saraiva
# @description For a description of such model, please visit <<http://en.wikipedia.org/wiki/Epidemic_model>>

# INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')

# PATH CONFIG
BASE_PATH = "D:/github/workingpath/DengueMELib/Models/transmission/r_sir_basic_model"
SCRIPT_PATH = "D:/github/workingpath/DengueMELib/Models/transmission/r_sir_basic_model/r_sir_basic_model_scripts"
RESULTS_PATH = BASE_PATH

# PARAMETERS
Sh = 9999 # number of susceptible humans [1-999999999]
Ih = 1 # number of infected humans [1-999999999]
Rh = 0 #  number of recovered humans [1-999999999]
Nh = 10000 # total population
beta = 1.06 # infection rate [0-100]
gamma = 0.25 # recovery rate [0-1]

steps = 120
# SIMULATION
times <- seq(0, steps, by = 1) # simulation steps [0-999999999]

# RESULTS
outChart = TRUE
outChartSelect = c("Sh", "Ih", "Rh", "Nh")
outChartLabel = c("Susceptible", "Infected", "Recovered", "Human Population")
outChartStyle = c("lines", "lines", "lines", "dots")
outChartColor = c("blue", "red", "yellow", "black")
outChartTitle = ""
outChartXLabel = "Time"
outChartYLabel = ""
outChartFile = paste0(RESULTS_PATH, "/results.png")

outTextScreen = TRUE
outTextScreenSelect = c("Sh", "Ih", "Rh")

outVisualTable = TRUE
outVisualTableSelect = c("Sh", "Ih", "Rh")

outLog = TRUE
outLogSelect = c("Sh", "Ih", "Rh", "Nh")
outLogFile = paste0(RESULTS_PATH, "/results.csv")
outLogSeparator = ";"
#outLogOverwrite = TRUE

output = outChart || outTextScreen || outVisualTable || outLog

outChartFile = "C:\\Users\\Fellipe\\Documents\\R\\DengueME\\r_sir_basic_model\\results.png"
outLogFile = "C:\\Users\\Fellipe\\Documents\\R\\DengueME\\r_sir_basic_model\\results.csv"

# LOADING MODEL
source("r_sir_basic_model/r_sir_basic_model_scripts/r_sir_basic_model.R")

