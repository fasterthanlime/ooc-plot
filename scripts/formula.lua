-- formula.lua
-- Receives a float, computes a value from it, and return it

function compute (x)
	return 0.1 * (-x*x) + math.cos(x) + math.sin(x * 3)
end
