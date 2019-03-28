module scoreboard.config;

struct ScoreboardConfig {
    string title;
    PlayerConfig player1;
    PlayerConfig player2;
    PlayerConfig player3;
    PlayerConfig player4;
}

struct PlayerConfig {
    string shortName;
    double[3] bars;
}
