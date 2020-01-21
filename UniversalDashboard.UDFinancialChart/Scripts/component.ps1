<#
.SYNOPSIS
    React-StockCharts MovingAverageCrossOverAlgorithmV2, CandleStickChartWithFullStochasticsIndicator, CandleStickChartWithMACDIndicator, CandleStickChartWithRSIIndicator, CandleStickChartWithBollingerBandOverlay, CandleStickChartWithMA & CandleStickChartForContinuousIntraDay.
.DESCRIPTION
    React-StockCharts MovingAverageCrossOverAlgorithmV2, CandleStickChartWithFullStochasticsIndicator, CandleStickChartWithMACDIndicator, CandleStickChartWithRSIIndicator, CandleStickChartWithBollingerBandOverlay, CandleStickChartWithMA & CandleStickChartForContinuousIntraDay.
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
        [ValidateSet("CandleStickChartWithFullStochasticsIndicator", "MovingAverageCrossOverAlgorithmV2", "CandleStickChartForContinuousIntraDay", "CandleStickChartWithMACDIndicator", "CandleStickChartWithRSIIndicator", "CandleStickChartWithBollingerBandOverlay", "CandleStickChartWithMA")]
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