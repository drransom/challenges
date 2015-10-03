def count_primes(n)
    return 0 unless n > 2
    composites = Array.new(n)
    composites[0] = true
    add_composites(2, n, composites)
    (3..n).step(2) do |current|
        add_composites(current, n, composites) unless composites[current-1]
    end
    n - composites.compact.count
end

def add_composites(min, max, composites)
    (min..max).step(min) do |num|
        composites[num -1] = true unless num == min
    end
end
