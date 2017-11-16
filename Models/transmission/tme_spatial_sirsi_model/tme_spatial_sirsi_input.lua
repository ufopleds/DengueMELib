
-- DengueME Models Library
-- @id tme_sir_basic_model
-- @name SIR Basic Model
-- @version 1.0
-- @interpreter TerraME 2.0-RC-4
-- @example A Susceptible-Infected-Recovered (SIR) basic model. 
-- @authors Lucas Saraiva, Tiago Lima
-- @description For a description of such model, please visit <<http://en.wikipedia.org/wiki/Epidemic_model>>


-- INPUT FILE
print('LOADING INPUT FILE AND RUNNING MODEL')
io.flush();

-- PATH CONFIG
BASE_PATH = "C:/Users/Lucas/Documents/GitHub/Models/DengueMELib/Models/transmission/tme_spatial_sirsi_model"
SCRIPT_PATH = "C:/Users/Lucas/Documents/GitHub/Models/DengueMELib/Models/transmission/tme_spatial_sirsi_model"
RESULTS_PATH = BASE_PATH

-- PARAMETERS
finalTime = 60 
dim = 50 

homogenousH = true 
humanMimRange = 0 
humanMaxRange = 1000 

homogenousV = false 
vectorMimRange = 0
vectorMaxRange = 1000

Sh= 9999
Ih = 1
Rh = 0 			
Sv = 20000
Iv = 0 			
biting = 1
gamma = 0.167
betah = 0.400
betav = 0.400


dofile(SCRIPT_PATH .. "/tme_spatial_sirsi_model.lua")