import std.file;
import std.process;
import vibe.data.json;

struct Config {
    string inFile;
    string listenAddress;
    ushort listenPort;
    string apiAddress;
    ushort apiPort;
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

Config readConfig(string file, string envString) {
    // Prioritize env var over config file
    Config config;
    auto env = environment.get(envString);
    if (env is null) {
        config = readText(file).parseJsonString.deserializeJson!Config;
    } else {
        config = env.parseJsonString.deserializeJson!Config;
    }
    return config;
}
