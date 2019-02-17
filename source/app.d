import std.stdio, imageformats;
import area, color, draw;

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
