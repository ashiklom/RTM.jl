function hapke_soil(soil_moisture_frac)
    soil_moisture_frac .* soildat[:,2] .+ (1 .- soil_moisture_frac) .* soildat[:,1]
end
