def count_primes(n)
    return 0 if n < 2
    composites = Array.new(n)
    composites[0] = true #treating 1 as composite
    add_composites(2, n, composites)
    (3...n).step(2) do |current|
        add_composites(current, n, composites) unless composites[current-1]
    end
    n - 1 - composites.compact.count
end

def add_composites(min, max, composites)
    (min...max).step(min) do |num|
        composites[num -1] = true unless num == min
    end
end
