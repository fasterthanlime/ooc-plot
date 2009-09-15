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
	cr setLineWidth(2)
	
	// compute half width and half height and create our view
	hw := PI * 2
	hh := 4.
	view := View new(cr, w, h) .setViewport(Range new(-hw, hw), Range new(-hh, hh))
	
	range := Range new(-hw, hw)
	precision := 0.001
	
	// initialize
	cr setSourceRGB(1, 0, 0)
	view plotXY(range, precision, LuaFormula new("scripts/formula.lua"))
	
	cr setSourceRGB(0, 0, 1)
	view plotXY(range, precision, LuaFormula new("scripts/formula2.lua"))
	
	cr setSourceRGB(0, 1, 0)
	view plotXY(range, precision, LuaFormula new("scripts/formula3.lua"))
	
	cr setSourceRGB(1, 1, 0)
	view plotXYParam(range, precision, LuaFormulaParam new("scripts/formulaparam.lua"))
	
	fileName := "output/graphic.png"
    surface writeToPng(fileName)
	
}
