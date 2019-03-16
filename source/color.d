struct RGB {
    ubyte red;
    ubyte green;
    ubyte blue;
}

class Colors {
    public static const:
        RGB black = {0, 0, 0};
        RGB white = {255, 255, 255};

        RGB red = {255, 0, 0};
        RGB green = {0, 192, 0};
        RGB blue = {0, 0, 255};
        RGB purple = {255, 0, 255};

        RGB scoreboard_bg = {131, 240, 220};
        RGB players_bg = {65, 55, 220};
        RGB bars_bg = {255, 255, 255};
        RGB[3] bars = [
            red,
            green,
            purple
        ];
}
