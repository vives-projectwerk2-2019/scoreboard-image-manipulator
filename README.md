# scoreboard-image-manipulator
Image manipulator for updating the scoreboard

## Running
Run `dub` in the root directory.

## Building for release
```
dub build -b release
```

## Rest interface
To use the application, send a post request with `Content-Type: application/json` with the json scoreboard layout as body.

Example:
```json
{
  "title": "Scoreboard",
  "player1": {
    "shortName": "RVR",
    "bars": [1,0.3,0.7]
  },
  "player2": {
    "shortName": "BAR",
    "bars": [0.4,0,0.7]
  },
  "player3": {
    "shortName": "FBAR",
    "bars": [0.8,1,0.4]
  },
  "player4": {
    "shortName": "BAZ",
    "bars": [0.6,0.8,0.2]
  }
}
```

## Issues with ssl
On some systems ssl library versions differ, try this instead:
```
dub --override-config vibe-d:tls/openssl-1.1
```

## Running the benchmark (out of date)
```
./benchmark.sh
```
The important value is the 'real' time
