require 'pl'
inspect = require 'inspect'
lpeg = require 'lpeg'

_print = print
function print(...)
    for i=1,select('#', ...) do
        local arg = select(i, ...)
        if type(arg) == "table" then
            _print(inspect(arg, {depth = 2}))
        else
            _print(arg)
        end
    end
end
