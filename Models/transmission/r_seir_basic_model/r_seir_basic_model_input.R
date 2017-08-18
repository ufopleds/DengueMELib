# DengueME Models Library
# @id r_seir_basic_model
# @name SEIR Basic Model
# @version 1.0
# @interpreter R v3.4.1
# @example A Susceptible-Exposed-Infected-Recovered (SEIR) basic model
# @authors Fellipe Prado, Tiago Lima
# @description SEIR model is an elaboration over the basic SIR model. For a complete description of such model please see the paper Aron, Joan & Schwartz, Ira. (1984). Seasonality and period-doubling bifurcations in an epidemic model. Journal of theoretical biology. 110. 665-79. 10.1016/S0022-5193(84)80150-2

# INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')

# DEPENDENCIES
MODEL_RVERSION <- "3.4.1"
DEPENDENCIES <- data.frame(lib = c("deSolve", "stats", "grid"), version = c("1.20", "3.4.1", "2.0"), stringsAsFactors = F)

# PATH CONFIG
BASE_PATH <- "D:/github/workingpath/DengueMELib/Models/transmission/r_seir_basic_model"
SCRIPT_PATH <- "D:/github/workingpath/DengueMELib/Models/transmission/r_seir_basic_model/r_seir_basic_model_scripts"
RESULTS_PATH <- BASE_PATH

# checking dependencies
USER_RVERSION <- package_version(R.version)
USER_PACKINFO <- installed.packages(fields = c("Package", "Version"))
source(paste0(BASE_PATH, "/../../dmelib.r"))
dmelib_check_dependencies(MODEL_RVERSION)

# PARAMETERS
Sh <- 9998 # number of susceptible humans [1-999999999]
Eh <- 1 # number of exposed humans [1-999999999]
Ih <- 1 # number of infected humans [1-999999999]
Rh <- 0 #  number of recovered humans [1-999999999]
Nh <- 10000 # total population
beta <- 1.42 # infection rate [0-100]
gamma <- 0.14 # recovery rate [0-1]
sigma <- 0.07 # exposed to infectious rate [0-1]

# SIMULATION
steps <- 125 # simulation steps [0-999999999]

# RESULTS
outChart <- TRUE
outChartSelect <- c("Sh", "Eh", "Ih", "Rh", "Nh")
outChartLabel <- c("Susceptible", "Exposed", "Infected", "Recovered", "Humam Population")
outChartStyle <- c("l", "l", "l", "l", "o")
outChartColor <- c("blue", "green", "red", "yellow", "black")
outChartTitle <- ""
outChartXLabel <- "Time"
outChartYLabel <- "Humans"

outTextScreen <- TRUE
outTextScreenSelect <- c("Sh", "Eh", "Ih", "Rh")

outVisualTable <- TRUE
outVisualTableSelect <- c("Sh", "Eh", "Ih", "Rh")

outLog <- TRUE
outLogSelect <- c("Sh", "Eh", "Ih", "Rh", "Nh")
outLogFile <- paste0(RESULTS_PATH, "/results.csv")
outLogSeparator <- ";"
outLogOverwrite <- TRUE

output <- outChart | outTextScreen | outVisualTable | outLog

# LOADING MODEL
source(paste0(SCRIPT_PATH, "/r_seir_basic_model.r"))