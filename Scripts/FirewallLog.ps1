# Gets logs from firewall and puts it into paresable format

Get-Content -path C:\fw.log | Select-Object -Skip 4 | ConvertFrom-Csv -Header "date", "time", "action", "protocol", "SrcIp", "DstIp", "SrcPort", "DstPort", "Size" -Delimiter ' '

# Gets count of IP addresses in the log file 

select-string "\b(?:\d{1,3}\.){3}\d{1,3}\b" $env:systemroot\system32\LogFiles\Firewall\pfirewall.log | select -ExpandProperty matches | select value  | group value  | sort count –des
