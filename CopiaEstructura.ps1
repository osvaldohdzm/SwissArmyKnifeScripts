function Prompt-PathSelection {
    param(
        [string]$Description
    )

    do {
        $path = Read-Host $Description
    } while (-not (Test-Path -Path $path -PathType Container))

    return $path
}

# Solicitar la ubicación de la carpeta de origen
$origen = Prompt-PathSelection -Description "Ingresa la ruta de la carpeta de origen"

# Solicitar el nombre de la carpeta de destino
$nombreDestino = Read-Host "Ingresa el nombre de la carpeta de destino"

# Verificar si se ingresó un nombre de carpeta de destino
if ([string]::IsNullOrWhiteSpace($nombreDestino)) {
    Write-Host "No se ingresó ningún nombre de carpeta de destino. El script se detendrá."
    exit
}

# Solicitar la ubicación de la carpeta destino padre
$carpetaDestinoPadre = Prompt-PathSelection -Description "Ingresa la ruta de la carpeta destino padre"

# Crear la ruta completa de la carpeta destino
$destino = Join-Path -Path $carpetaDestinoPadre -ChildPath $nombreDestino

# Verificar si la carpeta de origen existe
if (-not (Test-Path -Path $origen -PathType Container)) {
    Write-Host "La carpeta de origen no existe. El script se detendrá."
    exit
}

# Verificar si la carpeta de destino ya existe
if (Test-Path -Path $destino -PathType Container) {
    Write-Host "La carpeta de destino ya existe. El script se detendrá."
    exit
}

# Crear la carpeta de destino
New-Item -ItemType Directory -Path $destino | Out-Null

# Recorrer la estructura de directorios
Get-ChildItem -Path $origen -Recurse | Where-Object { $_.PsIsContainer } | ForEach-Object {
    $newPath = Join-Path -Path $destino -ChildPath $_.FullName.Substring($origen.Length)
    New-Item -ItemType Directory -Path $newPath | Out-Null
}

Write-Host "La copia de la estructura de directorios ha finalizado correctamente."
