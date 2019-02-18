import imageformats;
import color, area, font, exception;

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

void fillBar(IFImage img, Area area, RGB color, double percent) {
    for (int i = 0; i < area.w * percent; i++) {
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

