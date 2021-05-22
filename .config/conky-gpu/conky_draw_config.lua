-- Define your visual elements here
-- For examples, and a complete list on the possible elements and their 
-- properties, go to https://github.com/fisadev/conky-draw/
-- (and be sure to use the lastest version)

font = 'Iosevka';
font_size = '14';
fg = 0xEF5A29;

elements = {
    -- cpu
    {
        kind = 'static_text',
        text = 'CPU',
        from = {x = 110, y = 140},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'cpu0',
        from = {x = 110, y = 185},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'cpu1',
        from = {x = 110, y = 200},

        font = font,
        font_size = font_size,
        color = fg,
    },
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
        kind = 'static_text',
        text = 'MEM',
        from = {x = 310, y = 140},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'ddr4',
        from = {x = 310, y = 185},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'swap',
        from = {x = 310, y = 200},

        font = font,
        font_size = font_size,
        color = fg,
    },
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
        kind = 'static_text',
        text = 'GPU',
        from = {x = 110, y = 310},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'variable_text',
        conky_value = 'exec ~/.config/conky-gpu/gpu.sh',
        from = {x = 110, y = 325},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'freq',
        from = {x = 110, y = 355},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'temp',
        from = {x = 110, y = 370},

        font = font,
        font_size = font_size,
        color = fg,
    },
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
        kind = 'static_text',
        text = 'DISK',
        from = {x = 110, y = 480},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'root',
        from = {x = 110, y = 525},

        font = font,
        font_size = font_size,
        color = fg,
    },
    {
        kind = 'static_text',
        text = 'internal',
        from = {x = 110, y = 540},

        font = font,
        font_size = font_size,
        color = fg,
    },
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
