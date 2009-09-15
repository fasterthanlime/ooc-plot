-- formulaparam.lua
-- Receives a float, computes two values from it, and return it

function compute (x)
	return math.cos(x) + (0.2 * math.cos(10 * x)), math.sin(x) + (0.2 * math.sin(10 * x))
end
