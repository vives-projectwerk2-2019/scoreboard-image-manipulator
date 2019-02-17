import std.stdio, imageformats;
import exception, font, area;

void main()
{
    IFImage img = read_image("image.png", 0);

    // Draw scoreboard
    foreach (i, letter; "Scoreboard") {
        drawChar(img, Areas.scoreboard[i], letter, Colors.blue);
    }

    fillBar(img, Areas.player1_bars[0], Colors.red, 1.0);
    fillBar(img, Areas.player1_bars[1], Colors.green, 0.3);
    fillBar(img, Areas.player1_bars[2], Colors.purple, 0.7);

    drawChar(img, Areas.player1_name[0], 'F', Colors.white);
    drawChar(img, Areas.player1_name[1], 'O', Colors.white);
    drawChar(img, Areas.player1_name[2], 'O', Colors.white);

    fillBar(img, Areas.player2_bars[0], Colors.red, 0.4);
    fillBar(img, Areas.player2_bars[1], Colors.green, 0.0);
    fillBar(img, Areas.player2_bars[2], Colors.purple, 0.7);

    drawChar(img, Areas.player2_name[0], 'B', Colors.white);
    drawChar(img, Areas.player2_name[1], 'A', Colors.white);
    drawChar(img, Areas.player2_name[2], 'R', Colors.white);

    fillBar(img, Areas.player3_bars[0], Colors.red, 0.8);
    fillBar(img, Areas.player3_bars[1], Colors.green, 1.0);
    fillBar(img, Areas.player3_bars[2], Colors.purple, 0.4);

    drawChar(img, Areas.player3_name[0], 'F', Colors.white);
    drawChar(img, Areas.player3_name[1], 'B', Colors.white);
    drawChar(img, Areas.player3_name[2], 'A', Colors.white);
    drawChar(img, Areas.player3_name[3], 'R', Colors.white);

    fillBar(img, Areas.player4_bars[0], Colors.red, 0.6);
    fillBar(img, Areas.player4_bars[1], Colors.green, 0.8);
    fillBar(img, Areas.player4_bars[2], Colors.purple, 0.2);

    drawChar(img, Areas.player4_name[0], 'B', Colors.white);
    drawChar(img, Areas.player4_name[1], 'A', Colors.white);
    drawChar(img, Areas.player4_name[2], 'Z', Colors.white);


    write_image("out.png", img.w, img.h, img.pixels);
}

struct RGB {
    ubyte red;
    ubyte green;
    ubyte blue;
}

class Colors {
    public static RGB
        black = {0, 0, 0},
        white = {255, 255, 255},
        red = {255, 0, 0},
        green = {0, 255, 0},
        blue = {0, 0, 255},
        purple = {255, 0, 255};
}

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

void fillBar(IFImage img, AREA area, RGB color, double percent) {
    for (int i = 0; i < area.w * percent; i++) {
        for (int j = 0; j < area.h; j++) {
            setPixel(img, area.x + i, area.y + j, color);
        }
    }
}

void drawChar(IFImage img, AREA area, char character, RGB color) {

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
