# Win-Enum
My attempt at an enumeration script for Windows

# Parameters
- help: Displays this message
- verbose: Indicates you want verbose output, this will print all the processes/services regardless of the limit
- loop: Indicates if you want the script to loop infinitely
- limit: Limit the number of processes/services to display. Default is 20
- sleep\_time: The amount of time to sleep between each run of the script. Default is 20 seconds

# Example Usage (When the script is saved locally)
- First, dot source the script
     ```. .\win-enum.ps1```
- Run the script, no looping, default settings<br>
     ```Invoke-WinEnum```
- Run the script, loop infinitely, default settings<br>
     ```Invoke-WinEnum -loop```
- Run the script, loop, verbose output<br>
     ```Invoke-WinEnum -loop -verbose```
- Run the script, loop, limit the output of processes/services to 10<br>
     ```Invoke-WinEnum -loop -limit 10```
- Run the script, loop, set sleep time to 5 seconds<br>
     ```Invoke-WinEnum -loop -sleep_time 5```

# Example Usage (When the script isn't saved locally)
- Run the script, no looping, default settings<br>
```IEX (New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/wmrabb11/win-enum/master/win-enum.ps1") | Invoke-WinEnum```
