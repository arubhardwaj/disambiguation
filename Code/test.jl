using CSV
using DataFrames
using DelimitedFiles


data = CSV.File("data/merge.csv")

data = DataFrame(data)


df = DataFrame(inventorID =  data.inventor_id, inv_dis = data.inventor_disambiguated)

result = []

function test()
    for i in unique(data.inventor_disambiguated)
        a = df[in([i]).(df.inv_dis), :] 
        b = length(unique(a.inventorID))
        if b==1 push!(result, "Match")
        else push!(result, "Not Match")
        end
    end
end

writedlm( "result_unique_inv_disambig.csv",  result, ',')

#-----------------------------------------------------

result_invdis = []

function test2()
    for i in unique(data.inventor_id)
        a = df[in([i]).(df.inventorID), :] 
        b = length(unique(a.inv_dis))
        if b==1 push!(result_invdis, "Match")
        else push!(result_invdis, "Not Match")
        end
    end
end

@time test2()


