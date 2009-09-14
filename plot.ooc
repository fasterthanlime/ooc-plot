import cairo.Cairo
include math

cos: extern func (Double) -> Double
sin: extern func (Double) -> Double

PI := const 3.14159_265_358_97_93

main: func {
	
	w = 500, h = 500 : Int
	
	surface := ImageSurface new(0, w, h) /* 0 = CAIRO_FORMAT_ARGB32 */
    cr := Context new(surface)
	
	cr setSourceRGB(0, 0, 0)
	cr paint()
	
	cr setSourceRGB(1., 0, 0)
	cr setLineWidth(2)
	
	// half width and height
	hw := PI * 2 * 5
	hh := 4.
	
	printf("surface size = %dx%d\n", w, h)
	win := Window new(cr, w, h) .setViewport(Range new(-hw, hw), Range new(-hh, hh))
	
	win plotXY(Range new(-hw, hw), 0.8, func (x: Double) -> Double { cos(x) })
	
	fileName := "graphic.png"
    surface writeToPng(fileName)
	
}

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

Window: class {
	
	cr : Context
	winx, winy : Range
	w, h : Double
	
	init: func (=cr, =w, =h) {
		printf("w = %.2f, h = %.2f\n", w, h)
	}
	
	/**
	* Plot an f(x) = y function on a 2D canvas
	*/
	plotXY: func (xrange : Range, step: Double, f: Func (Double) -> Double) {
		
		moveTo(xrange min, f(xrange min))
		
		x := xrange min
		while(x < xrange max) {
			lineTo(x, f(x))
			x += step
		}
		
		stroke()
		
	}
	
	screenX: func (x: Double) -> Double { return (x - winx min) * w / winx length() }
	screenY: func (y: Double) -> Double { return (y - winy min) * h / winy length() }
	
	moveTo: func (x, y: Double) { cr moveTo(screenX(x), screenY(y)) }
	lineTo: func (x, y: Double) { 
		printf("view coordinates = (%.2f, %.2f), screen coords = (%.2f, %.2f)\n", x, y, screenX(x), screenY(y))
		cr lineTo(screenX(x), screenY(y))
	}
	stroke: func { cr stroke() }
	
	setViewport: func (=winx, =winy) {
		printf("viewport set to %s, %s\n", winx repr(), winy repr())
	}
	
}

