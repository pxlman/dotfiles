local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
ls.add_snippets("cpp", {
	s("body", {
		t({ "#include<iostream>", "" }),
		t({ "#define ll long long", "" }),
		t({ "#define steadY ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL);", "" }),
		t({ "using namespace std;", "", "" }),
		t({ "int main(){", "" }),
		t({ "\tsteadY", "\t" }),
		i(0),
		t({ "", "\treturn 0;", "}" }),
	}),
	s("for", {
		t({ "for(int i = 0; i < n ;i++){", "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),
})
