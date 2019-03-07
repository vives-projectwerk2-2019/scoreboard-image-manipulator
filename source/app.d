import config, http;
import std.stdio;

void main()
{
    const config = readConfig("config.json");
    auto server = new Server;
    server.listen(config);
}
