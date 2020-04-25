param (
    [switch]$verbose = $false,
    [switch]$help = $false,
    [switch]$loop = $false,
    [int]$limit = 20,
    [int]$sleep_time = 20
)

function print_usage {
    Write-Host "Win-Enum: A Powershell Enumeration Script for Windows"
    Write-Host "Parameters:"
    Write-Host "     -verbose: Indicates you want verbose output, this will print all the processes/services regardless of the limit"
    Write-Host "     -help: Displays this message"
    Write-Host "     -loop: Indicates if you want the script to loop infinitely"
    Write-Host "     -limit: Limit the number of processes/services to display. Default is 20"
    Write-Host "     -sleep_time: The amount of time to sleep between each run of the script. Default is 20 seconds"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "-Run the script, no looping, default settings"
    Write-Host "     '.\win-enum.ps1'"
    Write-Host ""
    Write-Host "-Run the script, loop infinitely, default settings"
    Write-Host "     '.\win-enum.ps1 -loop'"
    Write-Host ""
    Write-Host "-Run the script, loop, verbose output"
    Write-Host "     '.\win-enum.ps1 -loop -verbose'"
    Write-Host ""
    Write-Host "-Run the script, loop, limit the output of processes/services to 10"
    Write-Host "     '.\win-enum.ps1 -loop -limit 10'"
    Write-Host ""
    Write-Host "-Run the script, loop, set sleep time to 5 seconds"
    Write-Host "     '.\win-enum.ps1 -loop -sleep_time 5'"
}

function check_admin {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function check_ep($isAdmin) {
    Write-Host "[*] EXECUTION POLICIES"
    Get-ExecutionPolicy -List | Format-Table -AutoSize
}

function user_info {
    Write-Host "[*] USER INFO"
    whoami /all
}

function print_procs($isAdmin) {
    Write-Host "[*] PROCESSES"
    if ($verbose) {
        if ($isAdmin) {
            Get-Process -IncludeUserName | sort -des cpu | Format-Table -AutoSize
        } else {
            Get-Process | sort -des cpu | Format-Table -AutoSize
        }
    } else {
        if ($isAdmin) {
            Get-Process -IncludeUserName | sort -des cpu | select -f $limit | Format-Table -AutoSize
        } else {
            Get-Process | sort -des cpu | select -f $limit | Format-Table -AutoSize
        }
    }
}

function print_servs {
    Write-Host "[*] SERVICES"
    if ($verbose) {
        Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table -AutoSize
    } else {
        Get-Service | Where-Object {$_.Status -eq "Running"} | select -f $limit | Format-Table -AutoSize
    }
}

function main_logic {
    Write-Host "[*] Running as $($env:USERNAME)"
    $isAdmin = check_admin
    if ($isAdmin) {
        Write-Host "[+] YOU HAVE ADMIN RIGHTS"
    }
    user_info
    check_ep
    print_procs $isAdmin
    print_servs
}

function main {
    if ($help) {
        print_usage
        return
    }
    if ($loop){
        While (1) {
            main_logic
            sleep $sleep_time
            Clear-Host
        }
    } else {
        main_logic
    }
}

main