# Requiere ejecutarse como administrador
Add-Type -AssemblyName System.Runtime.WindowsRuntime

# Función para manejar tareas asíncronas
Function Await($WinRtTask, $ResultType) {
    $asTaskGeneric = ([System.WindowsRuntimeSystemExtensions].GetMethods() | ? { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]
    $asTask = $asTaskGeneric.MakeGenericMethod($ResultType)
    $netTask = $asTask.Invoke($null, @($WinRtTask))
    $netTask.Wait(-1) | Out-Null
    $netTask.Result
}

# Función para forzar la conexión usando shell
Function Force-BTConnect($deviceId) {
    try {
        $shell = New-Object -ComObject "Shell.Application"
        $folder = $shell.Namespace(17) # 17 es el código para dispositivos Bluetooth
        $device = $folder.Items() | Where-Object { $_.Path -match $deviceId }
        if ($device) {
            $device.InvokeVerb("Connect")
            Start-Sleep -Seconds 2
            return $true
        }
        return $false
    } catch {
        Write-Host "Error en conexión forzada: $_"
        return $false
    }
}

try {
    # Obtener el adaptador Bluetooth
    $bluetoothAPI = [Windows.Devices.Bluetooth.BluetoothAdapter, Windows.System.Runtime, ContentType = WindowsRuntime]
    $bluetooth = Await ($bluetoothAPI::GetDefaultAsync()) ([Windows.Devices.Bluetooth.BluetoothAdapter])

    if (-not $bluetooth) {
        Write-Host "No se encontró adaptador Bluetooth"
        exit
    }

    # Obtener dispositivos emparejados
    $deviceSelector = [Windows.Devices.Bluetooth.BluetoothDevice]::GetDeviceSelector()
    $deviceInfo = Await ([Windows.Devices.Enumeration.DeviceInformation]::FindAllAsync($deviceSelector)) ([Windows.Devices.Enumeration.DeviceInformationCollection])

    # Mostrar dispositivos disponibles
    Write-Host "Dispositivos Bluetooth emparejados:"
    $devices = @{}
    $i = 1
    foreach ($device in $deviceInfo) {
        Write-Host "$i. $($device.Name)"
        $devices[$i] = $device
        $i++
    }

    # Seleccionar dispositivo
    $selection = [int](Read-Host "Ingrese el número del dispositivo que desea conectar")

    if ($devices.ContainsKey($selection)) {
        $selectedDevice = $devices[$selection]
        Write-Host "Intentando conectar a $($selectedDevice.Name)..."
        
        # Primer intento usando el método estándar
        $bluetoothDevice = Await ([Windows.Devices.Bluetooth.BluetoothDevice]::FromIdAsync($selectedDevice.Id)) ([Windows.Devices.Bluetooth.BluetoothDevice])
        
        if ($bluetoothDevice.ConnectionStatus -ne "Connected") {
            Write-Host "Primer intento fallido, intentando método alternativo..."
            
            # Segundo intento usando el método forzado
            $connected = Force-BTConnect($selectedDevice.Id)
            
            if ($connected) {
                Write-Host "Dispositivo conectado exitosamente mediante método alternativo"
            } else {
                Write-Host "No se pudo conectar al dispositivo. Por favor:"
                Write-Host "1. Asegúrese que el dispositivo está encendido y en modo emparejamiento"
                Write-Host "2. Intente desactivar y reactivar el Bluetooth de Windows"
                Write-Host "3. Reinicie el dispositivo Bluetooth"
            }
        } else {
            Write-Host "Dispositivo conectado exitosamente"
        }
    } else {
        Write-Host "Selección inválida. Por favor, seleccione un número entre 1 y $($devices.Count)"
    }
} catch {
    Write-Host "Error durante la ejecución: $_"
    Write-Host "Detalles técnicos del error:"
    $_.Exception | Format-List * -Force
}