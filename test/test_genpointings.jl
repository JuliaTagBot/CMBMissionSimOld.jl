dirs = CMBSim.genpointings(0:3600:86400, 
    [0, 0, 1], 
    0.0,
    spinsunang = 0.0,
    borespinang = 0.0,
    spinrpm = 0.0,
    precrpm = 0.0,
    hwprpm = 0.0,
)

# Check the colatitudes
for idx in 1:size(dirs, 1)
    # Check that we're on the Ecliptic plane (colatitude = 90°)
    @test dirs[idx, 1] ≈ π / 2

    # Check that the polarization angle is always the same
    @test dirs[idx, 3] ≈ -π / 2
end

# Check that the longitude increases as expected
@test dirs[end, 2] - dirs[1, 2] ≈ 2π / CMBSim.DAYS_PER_YEAR

#######################################################################

dirs = CMBSim.genpointings(0:0.1:120, 
    [0, 0, 1],
    0.0,
    spinsunang = 0.0,
    borespinang = 0.0,
    spinrpm = 1.0,
    precrpm = 0.0,
    hwprpm = 1.0,
)

@test maximum(dirs[:, 3]) ≈ π / 2
@test minimum(dirs[:, 3]) ≈ -π / 2

#######################################################################

dirs = CMBSim.genpointings(0:1:60,
    [0, 0, 1],
    0.0,
    borespinang = deg2rad(15),
    spinsunang = deg2rad(0),
    spinrpm = 1.0,
    precrpm = 0.0,
    yearlyrpm = 0.1,
)

# Colatitudes should depart no more than ±15° from the Ecliptic 
@test minimum(dirs[:, 1]) ≈ deg2rad(90 - 15)
@test maximum(dirs[:, 1]) ≈ deg2rad(90 + 15)

@test dirs[1, 2] ≈ 0.0
@test dirs[end, 2] ≈ deg2rad(36)

#######################################################################

dirs = CMBSim.genpointings(0:1:60, 
    [0, 0, 1], 
    0.0,
    borespinang = 0.0,
    spinsunang = deg2rad(15),
    spinrpm = 0.0,
    precrpm = 0.0,
    yearlyrpm = 0.1,
)

for idx in 1:size(dirs, 1)
    @test dirs[idx, 1] ≈ deg2rad(90 - 15)
end