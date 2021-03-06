module scoreboard.config;

struct ScoreboardConfig
{
    string title;
    PlayerConfig player1;
    PlayerConfig player2;
    PlayerConfig player3;
    PlayerConfig player4;
}

struct PlayerConfig
{
    bool active;
    string shortName;
    double[2] bars;
}
