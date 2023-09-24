#define LIB_NAME "NewTable"
#define MODULE_NAME "newtable"
#include <dmsdk/sdk.h>

static inline int newtable(lua_State* L)
{
	int asize = luaL_checknumber(L, 1);
	int hsize = luaL_checknumber(L, 2);
	
	DM_LUA_STACK_CHECK(L, 1);
	lua_createtable(L, asize, hsize);
	return 1;
}

static const luaL_reg Module_methods[] =
{
	{"newtable", newtable},
	{0, 0}
};

static inline void LuaInit(lua_State* L)
{
	int top = lua_gettop(L);
	luaL_register(L, MODULE_NAME, Module_methods);
	lua_pop(L, 1);
	assert(top == lua_gettop(L));
}

static inline dmExtension::Result AppInitializeNewTable(dmExtension::AppParams* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result AppFinalizeNewTable(dmExtension::AppParams* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result FinalizeNewTable(dmExtension::Params* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result InitializeNewTable(dmExtension::Params* params)
{
	LuaInit(params->m_L);
	return dmExtension::RESULT_OK;
}

DM_DECLARE_EXTENSION(NewTable, LIB_NAME, AppInitializeNewTable, AppFinalizeNewTable, InitializeNewTable, 0, 0, FinalizeNewTable)