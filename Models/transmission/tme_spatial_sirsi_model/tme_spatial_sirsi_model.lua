

SpatialSir = Model{

	finalTime = finalTime,
	dim = dim,
	homogenousH = homogenousH,
	humanMimRange = humanMimRange,
	humanMaxRange = humanMaxRange,
	homogenousV = homogenousV,
	vectorMimRange = vectorMimRange,
	vectorMaxRange = vectorMaxRange,

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

				-- Verify neighboors
				local countNeigh = 0
				forEachNeighbor(self, function(neigh)
					
					if neigh.state =="infected" then
						countNeigh = countNeigh + 1
					end

				end)

		   		-- Neigh dynamic version 0.1
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
	                        
	            self.Rh = self.past.Rh + (self.past.gamma * self.past.Ih)
	            self.Ih = self.past.Ih + new_human_infections - (self.past.gamma * self.past.Ih)
	            self.Sh = self.past.Sh - new_human_infections
	            Nh = self.past.Sh + self.past.Ih + self.past.Rh
	            
	            self.Iv = self.past.Iv + new_vector_infections
	            self.Sv = self.past.Sv - new_vector_infections
	            Nv = self.past.Sv + self.past.Iv


	            -- Proposta de demonstracao do mapa
	            if (self.past.Sh/Nh) * 100 > 40 then
	            	self.state = "susceptible"		
				elseif (self.past.Ih/Nh) * 100 > 40 then
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
			end)
		else
			forEachCell(model.cs, function(cell)
				cell.Sh = Sh
				print(Ih)
	  			cell.Ih = Ih 
	  			cell.Rh = Rh 	

			end)		
		end

		if homogenousV == false then
			forEachCell(model.cs, function(cell)
				cell.Sv = math.random(vectorMimRange,vectorMaxRange)
			end)
		else
			forEachCell(model.cs, function(cell)
				cell.Sv = Sv
	  			cell.Iv = Iv  
			end)

		end
		-------------------------------


		-- Pop variables
		local totalHPop = 0
		local totalVpop = 0
		forEachCell(model.cs, function(cell)
			totalPopulation = totalPopulation + cell.Sh + cell.Ih + cell.Rh
			totalVpop = totalVpop + cell.Sv + cell.Iv
		end)
		---------------


		
		-- Nighbor scheeme
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
		-------------


		-- Timer
		model.timer = Timer{
	       Event{action = model.cs},
	       Event{action = model.chart},
	       Event{action = model.map}
	    }
    -------
    end 


}

SpatialSir:run()