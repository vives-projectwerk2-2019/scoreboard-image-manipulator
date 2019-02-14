import std.stdio, imageformats;
import exception, font;

void main()
{
    IFImage img = read_image("image.png", 0);

    for (int i = 0; i < Areas.bar1.w * 0.50; i++) {
        setPixel(img, Areas.bar1.x + i, Areas.bar1.y, Colors.red);
    }

    bool[] pixmap = new bool[Font.width * Font.height + 13];
    for(int i = 0; i < Font.font[0x41].length; i++) {
        for(int j = 0; j < 8; j++) {
            ubyte remainder = (Font.font[0x41][i] & (0x01 << 8 - j)) % (j + 1);
            pixmap[(i*8)+7-j] = remainder == 0 ? true : false;
        }
    }

    for (int i = 0; i < Font.height; i++) {
        for (int j = 0; j < Font.width; j++) {
            RGB color = !pixmap[(i * 8) + j] ? Colors.black : Colors.white;
            setPixel(img, Areas.char1.x + j, Areas.char1.y + i, color);
        }
    }

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
        char1 = {6, 18, 7, 13};
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
