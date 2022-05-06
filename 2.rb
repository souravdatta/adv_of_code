sample_input = '199
200
208
210
200
207
240
269
260
263'

depths = sample_input.split(/\n/).map(&:to_i)

def new_depths(ds, xs)
    if ds.length < 3
        xs
    else
        new_depths ds.drop(1), xs << ds.take(3).sum
    end
end

ndepths = new_depths depths, []

def num_incs(d, ni)
    if d.length < 2
        ni
    else
        x, y = d.take(2)
        num_incs d.drop(1), if x < y then ni + 1 else ni end
    end
end

p num_incs(ndepths, 0)

