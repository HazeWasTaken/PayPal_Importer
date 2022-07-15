Vehicle_Importer = {}
local Loaded, Env: table = {}

import = function(dir)
    if not Loaded[dir] then
        Loaded[dir] = Vehicle_Importer[dir]()
    end
    return Loaded[dir]
end

