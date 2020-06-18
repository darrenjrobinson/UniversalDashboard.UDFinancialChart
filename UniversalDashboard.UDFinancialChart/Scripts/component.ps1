<#
.SYNOPSIS
    React-StockCharts MovingAverageCrossOverAlgorithmV2, CandleStickChartWithFullStochasticsIndicator, CandleStickChartWithMACDIndicator, CandleStickChartWithRSIIndicator, CandleStickChartWithBollingerBandOverlay, CandleStickChartWithMA, CandleStickChartWithSAR, CandleStickChartWithGannFan, CandleStickStockScaleChartWithVolumeBarV2, CandleStickChartWithEdge, OHLCChartWithElderRayIndicator, OHLCChartWithElderImpulseIndicator & CandleStickChartForContinuousIntraDay.
.DESCRIPTION
    React-StockCharts MovingAverageCrossOverAlgorithmV2, CandleStickChartWithFullStochasticsIndicator, CandleStickChartWithMACDIndicator, CandleStickChartWithRSIIndicator, CandleStickChartWithBollingerBandOverlay, CandleStickChartWithMA, CandleStickChartWithSAR, CandleStickChartWithGannFan, CandleStickStockScaleChartWithVolumeBarV2, CandleStickChartWithEdge, OHLCChartWithElderRayIndicator, OHLCChartWithElderImpulseIndicator & CandleStickChartForContinuousIntraDay.
.PARAMETER Id
    An id for the component 
.EXAMPLE
    PS C:\> New-FinancialChart -stockData "http://localhost:10010/StockData.csv"
    PS C:\> New-FinancialChart -stockData "http://localhost:10010/StockData.csv" -chartType 'MovingAverageCrossOverAlgorithmV2'
.INPUTS
    (required) stockData - CSV delimited Stock Data
    
    (case sensitvie and ordered) Header Columns are;
    Open,High,Close,Low,Volume,Date

    Date format MUST be dd-mm-yyyy (e.g 17-01-2017) except for CandleStickChartForContinuousIntraDay ( date format MUST be in <dd-mm-yyyy hh:mm:ss> )
    Transform the data using PowerShell something like this;
    
    1 Year Stock History Data Transformation, remove double quotes, date into <dd-mm-yyyy> format
    $1y | Select-Object | ConvertTo-Csv -NoTypeInformation -Delimiter "," | ForEach-Object { $_ -replace '"', '' } | ForEach-Object { $_ -replace '/', '-' } | ForEach-Object { $_ -replace ' 10:00:00 PM', '' } | ForEach-Object { $_ -replace ',1-', ',01-' } | ForEach-Object { $_ -replace ',2-', ',02-' } | ForEach-Object { $_ -replace ',3-', ',03-' } | ForEach-Object { $_ -replace ',4-', ',04-' } | ForEach-Object { $_ -replace ',5-', ',05-' } | ForEach-Object { $_ -replace ',6-', ',06-' } | ForEach-Object { $_ -replace ',7-', ',07-' } | ForEach-Object { $_ -replace ',8-', ',08-' } | ForEach-Object { $_ -replace ',9-', ',09-' } | out-file -encoding ASCII "$($Cache:CSVDir)\$($Session:GraphStockSymbol)-AX-1y.csv"

    (optional) chartType - defaults to MovingAverageCrossOverAlgorithmV2

.OUTPUTS
    Financial Chart

.NOTES
    Requires a small NodeJS WebServer to serve up the Stock Data Files. Makes it easy to reference the data    
    Example: https://github.com/darrenjrobinson/NodeWebFileServer
    https://blog.darrenjrobinson.com 
