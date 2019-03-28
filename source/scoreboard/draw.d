module scoreboard.draw;

import imageformats;
import scoreboard.color;
import scoreboard.area;
import scoreboard.font;
import scoreboard.exception;
import scoreboard.config;

void setPixel(IFImage img, int x, int y, RGB color) {

    if (x >= img.w || y >= img.h) {
        throw new OutOfBoundsException("Coordinates are out of bounds.");
    }

    int location = ((y * img.w) + x) * 4;
    img.pixels[location] = color.red;
    img.pixels[location + 1] = color.green;
    img.pixels[location + 2] = color.blue;
    img.pixels[location + 3] = 0xFF; // Alpha channel

    return;
}

void drawBar(IFImage img, Area area, RGB color, double percent) {
    area.w = cast(int) (area.w * percent);
    drawArea(img, area, color);
}

void drawArea(IFImage img, Area area, RGB color) {
    for (int i = 0; i < area.w; i++) {
        for (int j = 0; j < area.h; j++) {
            setPixel(img, area.x + i, area.y + j, color);
        }
    }
}
void drawChar(IFImage img, Area area, char character, RGB color) {

    bool[] pixmap = new bool[Font.width * Font.height + 13];
    for(int i = 0; i < Font.font[character].length; i++) {
        for(int j = 0; j < 8; j++) {
            int mask = (0x01 << 7 - j);
            pixmap[(i*8)+7-j] = (Font.font[character][i] & mask) == mask ? true : false;
        }
    }
    for (int i = 0; i < Font.height; i++) {
        for (int j = 0; j < Font.width; j++) {
            if (pixmap[(i * 8) + j]) {
                setPixel(img, area.x + j, area.y + i, color);
            }
        }
    }
}

void drawBoard(IFImage img, ScoreboardConfig config) {

    // Draw backgrounds
    drawArea(img, Areas.scoreboard_bg, Colors.scoreboard_bg);
    drawArea(img, Areas.players_bg, Colors.players_bg);

    // Draw scoreboard
    foreach (i, letter; config.title) {
        if (i == Areas.scoreboard.length) {
            break;
        }
        drawChar(img, Areas.scoreboard[i], letter, Colors.scoreboard_chars);
    }

    // Player variables
    const PlayerConfig[4] players = [
        config.player1,
        config.player2,
        config.player3,
        config.player4
    ];

    const Area[][4] areas_name = [
        Areas.player1_name,
        Areas.player2_name,
        Areas.player3_name,
        Areas.player4_name
    ];

    const Area[][4] areas_bar = [
        Areas.player1_bars,
        Areas.player2_bars,
        Areas.player3_bars,
        Areas.player4_bars
    ];

    // Draw players
    foreach (cycle, player; players) {
        // Name
        char[4] name = ' '; // Fill with spaces
        ulong length = 4;
        if (player.shortName.length <= 4) {
            length = player.shortName.length;
        }
        for(int i; i < length; i++) {
            name[i] = player.shortName[i];
        }
        foreach (i, chr; name) {
            drawChar(img, areas_name[cycle][i], chr, Colors.players_chars);
        }
        // Bars
        foreach (i, percent; player.bars) {
            drawArea(img, areas_bar[cycle][i], Colors.bars_bg);
            double newPercent;
            if (percent > 1.0) {
                newPercent = 1.0;
            } else if (percent < 0.0) {
                newPercent = 0.0;
            } else {
                newPercent = percent;
            }
            drawBar(img, areas_bar[cycle][i], Colors.bars[i], newPercent);
        }
    }
}
