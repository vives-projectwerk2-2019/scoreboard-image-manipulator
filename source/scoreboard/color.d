module scoreboard.color;

struct RGB {
    ubyte red;
    ubyte green;
    ubyte blue;
}

class Colors {
    public static const:
        RGB scoreboard_bg = {0x0c, 0x41, 0x00};
        RGB players_bg = {0x00, 0x00, 0x00};
        RGB bars_bg = {0xff, 0xff, 0xff};
        RGB scoreboard_chars = {0x0c, 0xe3, 0x00};
        RGB players_chars = {0xff, 0xff, 0xff};
        RGB[2] bars = [
            {0xff, 0x00, 0x00},
            {0xff, 0xff, 0x00}
        ];
}
