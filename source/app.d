import config, http;

void main()
{
    const config = readConfig("config.json", "SCOREBOARD_CONFIG");
    auto server = new Server(config);
    server.listen();
}
