module scoreboard.area;

struct Area {
    int x;
    int y;
    int w;
    int h;
}

class Areas {
    // Static areas for the template image
    public static const:
        Area[10] scoreboard = [
            {8, 4, 8, 8},
            {16, 4, 8, 8},
            {24, 4, 8, 8},
            {32, 4, 8, 8},
            {40, 4, 8, 8},
            {48, 4, 8, 8},
            {56, 4, 8, 8},
            {64, 4, 8, 8},
            {72, 4, 8, 8},
            {80, 4, 8, 8}
        ];

        Area scoreboard_bg = {0, 0, 96, 15};
        Area players_bg = {0, 15, 96, 49};

        Area[4] player1_name = [
            {10, 18, 8, 8},
            {18, 18, 8, 8},
            {26, 18, 8, 8},
            {34, 18, 8, 8}
        ];

        Area[3] player1_bars = [
            {10, 29, 32, 1},
            {10, 32, 32, 1},
            {10, 35, 32, 1}
        ];


        Area[4] player2_name = [
            {10, 40, 8, 8},
            {18, 40, 8, 8},
            {26, 40, 8, 8},
            {34, 40, 8, 8}
        ];

        Area[3] player2_bars = [
            {10, 51, 32, 1},
            {10, 54, 32, 1},
            {10, 57, 32, 1}
        ];

        Area[4] player3_name = [
            {54, 18, 8, 8},
            {62, 18, 8, 8},
            {70, 18, 8, 8},
            {78, 18, 8, 8}
        ];

        Area[3] player3_bars = [
            {54, 29, 32, 1},
            {54, 32, 32, 1},
            {54, 35, 32, 1}
        ];


        Area[4] player4_name = [
            {54, 40, 8, 8},
            {62, 40, 8, 8},
            {70, 40, 8, 8},
            {78, 40, 8, 8}
        ];

        Area[3] player4_bars = [
            {54, 51, 32, 1},
            {54, 54, 32, 1},
            {54, 57, 32, 1}
        ];
}
