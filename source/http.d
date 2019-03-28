import scoreboard.draw, scoreboard.config, config;
import imageformats;
import std.conv;
import std.file;
import std.net.curl;
import std.process;
import std.stdio;
import vibe.core.core : runApplication;
import vibe.data.json;
import vibe.http.server;

class Server {

    ServerConfig config;

    this(ServerConfig config) {
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
        } else if (req.method == HTTPMethod.GET && req.path == "/upload") {
            string body = readText("upload.html");
            res.writeBody(body, "text/html");
        } else if (req.method == HTTPMethod.POST && req.path == "/upload") {
            writeln(req.files);
            auto f = req.files["image"];
            IFImage img;
            auto str = to!string(f.tempPath);
            try {
                img = read_image(to!string(f.tempPath));
            } catch (Exception e) {
                res.writeBody("Invalid image format");
            }
            write_png("out.png", img.w, img.h, img.pixels);

            auto pid = std.process.spawnShell("convert " ~ to!string(f.tempPath) ~ " -resize 96x64\\! -background black -extent 0x0 +matte -strip out-resized.png");
            std.process.wait(pid);

            img = read_image("out.png");
            auto buffer = write_png_to_mem(img.w, img.h, img.pixels);
            sendImage(buffer);
            
            res.redirect("/upload");
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
        writeln(post("http://" ~ config.apiAddress ~ ":" ~ to!string(config.apiPort), data, client));
    }
}
