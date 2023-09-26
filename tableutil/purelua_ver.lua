-- TableUtil (PureLua Ver)
-- Author: Fuxfantx / MIT License
--
-- APIs:
--   tableupdatesize(table)		-> Update the length cache.
--   tableappend(table,value)	-> Append an element, and then update the length cache.
--   lcdiscard()				-> Discard the current length cache.
--   LEN[table]					-> Replace "#table" with this.
--
local M = {}
local smt, gc, s = setmetatable, collectgarbage, "collect"

-- Table Length Cacheing to avoid the O(logn) cost with the "#" operator.
-- 
local _lentbl, l = {}, 0
local LENMETA = {
	__index = function(_,key)
		local l = #key
		_lentbl[key] = l
		return l
	end
}

M.tableupdatesize = function(t) _lentbl[t] = #t end
M.tableappend = function(t,value)
	l = _lentbl[t] + 1
	_lentbl[t] = l
	t[l] = value
end
M.lcdiscard = function() _lentbl = {}; gc(s) end
M.LEN = smt(_lentbl, LENMETA)

return M