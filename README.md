# Docker container for SpanDSP

- Docker container for running [SpanDSP](https://github.com/freeswitch/spandsp)
- Builds version 3.0.0 from [Buildroot](https://sources.buildroot.net/spandsp/)
- [Github Repo](https://github.com/sieteunoseis/spandsp)
- [Docker Hub](https://hub.docker.com/r/sieteunoseis/spandsp/)

## Getting Started

Pull the latest image using:

```
$ docker pull ghcr.io/sieteunoseis/spandsp:main
```

or clone this repo and build the image locally:

```
$ docker build -t spandsp .
```

## Basic Usage

```
docker run -it ghcr.io/sieteunoseis/spandsp:main
```

Will give you a bash shell where you can run the spandsp commands manually. See [SpanDSP](https://www.soft-switch.org/spandsp-modules.html) for more information on the available commands.

## Detailed Usage

### Fax Decode

```
$ docker run --rm -it -v $(pwd)/data:/data -w /data ghcr.io/sieteunoseis/spandsp:main fax_decode ./wav/ECM-call-mono.wav
```
This will decode the ECM-call-mono.wav file and create a fax_decode.tif file. You can then view this file using an image viewer. 

Note: That the fax_decode.tif file will be created in the working directory specified in the -w argument within the container. This directory is then mounted to a local directory on the host machine with the -v argument.

### Convert Options

#### Convert Stereo to Mono

If your wav file is stereo, you can convert it to mono using the following command, before running the fax_decode command:

```
$ docker run --rm -it -v $(pwd)/data:/data -w /data/wav ghcr.io/sieteunoseis/spandsp:main ffmpeg -i ECM-call.wav -af "pan=mono|c0=FR" mono.wav
```

This will save the right channel of the stereo file as a mono file. You can then use this file with the *fax_decode* command. If you want to use the left channel, change c0=FR to c0=FL.

#### Merge TIF files

If the resulting fax_decode.tif file is split into multiple pages, you can merge them using the following command:

```
$ docker run --rm -it -v $(pwd)/data:/data -w /data ghcr.io/sieteunoseis/spandsp:main convert fax_decode.tif -append merged.tif
```
This will combine the pages into a single file.

Use the *-append* option to merge the files vertically and the *+append* option to merge them horizontally depending on the orientation of the pages.

### G711 Tests

```
$ docker run --rm -it -v $(pwd)/data:/data -w /data/wave ghcr.io/sieteunoseis/spandsp:main g711_tests -d ECM-call.wav
```
Transcode the provided wav file to a-law and u-law formats based flags provided. See [SpanDSP](https://www.soft-switch.org/spandsp-modules.html) for more information on the available commands. 

### Additional Information can be found at:

- [Soft-Switch](https://www.soft-switch.org/)
- [Sounds of Fax Modes and ECM](https://goughlui.com/2013/02/13/sounds-of-fax-modes-and-ecm/)
- [Fax Technicalities & Audio Samples](https://goughlui.com/project-fax/fax-technicalities-audio-samples/)
- [Decode a fax](https://www.journaldulapin.com/2022/10/10/decode-fax/)
- [buildroot](https://sources.buildroot.net/spandsp/)

### Giving Back

If you would like to support my work and the time I put in creating the code, you can click the image below to get me a coffee. I would really appreciate it (but is not required).

<a href="https://www.buymeacoffee.com/automatebldrs" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>