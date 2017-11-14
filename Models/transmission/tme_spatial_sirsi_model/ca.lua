

SpatialSir = Model{

	finalTime = 100,
	dim = 50,

	init = function(model)

		model.cell = Cell{
			state = "susceptible",
  			Sh = 2000,
  			Ih = 1, 
  			Rh = 0,   			
  			Sv = 20000,
  			Iv = 0,  			
 			biting = 1,
  			gamma = 0.167,
  			betah = 0.400,
  			betav = 0.400,


			execute = function(self)

				local countNeigh = 0
				forEachNeighbor(self, function(neigh)
					
					if neigh.state =="infected" then
						countNeigh = countNeigh + 1
					end

				end)

		   
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

	            if (self.past.Sh/Nh) * 100 > 51 then
	            	self.state = "susceptible"		
				elseif (self.past.Ih/Nh) * 100 > 40 then
					self.state = "infected"					
				elseif (self.past.Rh/Nh) * 100 > 90 then
					self.state = "recovered"	
				end
			end
		}

	model.cs = CellularSpace{
		xdim = model.dim,
		instance = model.cell,
	}
	-- heterogeneo
	forEachCell(model.cs, function(cell)
		cell.Sh = math.random(20,9999)
	end)
	--forEachCell(model.cs, function(cell)
		--cell.Sv = math.random(20,100000)
	--end)

	model.cs:createNeighborhood{strategy = "vonneumann"}
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

	model.timer = Timer{
       Event{action = model.cs},
       Event{action = model.chart},
       Event{action = model.map}
    }
    end 


}

SpatialSir:run()