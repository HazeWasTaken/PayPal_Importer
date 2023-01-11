local Initialize = {
	Data = {},
	Functions = {}
}

for i, v in next, getgc(true) do
    if type(v) == "table" and rawget(v, "attemptEquipGarageItem") then
        Initialize.Functions.SelectItem = v.attemptEquipGarageItem
    end
end

return Initialize