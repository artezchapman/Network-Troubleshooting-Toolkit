# DNS Diagnostics Tool
# Author: Artez Chapman
# Purpose: Comprehensive DNS troubleshooting based on ISP support experience

function Test-DNSConfiguration {
    Write-Host "=== DNS Diagnostics Tool ===" -ForegroundColor Green
    Write-Host "Timestamp: $(Get-Date)" -ForegroundColor Yellow
    
    # Current DNS servers
    Write-Host "`n[1] Current DNS Configuration..." -ForegroundColor Cyan
    try {
        $dnsConfig = Get-DnsClientServerAddress | Where-Object {$_.AddressFamily -eq 2}
        $dnsConfig | Select-Object InterfaceAlias, ServerAddresses | Format-Table -AutoSize
    } catch {
        Write-Host "Could not retrieve DNS configuration" -ForegroundColor Red
    }
    
    # Test common DNS servers
    Write-Host "`n[2] Testing DNS Server Performance..." -ForegroundColor Cyan
    
    $dnsServers = @(
        @{Name="Google DNS Primary"; IP="8.8.8.8"},
        @{Name="Cloudflare DNS"; IP="1.1.1.1"},
        @{Name="OpenDNS"; IP="208.67.222.222"}
    )
    
    $testDomain = "google.com"
    
    foreach ($dns in $dnsServers) {
        Write-Host "Testing $($dns.Name) [$($dns.IP)]..." -ForegroundColor Yellow
        
        try {
            $startTime = Get-Date
            $result = Resolve-DnsName -Name $testDomain -Server $dns.IP -Type A -ErrorAction Stop
            $endTime = Get-Date
            $responseTime = ($endTime - $startTime).TotalMilliseconds
            
            Write-Host "Success - Response time: $([math]::Round($responseTime, 2))ms" -ForegroundColor Green
        } catch {
            Write-Host "Failed: DNS server not responding" -ForegroundColor Red
        }
    }
    
    Write-Host "`n=== DNS Diagnostics Complete ===" -ForegroundColor Green
}

# Run the diagnostic function
Test-DNSConfiguration