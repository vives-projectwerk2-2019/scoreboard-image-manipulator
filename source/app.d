import imageformats;
import draw, config;

void main()
{
	const config = readConfig("config.json");

    IFImage img = read_image(config.inFile, 0);
    drawBoard(img, config);
    write_image(config.outFile, img.w, img.h, img.pixels);
}
