# Network Information Gathering Tool
# Author: Artez Chapman
# Purpose: Comprehensive network configuration documentation for troubleshooting

function Get-NetworkInformation {
    Write-Host "=== Network Information Gathering Tool ===" -ForegroundColor Green
    Write-Host "Generating comprehensive network report..." -ForegroundColor Yellow
    Write-Host "Timestamp: $(Get-Date)" -ForegroundColor Cyan
    
    # System Information
    Write-Host "`n[1] System Overview" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $computerInfo = Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, TotalPhysicalMemory
        Write-Host "OS: $($computerInfo.WindowsProductName)" -ForegroundColor White
        Write-Host "Version: $($computerInfo.WindowsVersion)" -ForegroundColor White
        Write-Host "RAM: $([math]::Round($computerInfo.TotalPhysicalMemory / 1GB, 2)) GB" -ForegroundColor White
    } catch {
        Write-Host "Could not retrieve system information" -ForegroundColor Red
    }
    
    # Network Adapters
    Write-Host "`n[2] Network Adapters" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $adapters = Get-NetAdapter | Select-Object Name, InterfaceDescription, Status, LinkSpeed, MediaType
        foreach ($adapter in $adapters) {
            Write-Host "Name: $($adapter.Name)" -ForegroundColor White
            Write-Host "  Description: $($adapter.InterfaceDescription)" -ForegroundColor Gray
            Write-Host "  Status: $($adapter.Status)" -ForegroundColor $(if($adapter.Status -eq "Up"){"Green"}else{"Red"})
            Write-Host "  Speed: $($adapter.LinkSpeed)" -ForegroundColor White
            Write-Host "  Type: $($adapter.MediaType)" -ForegroundColor Gray
            Write-Host ""
        }
    } catch {
        Write-Host "Could not retrieve network adapter information" -ForegroundColor Red
    }
    
    # IP Configuration
    Write-Host "`n[3] IP Configuration Details" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $ipConfigs = Get-NetIPConfiguration | Where-Object {$_.NetAdapter.Status -eq "Up"}
        foreach ($config in $ipConfigs) {
            Write-Host "Interface: $($config.InterfaceAlias)" -ForegroundColor White
            Write-Host "  IPv4 Address: $($config.IPv4Address.IPAddress)" -ForegroundColor White
            Write-Host "  Subnet Mask: $($config.IPv4Address.PrefixLength)" -ForegroundColor Gray
            Write-Host "  Default Gateway: $($config.IPv4DefaultGateway.NextHop)" -ForegroundColor White
            Write-Host "  DHCP Enabled: $($config.NetAdapter.dhcpEnabled)" -ForegroundColor Gray
            Write-Host ""
        }
    } catch {
        Write-Host "Could not retrieve IP configuration" -ForegroundColor Red
    }
    
    # DNS Configuration
    Write-Host "`n[4] DNS Configuration" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $dnsServers = Get-DnsClientServerAddress | Where-Object {$_.AddressFamily -eq 2}
        foreach ($dns in $dnsServers) {
            Write-Host "Interface: $($dns.InterfaceAlias)" -ForegroundColor White
            Write-Host "  DNS Servers: $($dns.ServerAddresses -join ', ')" -ForegroundColor Gray
            Write-Host ""
        }
    } catch {
        Write-Host "Could not retrieve DNS configuration" -ForegroundColor Red
    }
    
    # Default Routes
    Write-Host "`n[5] Routing Information" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $routes = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object InterfaceAlias, NextHop, RouteMetric
        foreach ($route in $routes) {
            Write-Host "Interface: $($route.InterfaceAlias)" -ForegroundColor White
            Write-Host "  Gateway: $($route.NextHop)" -ForegroundColor Gray
            Write-Host "  Metric: $($route.RouteMetric)" -ForegroundColor Gray
            Write-Host ""
        }
    } catch {
        Write-Host "Could not retrieve routing information" -ForegroundColor Red
    }
    
    # Network Statistics
    Write-Host "`n[6] Network Statistics" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Gray
    
    try {
        $stats = Get-NetAdapterStatistics | Where-Object {$_.Name -in (Get-NetAdapter | Where-Object Status -eq "Up").Name}
        foreach ($stat in $stats) {
            Write-Host "Interface: $($stat.Name)" -ForegroundColor White
            Write-Host "  Bytes Sent: $([math]::Round($stat.BytesSent / 1MB, 2)) MB" -ForegroundColor Gray
            Write-Host "  Bytes Received: $([math]::Round($stat.BytesReceived / 1MB, 2)) MB" -ForegroundColor Gray
            Write-Host "  Packets Sent: $($stat.PacketsSent)" -ForegroundColor Gray
            Write-Host "  Packets Received: $($stat.PacketsReceived)" -ForegroundColor Gray
            Write-Host ""
        }
    } catch {
        Write-Host "Could not retrieve network statistics" -ForegroundColor Red
    }
    
    Write-Host "`n=== Network Information Report Complete ===" -ForegroundColor Green
    Write-Host "This report can be saved for troubleshooting documentation or escalation to Level 2 support." -ForegroundColor Yellow
}

# Function to save report to file
function Save-NetworkReport {
    param(
        [string]$FilePath = "C:\PowerShell-Projects\NetworkReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    )
    
    Write-Host "Saving network report to: $FilePath" -ForegroundColor Green
    
    # Redirect output to file
    Get-NetworkInformation | Out-File -FilePath $FilePath -Encoding UTF8
    
    Write-Host "Report saved successfully!" -ForegroundColor Green
}

# Run the network information gathering
Get-NetworkInformation

# Uncomment the line below to save report to file
# Save-NetworkReport