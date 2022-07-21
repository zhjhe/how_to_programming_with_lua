local function improve(guess, x)
    return (guess + x / guess) / 2
end

local function is_good_enough(guess, x)
    return math.abs(guess * guess - x) < 0.001
end

local function sqrt_iter(guess, x)
    if is_good_enough(guess, x) then
        return guess
    else
        local next_guess = improve(guess, x)
        return sqrt_iter(next_guess, x)
    end
end

local function sqrt(x)
    return sqrt_iter(1.0, x)
end

print(sqrt(9))
