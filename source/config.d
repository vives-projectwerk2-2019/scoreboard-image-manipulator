import std.file;
import std.process;
import vibe.data.json;

struct ServerConfig {
    string inFile;
    string listenAddress;
    ushort listenPort;
    string apiAddress;
    ushort apiPort;
}

ServerConfig readConfig(string file, string envString) {
    // Prioritize env var over config file
    ServerConfig config;
    auto env = environment.get(envString);
    if (env is null) {
        config = readText(file).parseJsonString.deserializeJson!ServerConfig;
    } else {
        config = env.parseJsonString.deserializeJson!ServerConfig;
    }
    return config;
}
