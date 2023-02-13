# dotnet-run-7
Lightweight (Alpine) based .NET Framework 7 runtime container with a few tweaks:

* Uses [dumb-init](https://github.com/Yelp/dumb-init) to ensure proper signalling
* Automatically attempts to find and start proper dll
* Run as `dotnet` (uid/gid: 1737) user/group

Note: It's assumed that the application is [framework-dependent](https://learn.microsoft.com/en-us/dotnet/core/deploying/), and so is _not_ built as a self-contained deployment.

## Usage
```powershell
# run the .net v6 web app in the current directory (browse using http://localhost:8123)
docker run -p 8123:80 --rm -v ${PWD}:/app boeegh/dotnet-run-7

# manually specify the dll to run (the default .net image behaviour)
docker run -v ${PWD}:/app boeegh/dotnet-run-7 dotnet ./MyApp.dll
```

_Please note this is an experimental image that may... explode at any time. Use with caution. Or not at all._
