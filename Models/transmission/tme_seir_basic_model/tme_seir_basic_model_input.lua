-- DengueME Models Library
-- @id tme_seir_basic_model
-- @name SEIR Basic Model
-- @version 1.0
-- @interpreter TerraME 2.0-RC-4
-- @example A Susceptible-Exposed-Infected-Recovered (SEIR) basic model
-- @authors Fellipe Prado, Tiago Lima
-- @description SEIR model is an elaboration over the basic SIR model. For a complete description of such model please see the paper Aron, Joan & Schwartz, Ira. (1984). Seasonality and period-doubling bifurcations in an epidemic model. Journal of theoretical biology. 110. 665-79. 10.1016/S0022-5193(84)80150-2

-- INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')
io.flush();

-- PATH CONFIG

BASE_PATH = "C:/Users/Fellipe/Documents/ZeroBraneProjects/tme_seir_basic_model"
SCRIPT_PATH ="C:/Users/Fellipe/Documents/ZeroBraneProjects/tme_seir_basic_model/tme_seir_basic_model_scripts"
--BASE_PATH = "D:/github/workingpath/DengueMELib/Models/transmission/tme_seir_basic_model"
--SCRIPT_PATH = "D:/github/workingpath/DengueMELib/Models/transmission/tme_seir_basic_model/tme_seir_basic_model_scripts"
RESULTS_PATH = BASE_PATH

-- PARAMETERS
Sh = 9998 -- number of susceptible humans [1-999999999]
Eh = 1 -- number of exposed humans [1-999999999]
Ih = 1 -- number of infected humans [1-999999999]
Rh = 0 --  number of recovered humans [1-999999999]
Nh = 10000 -- total population
beta = 1.42 -- infection rate [0-100]
gamma = 0.14 -- recovery rate [0-1]
sigma = 0.07 -- exposed to infectious rate [0-1]

-- SIMULATION
steps = 125 -- simulation steps [0-999999999]

-- RESULTS
outChart = true
outChartSelect = {"Sh", "Eh", "Ih", "Rh", "Nh"}
outChartLabel = {"Susceptible", "Exposed", "Infected", "Recovered", "Humam Population"}
outChartStyle = {"lines", "lines", "lines", "lines", "dots"}
outChartColor = {"blue", "green", "red", "yellow", "black"}
outChartTitle = ""
outChartXLabel = "Time"
outChartYLabel = ""

outTextScreen = true
outTextScreenSelect = {"Sh", "Eh", "Ih", "Rh"}

outVisualTable = true
outVisualTableSelect = {"Sh", "Eh", "Ih", "Rh"}

outLog = true
outLogSelect = {"Sh", "Eh", "Ih", "Rh"}
outLogFile = RESULTS_PATH .. "/results.csv"
outLogSeparator = ";"
outLogOverwrite = true

output = outChart or outTextScreen or outVisualTable or outLog

-- LOADING MODEL
dofile(SCRIPT_PATH .. "/tme_seir_basic_model.lua")