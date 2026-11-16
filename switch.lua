local counter = 1

function print_counter()
    local ent = GetUpdatedEntityID()
    local comp = GetUpdatedComponentID()

    local text = "Counter: " .. counter .. ", Ent: " .. ent .. ", Comp: " .. comp
    GamePrint(text)
    print(text)

    counter = counter + 1
end

-- Run when the script is loaded first
print_counter()

-- Run on interacting
function interacting()
    print_counter()
end
