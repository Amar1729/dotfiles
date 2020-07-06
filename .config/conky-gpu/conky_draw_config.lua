-- Define your visual elements here
-- For examples, and a complete list on the possible elements and their 
-- properties, go to https://github.com/fisadev/conky-draw/
-- (and be sure to use the lastest version)

elements = {
    -- cpu
    {
        kind = 'ring_graph',
        conky_value = 'cpu cpu0',
        center = {x = 100, y = 120},
        radius = 60,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        start_angle = 90,
        end_angle = 360,
    },
    {
        kind = 'ring_graph',
        conky_value = 'cpu cpu1',
        center = {x = 100, y = 120},
        radius = 75,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        start_angle = 90,
        end_angle = 360,
    },

    -- memory
    {
        kind = 'ring_graph',
        conky_value = 'memperc /',
        center = {x = 300, y = 120},
        radius = 60,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        start_angle = 90,
        end_angle = 360,
    },
    {
        kind = 'ring_graph',
        conky_value = 'swapperc',
        center = {x = 300, y = 120},
        radius = 75,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        start_angle = 90,
        end_angle = 360,
    },

    -- gpu
    {
        -- gpu cpu freq
        kind = 'ring_graph',
        conky_value = 'exec ~/.config/conky-gpu/gpu.sh --graph',
        center = {x = 100, y = 290},
        radius = 60,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        start_angle = 90,
        end_angle = 360,
    },
    {
        -- gpu temp
        kind = 'ring_graph',
        conky_value = 'nvidia temp',
        max_value = 99,
        center = {x = 100, y = 290},
        radius = 75,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        -- my gpu's MaxOperatingTemperature
        critical_threshold = 96,
        change_color_on_critical = true,
        bar_color_critical = 0xFF0000,

        start_angle = 90,
        end_angle = 360,
    },

    -- disk
    {
        kind = 'ring_graph',
        conky_value = 'fs_used_perc /',
        center = {x = 100, y = 460},
        radius = 60,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        critical_threshold = 85,
        change_color_on_critical = true,
        bar_color_critical = 0xFF0000,

        start_angle = 90,
        end_angle = 360,
    },
    {
        kind = 'ring_graph',
        conky_value = 'fs_used_perc /media/internal',
        center = {x = 100, y = 460},
        radius = 75,

        background_color = 0xFFFFFF,
        background_alpha = 0.7,
        background_thickness = 2,

        bar_color = 0xFFFFFF,
        bar_alpha = 1,
        bar_thickness = 10,

        critical_threshold = 85,
        change_color_on_critical = true,
        bar_color_critical = 0xFF0000,

        start_angle = 90,
        end_angle = 360,
    },
}
