import scoreboard.draw, scoreboard.config, config;
import std.datetime;
import std.file;
import std.process;
import std.stdio;
import vibe.core.core : runApplication, runTask, sleep;
import vibe.data.json;
import imageformats;
import mqttd;

class Server {

    ServerConfig config;

    this(ServerConfig config) {
        this.config = config;
    }

    //Only trusted (non-safe) function
    @trusted auto drawImage(immutable void[] data) {
        IFImage img = read_image(config.inFile, 0);
        drawBoard(img, parseJsonString(cast(string)data).deserializeJson!ScoreboardConfig);
        immutable ubyte[] buffer = write_png_to_mem(img.w, img.h, img.pixels).idup;
        return buffer;
    }
    
    Settings SetupMqtt()
    {
        auto settings = Settings();
        settings.host = config.mqttBroker;
        //settings.port = config.mqttPort;
        settings.clientId = "Scoreboard generator";
        settings.reconnect = 1;
        settings.onPublish = (scope MqttClient ctx, in Publish packet)
        {
            if (packet.topic == config.subscribeTopic) {
                runTask((){
                    immutable ubyte[] pngBuffer = drawImage(packet.payload.idup);
                    ctx.publish(config.publishTopic, pngBuffer, QoSLevel.QoS2);
                });
            }
        };
        settings.onConnAck = (scope MqttClient ctx, in ConnAck packet)
        {
            if (packet.returnCode != ConnectReturnCode.ConnectionAccepted) return;
            writeln("Connected to ", config.mqttBroker);
            ctx.subscribe(["scoreboard"], QoSLevel.QoS2);
        };
        return settings;
    }
    
    void listen()
    {
        auto mqtt = new MqttClient(SetupMqtt());
        mqtt.connect();
    
        runApplication();
    }
}
