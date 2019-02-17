import std.stdio, imageformats;
import exception, font;

void main()
{
    IFImage img = read_image("image.png", 0);

    fillBar(img, Areas.bar1, Colors.red, 1.0);
    drawChar(img, Areas.char1, 'F', Colors.white);
    drawChar(img, Areas.char2, 'O', Colors.white);
    drawChar(img, Areas.char3, 'O', Colors.white);
    // drawChar(img, Areas.char4, 'v');
    // drawChar(img, Areas.char5, 'e');

    drawChar(img, Areas.scoreboard1, 'S', Colors.blue);
    drawChar(img, Areas.scoreboard2, 'c', Colors.blue);
    drawChar(img, Areas.scoreboard3, 'o', Colors.blue);
    drawChar(img, Areas.scoreboard4, 'r', Colors.blue);
    drawChar(img, Areas.scoreboard5, 'e', Colors.blue);
    drawChar(img, Areas.scoreboard6, 'b', Colors.blue);
    drawChar(img, Areas.scoreboard7, 'o', Colors.blue);
    drawChar(img, Areas.scoreboard8, 'a', Colors.blue);
    drawChar(img, Areas.scoreboard9, 'r', Colors.blue);
    drawChar(img, Areas.scoreboard10, 'd', Colors.blue);

    write_image("out.png", img.w, img.h, img.pixels);
}

struct RGB {
    ubyte red;
    ubyte green;
    ubyte blue;
}

struct AREA {
    int x;
    int y;
    int w;
    int h;
}

class Colors {
    public static RGB
        black = {0, 0, 0},
        white = {255, 255, 255},
        red = {255, 0, 0},
        green = {0, 255, 0},
        blue = {0, 0, 255};
}

class Areas {
    public static AREA
        bar1 = {6, 29, 22, 1},
        char1 = {6, 18, 8, 8},
        char2 = {14, 18, 8, 8},
        char3 = {22, 18, 8, 8},
        char4 = {30, 18, 8, 8},
        char5 = {38, 18, 8, 8},
        scoreboard1 = {8, 4, 8, 8},
        scoreboard2 = {16, 4, 8, 8},
        scoreboard3 = {24, 4, 8, 8},
        scoreboard4 = {32, 4, 8, 8},
        scoreboard5 = {40, 4, 8, 8},
        scoreboard6 = {48, 4, 8, 8},
        scoreboard7 = {56, 4, 8, 8},
        scoreboard8 = {64, 4, 8, 8},
        scoreboard9 = {72, 4, 8, 8},
        scoreboard10 = {80, 4, 8, 8};
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
            setPixel(img, area.x + i, area.y + j, Colors.red);
        }
    }
}

void drawChar(IFImage img, AREA area, char character, RGB color) {

    bool[] pixmap = new bool[Font.width * Font.height + 13];
    for(int i = 0; i < Font.font[character].length; i++) {
        for(int j = 0; j < 8; j++) {
            // ubyte remainder = (Font.font[character][i] & (0x01 << 7 - j)) % (j + 1);
            // writeln(Font.font[character][i], " & ", (0x01 << 7 - j), " = ", remainder);
            // writeln(Font.font[character]);
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
