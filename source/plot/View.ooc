import cairo/Cairo, Range, Formula, FormulaParam, Point2d

View: class {
	
	cr : Context
	winx, winy : Range
	w, h : Double
	
	init: func (=cr, =w, =h) {}
	
	/**
	* Plot an f(x) = y function on a 2D canvas
	*/
	plotXY: func (xrange : Range, step: Double, f: Formula) {
		
		moveTo(xrange min, f compute(xrange min))
		
		x := xrange min
		while(x < xrange max) {
			lineTo(x, f compute(x))
			x += step
		}
		
		stroke()
		
	}
	
	/**
	* Plot an f(t) = (x, y) function on a 2D canvas
	*/
	plotXYParam: func (trange : Range, step: Double, f: FormulaParam) {
		
		first := f compute(trange min)
		moveTo(first x, first y)
		
		t := trange min
		while(t < trange max) {
			point := f compute(t)
			lineTo(point x, point y)
			t += step
		}
		
		stroke()
		
	}
	
	screenX: func (x: Double) -> Double { return (x - winx min) * w / winx length() }
	screenY: func (y: Double) -> Double { return (y - winy min) * h / winy length() }
	
	moveTo: func (x, y: Double) { cr moveTo(screenX(x), screenY(y)) }
	lineTo: func (x, y: Double) { cr lineTo(screenX(x), screenY(y)) }
	stroke: func { cr stroke() }
	
	setViewport: func (=winx, =winy) {}
	
}
