#define LIB_NAME "TableUtil"
#define MODULE_NAME "tableutil"
#include <dmsdk/sdk.h>

static inline int newtable(lua_State* L)
{
	int asize = luaL_checknumber(L, 1);
	int hsize = luaL_checknumber(L, 2);
	
	DM_LUA_STACK_CHECK(L, 1);
	lua_createtable(L, asize, hsize);
	return 1;
}

static inline dmExtension::Result AppInitializeNewTable(dmExtension::AppParams* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result AppFinalizeNewTable(dmExtension::AppParams* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result FinalizeNewTable(dmExtension::Params* params) { return dmExtension::RESULT_OK; }
static inline dmExtension::Result InitializeNewTable(dmExtension::Params* params)
{
	lua_register(params->m_L, "__NEWTABLE__", newtable);
	return dmExtension::RESULT_OK;
}

DM_DECLARE_EXTENSION(TableUtil, LIB_NAME, AppInitializeNewTable, AppFinalizeNewTable, InitializeNewTable, 0, 0, FinalizeNewTable)