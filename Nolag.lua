_G.Settings = {
    Players = {
        ["Ignore Me"] = true,
        ["Ignore Others"] = true,
        ["Ignore Tools"] = true
    },
    Meshes = {
        NoMesh = true,
        NoTexture = true,
        Destroy = false
    },
    Images = {
        Invisible = true,
        Destroy = false
    },
    Explosions = {
        Smaller = true,
        Invisible = true, -- Not recommended for PVP games
        Destroy = false, -- Not recommended for PVP games
    },
    Particles = {
        Invisible = true,
        Destroy = false
    },
    TextLabels = {
        LowerQuality = true,
        Invisible = true,
        Destroy = false
    },
    MeshParts = {
        LowerQuality = true,
        Invisible = true,
        NoTexture = true,
        NoMesh = true,
        Destroy = false
    },
    Other = {
        ["FPS Cap"] = 15, -- Set this true to uncap FPS
        ["No Camera Effects"] = true,
        ["No Clothes"] = true,
        ["Low Water Graphics"] = true,
        ["No Shadows"] = true,
        ["Low Rendering"] = true,
        ["Low Quality Parts"] = true,
        ["Low Quality Models"] = true,
        ["Reset Materials"] = true,
        ["Lower Quality MeshParts"] = true,
        ClearNilInstances = false -- NEW (EXPERIMENTAL)
    }
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
