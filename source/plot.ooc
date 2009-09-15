import lua/State, cairo/Cairo
import plot/[LuaFormula, Range, View]
include math

cos: extern func (Double) -> Double
sin: extern func (Double) -> Double

PI := const 3.14159_265_358_97_93

main: func(argc: Int, argv: String*) {
	
	w, h : Int
	
	if(argc >= 3) {
		w = argv[1] as String toInt()
		h = argv[2] as String toInt()
	} else {
		w = 500
		h = 500
	}
	
	surface := ImageSurface new(0, w, h) /* 0 = CAIRO_FORMAT_ARGB32 */
    cr := Context new(surface)
	
	// clear screen to black
	cr setSourceRGB(0, 0, 0)
	cr paint()
	
	// prepare pen color and width
	cr setSourceRGB(1, 0, 0)
	cr setLineWidth(2)
	
	// compute half width and half height and create our view
	hw := PI * 2
	hh := 4.
	view := View new(cr, w, h) .setViewport(Range new(-hw, hw), Range new(-hh, hh))
	
	// initialize
	formula := LuaFormula new("scripts/formula.lua")
	view plotXY(Range new(-hw, hw), 0.1, formula)
	
	fileName := "output/graphic.png"
    surface writeToPng(fileName)
	
}
