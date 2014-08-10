DClib
========

A lua library for cs2d which makes various tasks even easier to do. For instance wraps all player related console commands into a single object-like table which uses metatables to perform different actions. See wiki for some documentation and examples.

Example
========

The following script sets your speedmod to 50 whenever you say 'hax'.

    Hook("say", function(p, message)
        if message == "hax" then
            p.speedmod = 50
            msg('Player ' .. p.name .. ' used hax!')
            return 1
        end
    end)

Instructions
============

    cd sys/lua/
    git clone https://github.com/tarjoilija/dclib.git

Add this line somewhere

    dofile("sys/lua/dclib/init.lua")
