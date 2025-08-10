# Network Connectivity Test Script
# Author: Artez Chapman

function Get-NetworkBasics {
    Write-Host "=== Network Diagnostics ===" -ForegroundColor Green
    
    # Network adapters
    Write-Host "`n[1] Active Network Adapters:" -ForegroundColor Cyan
    Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | 
        Select-Object Name, InterfaceDescription, LinkSpeed | 
        Format-Table -AutoSize
    
    # IP configuration  
    Write-Host "`n[2] IP Configuration:" -ForegroundColor Cyan
    Get-NetIPConfiguration | 
        Select-Object InterfaceAlias, IPv4Address, IPv4DefaultGateway |
        Format-Table -AutoSize
}

# Run the function
Get-NetworkBasics