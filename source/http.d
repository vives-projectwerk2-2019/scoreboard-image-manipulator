import draw, config, http;
import imageformats;
import std.file;
import std.net.curl;
import vibe.core.core : runApplication;
import vibe.data.json;
import vibe.http.server;

// To display

void sendImage(void[] data) {
    auto client = HTTP();
    client.addRequestHeader("Content-Type", "image/png");
    post("http://localhost:3000", data, client);
}

// From game

class Server {

    Config config;
    
    void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
    {
        if (req.method == HTTPMethod.POST && req.path == "/") {

            IFImage img = read_image(config.inFile, 0);
            drawBoard(img, req.json.deserializeJson!ScoreboardConfig);
            auto buffer = write_png_to_mem(img.w, img.h, img.pixels);
            sendImage(buffer);

            res.writeBody("Success!\n", "text/plain");
        }
    }
    
    void listen(Config config)
    {
        this.config = config;

        auto settings = new HTTPServerSettings;
        settings.port = config.listenPort;
        settings.bindAddresses = [config.listenAddress];
        
        auto l = listenHTTP(settings, &handleRequest);
        scope (exit) l.stopListening();
    
        runApplication();
    }
    
}
