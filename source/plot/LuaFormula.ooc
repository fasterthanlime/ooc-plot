import Formula, FormulaParam, lua/State, Point2d

LuaFormula: class extends Formula {

	state := State new()
	fileName: String
	
	init: func (=fileName) {
		
		state openLibs()
		
		status := state doFile(fileName)
		if(status) {
			state toString(-1) println()
			exit(1) // heh.
		}

	}
	
	/** Call a function 'f' defined in Lua */
	compute: func (x : Double) -> Double {
		
		// push functions and arguments
		state getGlobal("compute") // the function we want to call
		state pushNumber(x) // push 1st argument
		
		// 1 argument, one result
		result := state pcall(1, 1, 0)
		
		if(result) {
			state toString(-1) println()
			exit(1)
		}
		
		// retrieve results
		output := state toNumber(-1)
		// pop returned value
		state pop(1)
		return output
		
	}
	
}


LuaFormulaParam: class extends FormulaParam {

	state := State new()
	fileName: String
	
	init: func (=fileName) {
		
		state openLibs()
		
		status := state doFile(fileName)
		if(status) {
			state toString(-1) println()
			exit(1) // heh.
		}

	}
	
	/** Call a function 'f' defined in Lua */
	compute: func (t : Double) -> Point2d {
		
		// push functions and argument
		state getGlobal("compute") // the function we want to call
		state pushNumber(t) // push 1st argument
		
		// 1 argument, two results
		result := state pcall(1, 2, 0)
		
		if(result) {
			state toString(-1) println()
			exit(1)
		}
		
		// retrieve results
		y := state toNumber(-1)
		x := state toNumber(-2)
		
		// pop returned values
		state pop(1)
		state pop(1)
		
		return Point2d new(x, y)
		
	}
	
}
