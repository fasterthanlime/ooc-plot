Range: class {
	
	min, max: Double
	
	init: func (=min, =max) {
		if(min > max) {
			tmp := min
			min = max
			max = tmp
		}
	}
	
	length: func -> Double { max - min }
	
	repr: func -> String {
		return "(" + min repr() + ", " + max repr() + ")"
	}
	
}
