# defold-newtable

Utilize Lua C API to create a Lua Table with specified narr and nrec, to avoid rehashings and enhance arena paradigm.

---

## Installation

Just copy the `newtable` volume into your project.



## Example

```lua
local NewTable = newtable.newtable

function init(self)
    self.a_table_with_16_arr_element = NewTable(16,0)
    self.a_table_with_8_hash_element = NewTable(0,8)
end
```