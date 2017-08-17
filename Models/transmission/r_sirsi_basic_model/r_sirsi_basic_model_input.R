# DengueME Models Library
# @id r_sirsi_basic_model
# @name SIR-SI Basic Model
# @version 1.0
# @interpreter R v3.4.1
# @example A Susceptible-Infected-Recovered-Susceptible-Infected (SIR-SI) basic model.
# @authors Fellipe Prado, Tiago Lima
# @description SIR-SI basic model is a simplified version of the model proposed by Nishiura (2006). For a complete description of such model please see the paper Nishiura (2006), "Mathematical and Statistical Analyses of the Spread of Dengue", Dengue Bulletin, Volume 30, 2006.

# INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')

# DEPENDENCIES
MODEL_RVERSION <- "3.4.1"
DEPENDENCIES <- data.frame(lib = c("deSolve", "stats", "grid"), version = c("1.20", "3.4.1", "2.0"), stringsAsFactors = F)

# PATH CONFIG
BASE_PATH <- "C:\\Users\\Fellipe\\Documents\\R\\DengueME\\r_sirsi_basic_model\\"
SCRIPT_PATH <- "C:\\Users\\Fellipe\\Documents\\R\\DengueME\\r_sirsi_basic_model\\r_sirsi_basic_model_scripts"
#BASE_PATH <- "D:/github/workingpath/DengueMELib/Models/transmission/r_sirsi_basic_model"
#SCRIPT_PATH <- "D:/github/workingpath/DengueMELib/Models/transmission/r_sirsi_basic_model/r_sirsi_basic_model_scripts"
RESULTS_PATH <- BASE_PATH

# checking dependencies
USER_RVERSION <- package_version(R.version)
USER_PACKINFO <- installed.packages(fields = c("Package", "Version"))
source(paste0(BASE_PATH, "/../../dmelib.r"))
dmelib_check_dependencies(MODEL_RVERSION)

# PARAMETERS
Sh <- 9999 # number of susceptible humans [1-999999999]
Ih <- 1 # number of infectious humans [1-999999999]
Rh <- 0 #  number of recovered humans [1-999999999]
Nh <- 10000 # total population [1-999999999]
Sv <- 20000 # number of susceptible vectors [1-999999999]
Iv <- 0 # number of infectious vectors [1-999999999]
Nv <- 20000 # total vector population [1-999999999]
bitting <- 1 # average number of bites per mosquito per day [0-999]
gamma <- 0.167 # human recovery rate [0-1]
betah <- 0.4 # transmission probability from the vector to human [0-1]
betav <- 0.4 # transmission probability from the human to vector [0-1]


# SIMULATION
steps <- 120 # simulation steps [0-999999999]

# RESULTS
outChart <- TRUE
outChartSelect <- c("Sh", "Ih", "Rh", "Sv", "Iv")
outChartLabel <- c("Susceptible (human)", "Infectious (human)", "Recovered (human)", "Susceptible (vector)", "Infectious (vector)")
outChartStyle <- c("l", "l", "l", "o", "o")
outChartColor <- c("blue", "red", "yellow", "blue", "red")
outChartTitle <- ""
outChartXLabel <- "Time"
outChartYLabel <- ""

outChartHuman <- TRUE
outChartHumanSelect <- c("Sh", "Ih", "Rh", "Nh")
outChartHumanLabel <- c("Susceptible", "Infectious", "Recovered", "Humam Population")
outChartHumanStyle <- c("l", "l", "l", "o")
outChartHumanColor <- c("blue", "red", "yellow", "black")
outChartHumanTitle <- ""
outChartHumanXLabel <- "Time"
outChartHumanHYLabel <- ""

outChartVector <- TRUE
outChartVectorSelect <- c("Sv", "Iv", "Nv")
outChartVectorLabel <- c("Susceptible", "Infectious", "Vector Population")
outChartVectorStyle <- c("l", "l", "o")
outChartVectorColor <- c("blue", "red", "black")
outChartVectorTitle <- ""
outChartVectorXLabel <- "Time"
outChartVectorYLabel <- ""

outTextScreen <- TRUE
outTextScreenSelect <- c("Sh", "Ih", "Rh", "Nh", "Sv", "Iv", "Nv")

outVisualTable <- TRUE
outVisualTableSelect <- c("Sh", "Ih", "Rh", "Nh", "Sv", "Iv", "Nv")

outLog <- TRUE
outLogSelect <- c("Sh", "Ih", "Rh", "Nh", "Sv", "Iv", "Nv")
outLogFile <- paste0(RESULTS_PATH, "/results.csv")
outLogSeparator <- ";"
outLogOverwrite <- TRUE

output <- outChart | outChartHuman | outChartVector | outTextScreen | outVisualTable | outLog

# LOADING MODEL
#source(paste0(SCRIPT_PATH, "/r_sirsi_basic_model.r"))
source(paste0(SCRIPT_PATH, "\\r_sirsi_basic_model.r"))