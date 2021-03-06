import std.file : readText;
import std.process : environment;
import vibe.data.json;

struct ServerConfig
{
    string inFile;
    string mqttBroker;
    ushort mqttPort;
    string subscribeTopic;
    string publishTopic;
}

ServerConfig readConfig(string file, string envString)
{
    // Prioritize env var over config file
    ServerConfig config;
    auto env = environment.get(envString);
    if (env is null)
    {
        config = readText(file).parseJsonString.deserializeJson!ServerConfig;
    }
    else
    {
        config = env.parseJsonString.deserializeJson!ServerConfig;
    }
    return config;
}
