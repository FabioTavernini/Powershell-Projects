$SortPath = Read-Host -Prompt "Pfad zum sortieren"
$Destination = Read-Host -Prompt "Ziel-Pfad"

function GO {

    Write-Host $Destination

    $Items = Get-ChildItem $SortPath -Recurse | Group-Object { $_.LastWriteTime.ToString("yyyy-MM-dd") } | Sort-Object Count -Descending

    New-Item -Path $Destination\Dir -ItemType Directory

    foreach ($Groups in $Items) {

        $pathname = $groups.Name

        New-Item -Path "$Destination\Dir\$pathname" -ItemType Directory

        Foreach ($Group in $Groups) {

            $exclude = Get-ChildItem -recurse "$Destination\Dir\$pathname\"
            Copy-Item -Path $group.Group.FullName -Destination "$Destination\Dir\$pathname\" -Force -Exclude $exclude

        }
    }
}

function TestPaths {


    $ValidSort = Test-Path $SortPath
    $ValidDest = Test-Path $Destination

    if ($ValidSort -eq $true -and $ValidDest -eq $true) {

        GO

    }
    else {
        write-host "Einer beider pfade nicht korrekt"

        TestPaths
    }


}


TestPaths