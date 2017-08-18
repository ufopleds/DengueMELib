-- DengueME Models Library
-- @id tme_seir_basic_model
-- @name SEIR Basic Model
-- @version 1.0
-- @interpreter TerraME 2.0-RC-4
-- @example A Susceptible-Exposed-Infected-Recovered (SEIR) basic model
-- @authors Fellipe Prado, Tiago Lima
-- @description SEIR model is an elaboration over the basic SIR model. For a complete description of such model please see the paper Aron, Joan & Schwartz, Ira. (1984). Seasonality and period-doubling bifurcations in an epidemic model. Journal of theoretical biology. 110. 665-79. 10.1016/S0022-5193(84)80150-2

world = Model {
   Sh = Sh,
   Eh = Eh,
   Ih = Ih, 
   Rh = Rh,
   Nh = Sh + Eh + Ih + Rh,
   beta = beta,
   gamma = gamma,
   sigma = sigma,
   
   finalTime = steps,
        
   init = function(model)
      
      -- Output: Chart
      if (outChart) then
         model.chart = Chart { target = model, select = outChartSelect, label= outChartLabel, style = outChartStyle, color = outChartColor, title = outChartTitle, xLabel = outChartXLabel, yLabel = outChartYLabel }
      end
      
      -- Output: TextScreen
      if (outTextScreen) then         
         model.text = TextScreen { target = model, select = outTextScreenSelect }
      end
      
      -- Output: VisualTable
      if (outVisualTable) then         
         model.text = VisualTable { target = model, select = outVisualTableSelect }
      end
      
      -- Output: Log
      if (outLog) then         
         model.text = Log { target = model, select = outLogSelect, file = outLogFile, separator = outLogSeparator, overwrite = outLogOverwrite }
      end
      
      if (output) then
         model:notify()
      end
      
      model.timer = Timer{
         Event{action = function(ev)
            local new_infections = model.beta * model.Sh * (model.Ih / model.Nh )    -- beta = infection_rate
            if new_infections > model.Sh then
               new_infections = model.Sh
            end
            
            model.Sh = model.Sh - (model.beta * model.Sh * (model.Ih / model.Nh ))
            model.Eh = model.Eh + ((model.beta * model.Sh * (model.Ih / model.Nh )) - (model.sigma * model.Eh))
            model.Ih = model.Ih + ((model.sigma * model.Eh) - (model.gamma * model.Ih))
            model.Rh = model.Rh + (model.gamma * model.Ih)

            if (output) then
               model:notify(ev)
            end
                
         end}
      }
   end
}

world:run()