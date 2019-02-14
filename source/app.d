import std.stdio, imageformats;
import exception;

void main()
{
    IFImage img = read_image("image.png", 0);

    for (int i; i < Areas.bar1.w * 0.50; i++) {
        setPixel(img, Areas.bar1.x + i, Areas.bar1.y, Colors.red);
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
        red = {255, 0, 0},
        green = {0, 255, 0},
        blue = {0, 0, 255};
}

class Areas {
    public static AREA
        bar1 = {6, 29, 22, 1};
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
