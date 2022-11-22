module CRAM

using JSON

struct CRAM
    origin::String
    order::Int
    meta::Dict
    rinf::Float64
    alpha::Vector{Complex}
    theta::Vector{Complex}
    function CRAM(c::Dict)
        a = c["alpha"]
        t = c["theta"]
        new(c["origin"],
            c["order"],
            c["meta"],
            parse(BigFloat, c["rinf"]),
            [parse(BigFloat,xr)+1im*parse(BigFloat,xi) for (xr,xi) in zip(a["re"],a["im"])],
            [parse(BigFloat,xr)+1im*parse(BigFloat,xi) for (xr,xi) in zip(t["re"],t["im"])])
    end
end

struct CRAMLibrary
    filename::String
    crams::Vector{CRAM}
    function CRAMLibrary(fname::String,
            selectors::Dict = Dict()
        )

        function parse(sel, selname::String, seltype)
            d = get!(sel, selname, [])
            if !(d isa Array)
                d = [d]
            end
            return d
        end

        kws = Dict("origins"=>String, "orders"=>Int, "bits"=>Int, "chebyK"=>Int, "fftN"=>Int)

        for (key, keytype) in kws



        data = JSON.parse(read("fname", String))

        crams = [CRAM(u) for u in data]
    end
end

end
