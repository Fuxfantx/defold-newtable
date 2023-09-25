-- TableUtil
-- Author: Fuxfantx / MIT License
--
-- APIs:
--   newtable(narr,nrec)		-> Create a Lua Table with specified ArrayPart size and HashPart size.
--   tableupdatesize(table)		-> Update the length cache.
--   tableappend(table,value)	-> Append an element, and then update the length cache.
--   LEN.discard()				-> Discard the current length cache.
--   LEN[table]					-> Replace "#table" with this.
--
local M = {}

-- A. LuaC Table Creating API to avoid rehashing and optimize the arena paradigm.
-- 
local newtable, smt = __NEWTABLE__, setmetatable
__NEWTABLE__ = nil

-- B. Table Length Cacheing to avoid the O(logn) cost with the "#" operator.
-- 
local str_discard, _lentbl, _lenhashs, _local = "discard", newtable(0,2048), newtable(2048,0)
_lenhashs[1] = 1

local function _discard()
	_local = _lenhashs[1]
	for i = 2, _local do
		_lentbl[ _lenhashs[i] ] = nil
		_lenhashs[i] = nil
	end
	_lenhashs[1] = 1
end

local LENMETA = {
	__index = function(self,key)
		if key==str_discard and _lenhashs[1]>1 then
			return _discard
		else
			_local = _lenhashs[1] + 1
			_lenhashs[1] = _local
			_lenhashs[_local] = key
			
			_local = #key
			self[key] = _local
			return _local
		end
	end
}

M.newtable = newtable
M.LEN = smt(_lentbl, LENMETA)
M.tableupdatesize = function(t)
	_lentbl[t] = nil
	_local = _lentbl[t]
end
M.tableappend = function(t,value)
	_local = _lentbl[t] + 1
	_lentbl[t] = _local
	t[_local] = value
end

return M