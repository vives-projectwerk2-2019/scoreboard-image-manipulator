import imageformats;
import draw, config;
import std.stdio;
import std.file;

import std.net.curl;

void main()
{
    const config = readConfig("config.json");

    IFImage img = read_image(config.inFile, 0);
    drawBoard(img, config);

    write_image(config.outFile, img.w, img.h, img.pixels);

    auto buffer = read(config.outFile);
    sendImage(buffer);
}

void sendImage(void[] data) {
    writeln("Sending");
    auto client = HTTP();
    client.addRequestHeader("Content-Type", "image/png");
    post("http://localhost:8080", data, client);
}
