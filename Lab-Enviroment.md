# PowerShell Development Lab Environment

## Infrastructure Overview

**Hypervisor:** Oracle VirtualBox 7.x  
**Host OS:** Windows 10/11  
**Guest OS:** Windows 10 Pro (Evaluation License)  
**Purpose:** Safe PowerShell script development and network troubleshooting testing

## Virtual Machine Specifications

- **RAM:** 4GB allocated
- **Storage:** 60GB dynamically allocated VDI
- **CPU:** 2 cores with VT-x enabled
- **Network:** NAT configuration for internet access
- **Snapshots:** Multiple restore points for safe testing

## Development Environment

### PowerShell Configuration
- **Windows PowerShell 5.1** (built-in)
- **PowerShell 7** (latest stable release)
- **Execution Policy:** RemoteSigned for local script development

### Development Tools
- **VS Code** with PowerShell extension (ms-vscode.powershell)
- **Git for Windows** for version control integration
- **Windows Terminal** for enhanced command-line experience


## Testing Methodology

### Safe Development Practices
- **Isolated Environment:** VM cannot affect host system or production networks
- **Snapshot Management:** Create restore points before testing new scripts
- **Version Control:** All changes tracked with Git for rollback capability
- **Network Isolation:** NAT configuration prevents impact to local network

### Testing Workflow
1. Create VM snapshot before major changes
2. Develop and test scripts in isolated environment
3. Validate functionality with real network diagnostics
4. Document results and commit working code
5. Restore snapshot if testing causes issues

## Network Testing Capabilities

### Available Test Scenarios
- **Connectivity troubleshooting** using safe external targets (8.8.8.8, 1.1.1.1)
- **DNS resolution testing** with multiple DNS servers
- **Network adapter configuration** validation and documentation
- **PowerShell network cmdlet** functionality verification

### Safety Measures
- **Read-only operations:** Scripts focus on diagnostic commands, not system changes
- **External targets only:** No testing against internal corporate networks
- **Documented procedures:** All testing methods clearly explained and repeatable

## Professional Development Benefits

### Skills Demonstrated
- **Virtualization Management:** VM configuration and snapshot strategies
- **Development Environment Setup:** Professional toolchain configuration
- **Risk Management:** Safe testing practices and change control
- **Documentation Standards:** Clear technical communication and process documentation

### Career Relevance
This lab environment demonstrates practical experience with technologies and methodologies used in enterprise IT environments, including virtualization, version control, and systematic testing approaches essential for infrastructure specialist roles.

## Continuous Improvement

### Future Enhancements
- Integration with cloud development platforms
- Automated testing frameworks for script validation
- Advanced networking scenarios for complex troubleshooting
- Documentation of additional PowerShell modules and capabilities

---

*This lab environment supports the development of practical PowerShell tools for network troubleshooting while maintaining professional development standards and safety practices.*

