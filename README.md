# defold-tableutil

Defold Lua Table utils for usages below:

- Create sized Lua Table to avoid rehashing and enhance the arena paradigm;

- Cache Table Length to avoid the `O(logn)` cost with the `#` operator.

## Installation

1. Copy the `tableutil` volume into your project.

2. `Require` the module in the script file:
   
   ```lua
   local tu = require("tableutil.main")
   ```

## APIs & Example

```lua
-- APIs:
--   newtable(narr,nrec)        -> Create a Lua Table with specified ArrayPart size and HashPart size.
--   tableupdatesize(table)        -> Update the length cache.
--   tableappend(table,value)    -> Append an element, and then update the length cache.
--   LEN.discard()                -> Discard the current length cache.
--   LEN[table]                    -> Replace "#table" with this.local NewTable = newtable.newtable

local tu = require("tableutil.main")
local NewTable = tu.newtable
local TableUpdateSize = tu.tableupdatesize
local TableAppend = tu.tableappend
local LEN = tu.LEN

function init(self)
    self.a_table_with_16_arr_element = NewTable(16,0)
    self.a_table_with_8_hash_element = NewTable(0,8)
end

local t1 = NewTable(4,0)
for i = 1,4 do TableAppend(t1,i) end
print( LEN[t1] )
print( LEN.discard )

for i = 1, LEN[t1] do
	t1[i] = nil
end
TableUpdateSize(t1)

print( #t1 )
print( LEN[t1] )

LEN.discard()
pprint(LEN)
```