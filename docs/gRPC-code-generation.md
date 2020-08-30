# gRPC Code Generation
WORK IN PROGRESS

## Generate proto codes in Python
```sh
python -m grpc_tools.protoc --proto_path=. --python_out=. --grpc_python_out=. ./proto/RobotBackendCommunication.proto
```

## Generate proto codes in C#
## Prerequisite
The different components communicates through gRPC protocol. For instance AI Remote Brain communicates to AI Backend Connector and also to AI Simulator with gRPC:

## Download gRPC plugins
gRPC is a Remote Procedure Call developed by google, it is an open source high performance RPC framework that can run in any environment. More information at https://grpc.io/.

# Generate gRPC code
If you have made changes to the .proto-file you need to create the gRPC code files again using these steps.

gRPC code is based .proto-files. The required C# code for the Unity is generated automatically by using those .proto files.

Set environmental variables for the input and output path for the protoc-executable to generate the gRPC code from the .proto-file
- INPUTPATH=/path/to/Assets/Proto
- OUTPUTPATH=/path/to/Assets/Proto/GeneratedCode

Run the following command to generate the gRPC code from the .proto-file:
```
$PROTOCPATH/protoc \
    --plugin=protoc-gen-grpc=$PROTOCPATH/grpc_csharp_plugin \
    --proto_path=$INPUTPATH \
    --csharp_out=$OUTPUTPATH \
    --grpc_out=$OUTPUTPATH \
    $INPUTPATH/BrainCommunication.proto
```


You may get the error message: “zsh: permission denied: /folder_path/grpc-protoc_macos_x64-1.15.0-dev/protoc”. This hints “protoc” does not have executable permission, which you could confirm by:
```
ls -l $PROTOCPATH/protoc 
```

**TODO: May need some refactoring, at least I don't understand Windows part?**

If it gives a message starting with “-rw-r--r-”, it means the “protoc” file is not executable. To resolve this issue, set “roto_path”, “csharp_out” and “grpc_out” in a similar way as above for Windows 10.

Different from the way for Windows, in macOS, you need to install the following python modules to run the generator:
```
python -m pip install grpcio
python -m pip install grpcio-tools
```
and then run
```
python -m grpc_tools.protoc
```


Unity ML-Agents already uses gRPC version “1.14.1” so let's take the closest build which is “1.15.0”.

- Click the last Build ID with timestamp 2018-07-25T14:35:05-0700 on the Daily Builds of master Branch table [here](https://packages.grpc.io/)
- On the gRPC archive webpage download the right package for your system from the gRPC protoc Plugins table. For me on Ubuntu 18.04 it was grpc-protoc_linux_x64-1.15.0-dev.tar.gz
- Unpack the gRPC protoc Plugins file anywhere
- On the terminal set the path to the folder generated from the archive to an environmental variable `PROTOCPATH=/path/to/folder`