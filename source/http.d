import draw, config;
import imageformats;
import std.conv;
import std.file;
import std.net.curl;
import vibe.core.core : runApplication;
import vibe.data.json;
import vibe.http.server;

class Server {

    Config config;

    this(Config config) {
        this.config = config;
    }
    
    // From game

    void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
    {
        if (req.method == HTTPMethod.POST && req.path == "/") {

            IFImage img = read_image(config.inFile, 0);
            drawBoard(img, req.json.deserializeJson!ScoreboardConfig);
            auto buffer = write_png_to_mem(img.w, img.h, img.pixels);
            write_png("out.png", img.w, img.h, img.pixels);
            sendImage(buffer);

            res.writeBody("Success!\n", "text/plain");
        } else if (req.method == HTTPMethod.GET && req.path == "/") {
            string body = readText("index.html");
            res.writeBody(body, "text/html");
        } else if (req.method == HTTPMethod.GET && req.path == "/image") {
            ubyte[] image = cast(ubyte[])(read("out.png"));
            res.writeBody(image);
        }
    }
    
    void listen()
    {
        auto settings = new HTTPServerSettings;
        settings.port = config.listenPort;
        settings.bindAddresses = [config.listenAddress];
        
        auto l = listenHTTP(settings, &handleRequest);
        scope (exit) l.stopListening();
    
        runApplication();
    }

    // To display
    
    void sendImage(void[] data) {
        auto client = HTTP();
        client.addRequestHeader("Content-Type", "image/png");
        post("http://" ~ config.apiAddress ~ ":" ~ to!string(config.apiPort), data, client);
    }
        
}
