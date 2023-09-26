-- TableUtil
-- Author: Fuxfantx / MIT License
--
-- APIs:
--   newtable(narr,nrec)		-> Create a Lua Table with specified ArrayPart size and HashPart size.
--   tableupdatesize(table)		-> Update the length cache.
--   tableappend(table,value)	-> Append an element, and then update the length cache.
--   lcdiscard()				-> Discard the current length cache.
--   LEN[table]					-> Replace "#table" with this.
--
local M = {}

-- A. LuaC Table Creating API to avoid rehashing and optimize the arena paradigm.
-- 
local newtable, smt, gc, s = __NEWTABLE__, setmetatable, collectgarbage, "collect"
__NEWTABLE__ = nil

-- B. Table Length Cacheing to avoid the O(logn) cost with the "#" operator.
-- 
local _lentbl, l = newtable(0,8192), 0
local LENMETA = {
	__index = function(_,key)
		local l = #key
		_lentbl[key] = l
		return l
	end
}

M.newtable = newtable
M.tableupdatesize = function(t) _lentbl[t] = #t end
M.tableappend = function(t,value)
	l = _lentbl[t] + 1
	_lentbl[t] = l
	t[l] = value
end
M.lcdiscard = function() _lentbl = newtable(0,8192); gc(s) end
M.LEN = smt(_lentbl, LENMETA)

return M