#>
function New-FinancialChart {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$stockData,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [ValidateSet("CandleStickChartWithFullStochasticsIndicator", 
        "MovingAverageCrossOverAlgorithmV2", 
        "CandleStickChartForContinuousIntraDay", 
        "CandleStickChartWithMACDIndicator", 
        "CandleStickChartWithRSIIndicator", 
        "CandleStickChartWithBollingerBandOverlay", 
        "CandleStickChartWithMA", 
        "CandleStickChartWithSAR", 
        "CandleStickChartWithGannFan", 
        "CandleStickStockScaleChartWithVolumeBarV2",
        "CandleStickChartWithEdge",
        "OHLCChartWithElderRayIndicator", 
        "OHLCChartWithElderImpulseIndicator")]
        [string]$chartType = "MovingAverageCrossOverAlgorithmV2")

        End {

        @{
            # The AssetID of the main JS File
            assetId  = $AssetId 
            # Tell UD this is a plugin
            isPlugin = $true 
            # This ID must be the same as the one used in the JavaScript to register the control with UD
            type     = "UDFinancialChart"
            id       = $Id
            stockData     = $stockData
            chartType = $chartType
        }
    }
}
# SIG # Begin signature block
# MIIX8wYJKoZIhvcNAQcCoIIX5DCCF+ACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUrzqI2Fm3pDLCY9cj03IVOLIp
# EeegghMmMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
# AQUFADCBizELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIG
# A1UEBxMLRHVyYmFudmlsbGUxDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhh
# d3RlIENlcnRpZmljYXRpb24xHzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcg
# Q0EwHhcNMTIxMjIxMDAwMDAwWhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJV
# UzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFu
# dGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5Q
# WvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeC
# i2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4
# ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3
# +3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujI
# fKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAd
# BgNVHQ4EFgQUX5r1blzMzHSa1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIG
# CCsGAQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
# YXd0ZVRpbWVzdGFtcGluZ0NBLmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNV
# HQ8BAf8EBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0y
# MDQ4LTEwDQYJKoZIhvcNAQEFBQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdf
# plKfFo3qHJIJRG71betYfDDo+WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y
# 0DGmCFwqevzieh1XTKhlGOl5QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhq
# IhKjURmDfrYwggSjMIIDi6ADAgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3
# DQEBBQUAMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyMB4XDTEyMTAxODAwMDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytT
# eW1hbnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5Ow
# mNutLA9KxW7/hjxTVQ8VzgQ/K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0
# jkBP7oU4uRHFI/JkWPAVMm9OV6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfu
# ltthO0VRHc8SVguSR/yrrvZmPUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqh
# d5NbZcPuF3S8QYYq3AhMjJKMkS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeoz
# C9Lxoxv0i77Zs1eLO94Ep3oisiSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQAB
# o4IBVzCCAVMwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAO
# BgNVHQ8BAf8EBAMCB4AwcwYIKwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRw
# Oi8vdHMtb2NzcC53cy5zeW1hbnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90
# cy1haWEud3Muc3ltYW50ZWMuY29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAx
# oC+gLYYraHR0cDovL3RzLWNybC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNy
# bDAoBgNVHREEITAfpB0wGzEZMBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNV
# HQ4EFgQURsZpow5KFB7VTNpSYxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa
# 1N197z/b7EyALt0wDQYJKoZIhvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcH
# bxiy3iXcoNSUA6qGTiWfmkADHN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73
# BaQ1bHyJFsbpst+y6d0gxnEPzZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDR
# EfzdXHZuT14ORUZBbg2w6jiasTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IW
# yhOBbQAuOA2oKY8s4bL0WqkBrxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysu
# e7ncIAkTcetqGVvP6KUwVyyJST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUw
# ggUwMIIEGKADAgECAhAECRgbX9W7ZnVTQ7VvlVAIMA0GCSqGSIb3DQEBCwUAMGUx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9v
# dCBDQTAeFw0xMzEwMjIxMjAwMDBaFw0yODEwMjIxMjAwMDBaMHIxCzAJBgNVBAYT
# AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
# dC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNp
# Z25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD407Mcfw4R
# r2d3B9MLMUkZz9D7RZmxOttE9X/lqJ3bMtdx6nadBS63j/qSQ8Cl+YnUNxnXtqrw
# nIal2CWsDnkoOn7p0WfTxvspJ8fTeyOU5JEjlpB3gvmhhCNmElQzUHSxKCa7JGnC
# wlLyFGeKiUXULaGj6YgsIJWuHEqHCN8M9eJNYBi+qsSyrnAxZjNxPqxwoqvOf+l8
# y5Kh5TsxHM/q8grkV7tKtel05iv+bMt+dDk2DZDv5LVOpKnqagqrhPOsZ061xPeM
# 0SAlI+sIZD5SlsHyDxL0xY4PwaLoLFH3c7y9hbFig3NBggfkOItqcyDQD2RzPJ6f
# pjOp/RnfJZPRAgMBAAGjggHNMIIByTASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1Ud
# DwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDAzB5BggrBgEFBQcBAQRtMGsw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBDBggrBgEFBQcw
# AoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElE
# Um9vdENBLmNydDCBgQYDVR0fBHoweDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNl
# cnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDA6oDigNoY0aHR0cDov
# L2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDBP
# BgNVHSAESDBGMDgGCmCGSAGG/WwAAgQwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93
# d3cuZGlnaWNlcnQuY29tL0NQUzAKBghghkgBhv1sAzAdBgNVHQ4EFgQUWsS5eyoK
# o6XqcQPAYPkt9mV1DlgwHwYDVR0jBBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8w
# DQYJKoZIhvcNAQELBQADggEBAD7sDVoks/Mi0RXILHwlKXaoHV0cLToaxO8wYdd+
# C2D9wz0PxK+L/e8q3yBVN7Dh9tGSdQ9RtG6ljlriXiSBThCk7j9xjmMOE0ut119E
# efM2FAaK95xGTlz/kLEbBw6RFfu6r7VRwo0kriTGxycqoSkoGjpxKAI8LpGjwCUR
# 4pwUR6F6aGivm6dcIFzZcbEMj7uo+MUSaJ/PQMtARKUT8OZkDCUIQjKyNookAv4v
# cn4c10lFluhZHen6dGRrsutmQ9qzsIzV6Q3d9gEgzpkxYz0IGhizgZtPxpMQBvwH
# gfqL2vmCSfdibqFT+hKUGIUukpHqaGxEMrJmoecYpJpkUe8wggVVMIIEPaADAgEC
# AhAM7NF1d7OBuRMX7VCjxmCvMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25p
# bmcgQ0EwHhcNMjAwNjE0MDAwMDAwWhcNMjMwNjE5MTIwMDAwWjCBkTELMAkGA1UE
# BhMCQVUxGDAWBgNVBAgTD05ldyBTb3V0aCBXYWxlczEUMBIGA1UEBxMLQ2hlcnJ5
# YnJvb2sxGjAYBgNVBAoTEURhcnJlbiBKIFJvYmluc29uMRowGAYDVQQLExFEYXJy
# ZW4gSiBSb2JpbnNvbjEaMBgGA1UEAxMRRGFycmVuIEogUm9iaW5zb24wggEiMA0G
# CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDCPs8uaOSScUDQwhtE/BxPUnBT/FRn
# pQUzLoBTKW0YSKAxUbEURehXJuNBfAj2GGnMOHaB3EvdbxXl1NfLOo3wtRdro04O
# MjOH56Al/9+Rc6DNY48Pl9Ogvuabglah+5oDC/YOYjZS2C9AbBGGRTFjeGHT4w0N
# LLPbxyoTF/wfqZNNy5p+C7823gDR12OvWFgEdTiDnVkn3phxGy8xlK7yrJwFQ0Sn
# z8RknEFSaoKnuYqLvaOiOSG77q6M4+LbGAbwhYToaqWa4xWFFJS8XsX0+t6LA+0a
# Kb3ZEb1GyfySDW2TFf/V1RhuM4iBc6YTUUCj9BTqcpWKgkw2k2xUQHP9AgMBAAGj
# ggHFMIIBwTAfBgNVHSMEGDAWgBRaxLl7KgqjpepxA8Bg+S32ZXUOWDAdBgNVHQ4E
# FgQU6HpAuSSJdceLWep4ajN6JIQcAOgwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQM
# MAoGCCsGAQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6Ly9jcmwzLmRpZ2lj
# ZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3MtZzEuY3JsMDWgM6Axhi9odHRwOi8vY3Js
# NC5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNzLWcxLmNybDBMBgNVHSAERTBD
# MDcGCWCGSAGG/WwDATAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2Vy
# dC5jb20vQ1BTMAgGBmeBDAEEATCBhAYIKwYBBQUHAQEEeDB2MCQGCCsGAQUFBzAB
# hhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTgYIKwYBBQUHMAKGQmh0dHA6Ly9j
# YWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURDb2RlU2ln
# bmluZ0NBLmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQA1agcO
# M3seD1Cs5pnHRXwwrhzieRgF4UMJgDI/9KrBh4C0o8DsXvaa+YlXoTdhmeKW/xv5
# i9mkVNmvD3wa3AKe5CNwiPc5kx96lC7BXWfdLoY7ejfTGkoa7qHR3gusmQhuZW+L
# dFmvtTyu4eqcjhOBthoJYp3B8tv8JR99pSxFfsE6C4VGdhKHAmZkDMiaAHHava9Z
# xl4+Uof+TuS6lQBZJjw8Xw76W93DNU9JUNb4+hOp8jir1q7/RTvtQ3QWr+iEzJD8
# JRfvfXF4LpFvlOOWYOF22EU/ciGjUVfQYi7nk/LnHzipb46747K1BwAVnHbYMDx0
# BRtLc/s4g9qZxTrxMYIENzCCBDMCAQEwgYYwcjELMAkGA1UEBhMCVVMxFTATBgNV
# BAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTExMC8G
# A1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENvZGUgU2lnbmluZyBDQQIQ
# DOzRdXezgbkTF+1Qo8ZgrzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUFex0IDS8CIqZg4uy97fd
# H7OB8iowDQYJKoZIhvcNAQEBBQAEggEAUDTemJ+6k9MdMCxWqDtbl7xcEA+BpfwE
# RtJmwHG+arAg7Og2VfkyhUof0aCXNiR9MrnEBxzbKqJxqz3KHkIoLwYnTxMqpEiB
# N+OgmtfHvxrH7BwvPxJJnc48eD9q7GbbOTtu4zinGtj7LYRRIhJVTWZp7JRW/k2K
# xTKd2HFW7uABT8sEMoVfSTvW+d+JW6L0AUI/CTEzFA/0TYj3rs8jNOnyO2XtlFMj
# wGfTEPhCYjLBlhT3pmjefpvGNhx1Q/pYz5KdxHZ8+MPbBXlZeoCXQ3OTqObNZYRH
# vqwh6UPe0EZfC1bo1UP0n6d93RQyJZ6e6FB7WYtoBvlclvNXUoAR8aGCAgswggIH
# BgkqhkiG9w0BCQYxggH4MIIB9AIBATByMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQK
# ExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBT
# dGFtcGluZyBTZXJ2aWNlcyBDQSAtIEcyAhAOz/Q4yP6/NW4E2GqYGxpQMAkGBSsO
# AwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
# Fw0yMDA2MTgwNTQ4MDhaMCMGCSqGSIb3DQEJBDEWBBQESv4pf4xeY8oH8D50D9Gr
# ruuMWjANBgkqhkiG9w0BAQEFAASCAQCgYH5Lh4dthpv0NFv/NGDXocU99INWNOkz
# rJR8Mmqmj5LDj3+S5TL6jFdeyzd/sECKl7U/qe0dhds7hVnCrnhct0J2u5NrP6ai
# 2d/X3dlc/2N6WffgOKFmdQWyoP+Fd9rz5YdxR3ySIJNGBHZ2wkAyGuO/MXsG+0Oc
# s+lokE3QlxJyRxqhuiOOIkw1tz+E/cNIyjcPb2MwfW2z5v5kohka5gHls4Y3Axng
# iPu+C6CAspHP1wlsAoE1kdrmRdT5G5nbu67J28E6iMHE6PwjUjTdknB1k+GjpttB
# fcMrBYaQFNENDjaHUh0GUi/c1/jd4i7c6PxCvvetdjXoi/gWOGes
# SIG # End signature block
