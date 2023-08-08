# Define los GUIDs de las subcategorías para "File System" y "Removable Storage".
$fsGuid = "{0CCE9224-69AE-11D9-BED3-505054503030}"
$rsGuid = "{0CCE9225-69AE-11D9-BED3-505054503030}"

# Activa la auditoría en las subcategorías definidas.
$auditCmd = "auditpol /set /subcategory:""$fsGuid"" /success:enable /failure:enable"
Invoke-Expression $auditCmd
$auditCmd = "auditpol /set /subcategory:""$rsGuid"" /success:enable /failure:enable"
Invoke-Expression $auditCmd

# Obtiene la lista de todos los eventos en el registro de seguridad.
$events = Get-WinEvent -LogName Security

# Filtra los eventos para incluir aquellos con los Event IDs correspondientes (4663, 4656, 4660, 4659).
$relevantEvents = $events | Where-Object {
    ($_.ID -eq 4663 -or $_.ID -eq 4656 -or $_.ID -eq 4660 -or $_.ID -eq 4659) -and
    $_.ProviderName -eq "Microsoft-Windows-Security-Auditing"
}

# Crea un objeto personalizado para almacenar la información.
$eventInfo = @()

# Procesa los eventos y obtiene información relevante.
foreach ($event in $relevantEvents) {
    $properties = $event.Properties
    $eventId = $event.ID
    $userName = $properties[1].Value
    $eventType = switch ($eventId) {
        4663 { "Event ID 4663 (Accesses: DELETE)" }
        4656 { "Event ID 4656 (File System/Removable Storage Task Category)" }
        4660 { "Event ID 4660 (File and Folder Deletions)" }
        4659 { "Event ID 4659 (Folder Deletions)" }
    }
    $dateTime = $event.TimeCreated
    $eventInfo += [PSCustomObject]@{
        'Tipo de Evento' = $eventType
        Usuario = $userName
        'Fecha/Hora' = $dateTime
    }
}

# Muestra la información en la terminal.
$eventInfo | Format-Table -AutoSize
