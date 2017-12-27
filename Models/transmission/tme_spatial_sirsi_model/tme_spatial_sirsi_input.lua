
-- DengueME Models Library
-- @id tme_spatial_sirsi_model
-- @name Spatial SIRSI Model
-- @version 1.0
-- @interpreter TerraME 2.0-RC-4
-- @example A Spatial SIRSI model with automato celullar
-- @authors Lucas Saraiva


-- INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')
io.flush();

-- PATH CONFIG
BASE_PATH = "C:/Users/Lucas/Documents/GitHub/Models/DengueMELib/Models/transmission/tme_spatial_sirsi_model"
SCRIPT_PATH = "C:/Users/Lucas/Documents/GitHub/Models/DengueMELib/Models/transmission/tme_spatial_sirsi_model"
RESULTS_PATH = BASE_PATH

-- PARAMETERS
dim = 40 -- number of cells on the grade
Sh = 9999 -- number of susceptible humans [1-999999999]
Ih = 1 -- number of infectious humans [1-999999999]
Rh = 0 --  number of recovered humans [1-999999999]
Nh = 10000 -- total population [1-999999999]
Sv = 20000 -- number of susceptible vectors [1-999999999]
Iv = 0 -- number of infectious vectors [1-999999999]
Nv = 20000 -- total vector population [1-999999999]
biting = 1 -- average number of bites per mosquito per day [0-999]
gamma = 0.167 -- human recovery rate [0-1]
betah = 0.4 -- transmission probability from the vector to human [0-1]
betav = 0.4 -- transmission probability from the human to vector [0-1]
homogenousH = false 
humanMimRange = 700
humanMaxRange = 896
homogenousV = false 
vectorMimRange = 500
vectorMaxRange = 20000

-- SIMULATION
finalTime = 22


-- RESULTS
outChartVectors = true
outChartVectorsSelect= {"Sv", "Iv"}
outChartVectorsLabel = {"Susceptible", "Infected"}
outChartVectorsStyle = {"lines", "lines"}
outChartVectorsColor = {"blue", "red"}

outChartTotal = true
outChartTotalSelect = {"Sh", "Ih", "Rh"}
outChartTotalLabel = {"Susceptible", "Infected", "Recovered"}
outChartTotalStyle = {"lines", "lines", "lines"}
outChartTotalColor = {"blue", "red", "yellow"}

dofile(SCRIPT_PATH .. "/tme_spatial_sirsi_model.lua")