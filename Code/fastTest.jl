using CSV
using DataFrames

data = CSV.File("data/aru.csv") # Change path!!!

df = DataFrame(inventorID =  data.inventor_id, inv_dis = data.inventor_disambiguated)


function test1(df)
    grp = groupby(df, :inv_dis)
    fun = gfr->all(==(first(gfr.inventorID)), gfr.inventorID)
    return count(fun, grp)/length(grp)
end

# Run
@time test1(df)


function test2(df)
    grp = groupby(df, :inventorID)
    fun = gfr->all(==(first(gfr.inv_dis)), gfr.inv_dis)
    return count(fun, grp)/length(grp)
end

# Run
@time test2(df)