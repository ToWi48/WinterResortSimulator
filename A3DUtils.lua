--
-- Artificial Snow Control
-- Modul Utils
--
-- @autor Tom Wießner
-- @date 10/01/21
--
-- using only with premission by Alpin 3D Design
-- (c) Tom Wießner 2021
--

A3D = A3D or {};

function A3D.saveNav(get, str, getTableNil)
	local list = {};
	for word in string.gmatch(str, '([^.]+)') do
		table.insert(list, word);
	end;

	local base = get or {};

	for i=2, #list do
        local word = list[i]
		if base[word] == nil then 
			base = nil;
			break; 
		end;
		base = base[word];
	end;

	if base == nil and getTableNil then
		base = {};
	end;

	return base;
end;

function A3D.debugLoad(tbl, str)
	local var = A3D.saveNav(tbl, str);
	if var == nil then
		print('ASC-Error: Important variable "' ..str.. '" does not exist!');
	end;
	return var
end;

function A3D.debugLoad3D(tbl, str, id)
	local var = A3D.saveNav(tbl, str);
	local newId = getChild(id, var or "");
	if var == nil or newId == nil then
		print('ASC-Error: Your 3D path "' ..str.. '" does not exist!');
	end;
	return newId
end;

function A3D.callStringFunc(instance, str)
	if type(instance) ~= "table" or type(str) ~= "string" then
		return
	end;

	local list = {};
	local func = "";
	for word in string.gmatch(str, '([^ ]+)') do
		if func == "" then
			func = word;
		else
			table.insert(list, word);
		end;
	end;

	if func ~= "" then
		instance:callVehicleScripts(func, unpack(list));
	end;
end;
