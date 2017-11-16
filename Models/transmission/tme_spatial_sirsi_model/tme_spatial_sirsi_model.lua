

SpatialSir = Model{

	finalTime = finalTime,
	dim = dim,
	homogenousH = homogenousH,
	humanMimRange = humanMimRange,
	humanMaxRange = humanMaxRange,
	homogenousV = homogenousV,
	vectorMimRange = vectorMimRange,
	vectorMaxRange = vectorMaxRange,
	totalSh = 0,
	totalIh = 0,
	totalRh = 0,
	totalSv = 0, 
	totalIv = 0,
    totalHPop = 0,
	totalVPop = 0,


	init = function(model)
		-- State Machine + Cell
		model.cell = Cell{
			state = "susceptible",
			Sh= 0,
			Ih = 0,
			Rh = 0,	
			Sv = 0,
			Iv = 0,	
			biting = biting,
			gamma = gamma,
			betah = betah,
			betav = betav,

			execute = function(self)	

				-- Verificacao dos vizinhos
				local countNeigh = 0
				forEachNeighbor(self, function(neigh)					
					if neigh.state =="infected" then
						countNeigh = countNeigh + 1
					end

				end)

		   		-- Dinamica dos vizinhos a ser feita
			   	if countNeigh > 2 then	
			   	 	self.betah = self.betah + 0.100
				end


	 			Nh = self.past.Sh + self.past.Ih + self.past.Rh
	 			Nv = self.past.Sv + self.past.Iv


			    local new_human_infections = (self.betah * self.biting/Nh) * self.past.Sh * self.past.Iv
	            if new_human_infections > self.past.Sh then
	               new_human_infections = self.past.Sh
	            end
	            
	            local new_vector_infections = (self.betav * self.biting/Nh) * self.past.Sv * self.past.Ih
	            if new_vector_infections > self.past.Sv then
	               new_vector_infections = self.past.Sv
	            end
	                    
	            recovered = (self.gamma * self.past.Ih) 
	                     
	            self.Rh = self.past.Rh + recovered
	            self.Ih = self.past.Ih + new_human_infections - recovered
	            self.Sh = self.past.Sh - new_human_infections
	     
	            self.Iv = self.past.Iv + new_vector_infections
	            self.Sv = self.past.Sv - new_vector_infections
	           


	            -- Proposta de demonstracao do mapa
	            if (self.past.Sh/Nh) * 100 > 40 then
	            	self.state = "susceptible"		
				elseif (self.past.Ih/Nh) * 100 > 50 then
					self.state = "infected"					
				elseif (self.past.Rh/Nh) * 100 > 90 then
					self.state = "recovered"	
				end
			end
		}
		----------------------

	

		-- Filling celular space	
		model.cs = CellularSpace{
			xdim = model.dim,
			instance = model.cell,
		}
		------------------------


		-- homgeneous or Heterogeneous populations
		if homogenousH == false then
			forEachCell(model.cs, function(cell)
				cell.Sh = math.random(humanMimRange,humanMaxRange)
				cell.Ih = Ih
				cell.Rh = Rh
			end)
		else
			forEachCell(model.cs, function(cell)
				cell.Sh = Sh				
	  			cell.Ih = Ih 
	  			cell.Rh = Rh 	

			end)		
		end

		if homogenousV == false then
			forEachCell(model.cs, function(cell)
				cell.Sv = math.random(vectorMimRange,vectorMaxRange)
				cell.Iv = 0
			end)
		else
			forEachCell(model.cs, function(cell)
				cell.Sv = Sv
	  			cell.Iv = Iv  
			end)
		end
		-------------------------------


		-- Total population	
		forEachCell(model.cs, function(cell)
			model.totalHPop = model.totalHPop + cell.Sh + cell.Ih + cell.Rh
	  		model.totalVPop = model.totalVPop + cell.Sv + cell.Iv
		end)
		------------------



		-- Nighbor schemee
		model.cs:createNeighborhood{strategy = "vonneumann"}
		-----------------

		-- Observers
		model.chart = Chart{
			target = model.cs,
			select = "state",
			value = {"susceptible", "infected", "recovered"},
			color = {"yellow", "red", "green"}
		}

		model.map = Map{
			target = model.cs,
	        select = "state",
	      	value = {"susceptible", "infected", "recovered"},
	        color = {"yellow", "red", "green"}
		}

		model.chart2 = Chart {
           target = model,
           select = outChartSelect, 
           label= outChartLabel, 
           style = outChartStyle, 
           color = outChartColor,
           title = "Total of people"           
         }
		-------------	

 	
     
      calcPop = Event {action = function(event)
      	model.totalSh = 0
      	model.totalIh = 0
      	model.totalRh = 0
      	model.totalSh = 0
      	model.totalSv = 0
      	model.totalIv = 0
   		forEachCell(model.cs, function(cell)
					model.totalSh = model.totalSh + cell.Sh 
			  		model.totalIh = model.totalIh + cell.Ih
			  		model.totalRh = model.totalRh + cell.Rh
			  		model.totalSv = model.totalSv + cell.Sv
			  		model.totalIv = model.totalIv + cell.Iv
				end)
		end}

		-- Timer
		model.timer = Timer{
	       Event{action = model.cs},
	       Event{action = model.chart},
	       Event{action = model.chart2},
	       Event{action = model.map},
	     	calcPop
	      
	    }
    -------
    end 


}

SpatialSir:run()