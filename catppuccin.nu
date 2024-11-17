const palettes = {
    latte: {
        rosewater: "#dc8a78"
        flamingo: "#dd7878"
        pink: "#ea76cb"
        mauve: "#8839ef"
        red: "#d20f39"
        maroon: "#e64553"
        peach: "#fe640b"
        yellow: "#df8e1d"
        green: "#40a02b"
        teal: "#179299"
        sky: "#04a5e5"
        sapphire: "#209fb5"
        blue: "#1e66f5"
        lavender: "#7287fd"
        text: "#4c4f69"
        subtext1: "#5c5f77"
        subtext0: "#6c6f85"
        overlay2: "#7c7f93"
        overlay1: "#8c8fa1"
        overlay0: "#9ca0b0"
        surface2: "#acb0be"
        surface1: "#bcc0cc"
        surface0: "#ccd0da"
        base: "#eff1f5"
        mantle: "#e6e9ef"
        crust: "#dce0e8"
    }
    frappe: {
        rosewater: "#f2d5cf"
        flamingo: "#eebebe"
        pink: "#f4b8e4"
        mauve: "#ca9ee6"
        red: "#e78284"
        maroon: "#ea999c"
        peach: "#ef9f76"
        yellow: "#e5c890"
        green: "#a6d189"
        teal: "#81c8be"
        sky: "#99d1db"
        sapphire: "#85c1dc"
        blue: "#8caaee"
        lavender: "#babbf1"
        text: "#c6d0f5"
        subtext1: "#b5bfe2"
        subtext0: "#a5adce"
        overlay2: "#949cbb"
        overlay1: "#838ba7"
        overlay0: "#737994"
        surface2: "#626880"
        surface1: "#51576d"
        surface0: "#414559"
        base: "#303446"
        mantle: "#292c3c"
        crust: "#232634"
    }
    macchiato: {
        rosewater: "#f4dbd6"
        flamingo: "#f0c6c6"
        pink: "#f5bde6"
        mauve: "#c6a0f6"
        red: "#ed8796"
        maroon: "#ee99a0"
        peach: "#f5a97f"
        yellow: "#eed49f"
        green: "#a6da95"
        teal: "#8bd5ca"
        sky: "#91d7e3"
        sapphire: "#7dc4e4"
        blue: "#8aadf4"
        lavender: "#b7bdf8"
        text: "#cad3f5"
        subtext1: "#b8c0e0"
        subtext0: "#a5adcb"
        overlay2: "#939ab7"
        overlay1: "#8087a2"
        overlay0: "#6e738d"
        surface2: "#5b6078"
        surface1: "#494d64"
        surface0: "#363a4f"
        base: "#24273a"
        mantle: "#1e2030"
        crust: "#181926"
    }
    mocha: {
        rosewater: "#f5e0dc"
        flamingo: "#f2cdcd"
        pink: "#f5c2e7"
        mauve: "#cba6f7"
        red: "#f38ba8"
        maroon: "#eba0ac"
        peach: "#fab387"
        yellow: "#f9e2af"
        green: "#a6e3a1"
        teal: "#94e2d5"
        sky: "#89dceb"
        sapphire: "#74c7ec"
        blue: "#89b4fa"
        lavender: "#b4befe"
        text: "#cdd6f4"
        subtext1: "#bac2de"
        subtext0: "#a6adc8"
        overlay2: "#9399b2"
        overlay1: "#7f849c"
        overlay0: "#6c7086"
        surface2: "#585b70"
        surface1: "#45475a"
        surface0: "#313244"
        base: "#1e1e2e"
        mantle: "#181825"
        crust: "#11111b"
    }
}


export def main [flavor: string = "mocha"] {
    let palette = ($palettes | get $flavor)
    {
        # color for nushell primitives
        separator: $palette.text
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: $palette.subtext0
        empty: $palette.red
        bool: $palette.peach
        int: $palette.text
        filesize: $palette.teal
        duration: $palette.text
        date: {|| $in | evalDate $palette }
        range: $palette.text
        float: $palette.maroon
        string: $palette.green
        nothing: $palette.text
        binary: $palette.text
        cell-path: $palette.text
        row_index: $palette.overlay1
        record: $palette.text
        list: $palette.subtext0
        block: $palette.overlay2
        hints: $palette.overlay0
        search_result: { bg: $palette.red fg: $palette.crust }
        shape_and: $palette.mauve
        shape_binary: $palette.mauve
        shape_block: $palette.overlay2
        shape_bool: $palette.peach
        shape_closure: $palette.overlay2
        shape_custom: $palette.green
        shape_datetime: $palette.sapphire
        shape_directory: $palette.maroon
        shape_external: $palette.blue
        shape_externalarg: $palette.red
        shape_external_resolved: { fg: $palette.yellow attr: 'b' }
        shape_filepath: $palette.lavender
        shape_flag: $palette.peach
        shape_float: $palette.peach
        shape_garbage: { fg: $palette.crust bg: $palette.red }
        shape_glob_interpolation: $palette.teal
        shape_globpattern: $palette.teal
        shape_int: $palette.peach
        shape_internalcall: { fg: $palette.mauve attr: 'b' }
        shape_keyword: $palette.mauve
        shape_list: $palette.subtext0
        shape_literal: $palette.blue
        shape_match_pattern: $palette.green
        shape_matching_brackets: { attr: u }
        shape_nothing: $palette.sky
        shape_operator: $palette.teal
        shape_or: $palette.mauve
        shape_pipe: $palette.sapphire
        shape_range: { fg: $palette.yellow attr: 'b' }
        shape_record: $palette.lavender
        shape_redirection: { fg: $palette.mauve attr: 'b' } 
        shape_signature: $palette.mauve
        shape_string: $palette.green
        shape_string_interpolation: $palette.green
        shape_table: { fg: $palette.blue attr: 'b' }
        shape_variable: $palette.text
        shape_vardecl: $palette.text
        shape_raw_string: $palette.overlay0
    }
}


def evalDate [palette: record] datetime -> string {
    match ($in | untilNow) {
        $dur if ($dur | durationBetween 0sec 1min) => $palette.sapphire,
        $dur if ($dur | durationBetween 1min 5min) => $palette.blue,
        $dur if ($dur | durationBetween 5min 1hr) => $palette.lavender,
        $dur if ($dur | durationBetween 1hr 8hr) => $palette.text,
        $dur if ($dur | durationBetween 8hr 16hr) => $palette.subtext1,
        $dur if ($dur | durationBetween 16hr 1day) => $palette.subtext0,
        $dur if ($dur | durationBetween 1day 5day) => $palette.overlay2,
        $dur if ($dur | durationBetween 5day 1wk) => $palette.overlay1,
        _ => $palette.overlay0
    }
}

def untilNow [date?: datetime] datetime -> duration {
    if $date == null {
        (date now) - $in
    } else {
        (date now) - $date
    }
}

def durationBetween [start: duration, end: duration] duration -> boolean {
    $in > $start and $in < $end
}
