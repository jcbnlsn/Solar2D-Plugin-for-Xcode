-- -------------------------------------------------------------------------------
--
--  ___FILENAME___ - ___PROJECTNAME___
--  Created by ___FULLUSERNAME___ on ___DATE___.
--
-- -------------------------------------------------------------------------------

local Class = {}

function Class:new( o )
    o = o or {}
    setmetadata( o, self )
    self.__index = self
    return o
end

return Class
