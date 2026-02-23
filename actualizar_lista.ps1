# Script para actualizar la lista de estudiantes automáticamente
# Instrucciones: Coloca tus fotos en la carpeta 'fotos/[Nivel]'
# Nombre del archivo: 'Cédula - Apellidos y Nombres.jpg'

$fotosDir = Join-Path $PSScriptRoot "fotos"
$outputFile = Join-Path $PSScriptRoot "estudiantes.js"

if (-not (Test-Path $fotosDir)) {
    Write-Host "Error: No se encontró la carpeta 'fotos'." -ForegroundColor Red
    pause
    exit
}

$estudiantes = @()

# Obtener niveles (subcarpetas)
$niveles = Get-ChildItem -Path $fotosDir -Directory

foreach ($nivelDir in $niveles) {
    $nivelNombre = $nivelDir.Name
    # Obtener todas las imágenes sin usar -Include para evitar problemas de ruta
    $fotos = Get-ChildItem -Path $nivelDir.FullName -File | Where-Object { 
        $_.Extension -match "\.(jpg|jpeg|png|webp|JPG|JPEG|PNG|WEBP)$" 
    }

    foreach ($foto in $fotos) {
        $fileName = $foto.BaseName
        $cedula = "Sin Cédula"
        $nombre = $fileName

        # Separar por el primer guion
        if ($fileName.Contains("-")) {
            $parts = $fileName.Split("-", 1) # Error previo: debió ser 2 si se quiere limitar, pero mejor dejemos que divida
            if ($fileName -match "^(.*?)\s*-\s*(.*)$") {
                $cedula = $matches[1].Trim()
                $nombre = $matches[2].Trim()
            }
        }

        # Crear ruta relativa para la web
        $relPath = "fotos/$nivelNombre/$($foto.Name)"

        $estudiante = [PSCustomObject]@{
            cedula = $cedula
            nombre = $nombre
            nivel  = $nivelNombre
            path   = $relPath
        }
        $estudiantes += $estudiante
    }
}

# Generar el archivo JS
$json = $estudiantes | ConvertTo-Json -Depth 10
$jsContent = "const ESTUDIANTES_DB = $json;"

Set-Content -Path $outputFile -Value $jsContent -Encoding utf8

Write-Host "¡Éxito! Se han procesado $($estudiantes.Count) estudiantes." -ForegroundColor Green
Write-Host "La lista se ha guardado en 'estudiantes.js'."
pause
