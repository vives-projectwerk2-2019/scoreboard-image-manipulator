import std.file;
import vibe.data.json;

struct Config {
    string inFile;
    string listenAddress;
    ushort listenPort;
    string apiAddress;
    string apiPort;
}

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

Config readConfig(string file) {
    return readText(file).parseJsonString.deserializeJson!Config;
}
