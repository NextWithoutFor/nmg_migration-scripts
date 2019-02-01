<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	1/31/2019 3:30 PM
	 Created by:   	 Keith Horsey
	 Organization: 	 Deluxe Entertainment Services Group
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force

# Set up the preliminary parameters for the script
PowerShell param([Parameter(Mandatory)][string]$ActivationCode,
	[Parameter(Mandatory)][string]$ActivationId,
	[Parameter()][string]$Region = 'us-west-1')

# Grab the installer file and download it to temp
$installerFilePath = "$env:Temp.exe" if (-not (Test-Path -Path $installerFilePath)) { $iwrParams = @{ Uri = "https://amazon-ssm-$Region.s3.amazonaws.com/latest/windows_amd64/AmazonSSMAgentSetup.exe" UseBasicParsing = $true OutFile = $installerFilePath } Invoke-WebRequest @iwrParams }

# Run the installer
$procParams = @{ FilePath = $installerFilePath  ArgumentList = @('/q', '/log', "`"$env:Temp.log`"", "CODE=$ActivationCode", "ID=$ActivationId", "REGION=$Region") Wait = $true NoNewWindow = $true } Write-Host "Installing SSM agent with arguments: [$($procParams.ArgumentList)]" Start-Process @procParams
