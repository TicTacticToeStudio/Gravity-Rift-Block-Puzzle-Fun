# --- Общие настройки и определение путей ---
# $PSScriptRoot - автоматически указывает на директорию, где находится этот скрипт (корневая папка вашего проекта)
$projectRoot = $PSScriptRoot
# Получаем путь к рабочему столу более надежным способом
$desktop = [Environment]::GetFolderPath("Desktop")

# Получаем имя проекта из названия корневой папки скрипта
$projectName = (Get-Item $projectRoot).BaseName

# Определяем целевые директории для резервных копий
$codeFilesDestination = Join-Path $desktop "CodeFiles"
$libFilesDestination = Join-Path $desktop "libFiles"

# --- Убедимся, что целевые директории существуют. Если нет, создадим их. ---
Write-Host "Проверка и создание целевых директорий..."
If (-not (Test-Path $codeFilesDestination)) {
    New-Item -ItemType Directory -Force $codeFilesDestination
    Write-Host "Создана директория: $codeFilesDestination"
}
If (-not (Test-Path $libFilesDestination)) {
    New-Item -ItemType Directory -Force $libFilesDestination
    Write-Host "Создана директория: $libFilesDestination"
}

Write-Host "--- Запуск генерации комбинированного файла кода ---"
# --- Задача 1: Создание комбинированной копии всех файлов кода ([имя_проекта]_[номер].txt) ---

# Временный файл для сборки всего кода перед его нумерацией
$outputPathTemp = Join-Path $codeFilesDestination "temp_combined_code.txt"

# Очищаем или создаем временный файл
"" | Out-File -FilePath $outputPathTemp -Encoding UTF8

# Добавляем содержимое файлов .dart с разделителями и именами классов
Get-ChildItem -Path "$projectRoot\lib" -Recurse -Include *.dart -ErrorAction SilentlyContinue | ForEach-Object {
    "=================================================" | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
    $_.Name | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
    "=================================================" | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
    Get-Content $_.FullName | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
}

# Добавляем содержимое файлов .kt с разделителями и именами классов
$kotlinPath = "$projectRoot\android\app\src\main\kotlin"
if (Test-Path $kotlinPath) {
    Get-ChildItem -Path $kotlinPath -Recurse -Include *.kt -ErrorAction SilentlyContinue | ForEach-Object {
        "=================================================" | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
        $_.Name | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
        "=================================================" | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
        Get-Content $_.FullName | Out-File -FilePath $outputPathTemp -Append -Encoding UTF8
    }
} else {
    Write-Host "Директория Kotlin не найдена: $kotlinPath. Файлы .kt не будут включены в комбинированный файл."
}

# Определяем следующий номер для комбинированного файла кода ([имя_проекта]_N.txt)
# Ищем файлы, начинающиеся с имени проекта и "_", затем число и ".txt"
$existingNumberedCodeFiles = Get-ChildItem -Path $codeFilesDestination -Filter "$projectName_*.txt" | Where-Object {
    $_.BaseName -match "^$([regex]::Escape($projectName))_(\d+)$"
}

$nextCodeNumber = 1
if ($existingNumberedCodeFiles.Count -gt 0) {
    # Извлекаем числа из найденных имен файлов и находим максимальное
    $existingNumbers = $existingNumberedCodeFiles | ForEach-Object {
        if ($_.BaseName -match "^$([regex]::Escape($projectName))_(\d+)$") {
            [int]$matches[1]
        } else {
            0 # Возвращаем 0, если имя не соответствует ожидаемому шаблону, чтобы не сломать Measure-Object
        }
    }
    $maxExistingCodeNumber = ($existingNumbers | Measure-Object -Maximum).Maximum
    $nextCodeNumber = $maxExistingCodeNumber + 1
}

# Формируем новое имя файла, включая имя проекта
$newNumberedCodeFileName = "{0}_{1}.txt" -f $projectName, $nextCodeNumber
$newNumberedCodeFilePath = Join-Path -Path $codeFilesDestination -ChildPath $newNumberedCodeFileName

# Копируем содержимое временного файла в новый пронумерованный файл
Copy-Item -Path $outputPathTemp -Destination $newNumberedCodeFilePath -Force

# !!! НОВОЕ: Удаляем временный файл после копирования !!!
Remove-Item -Path $outputPathTemp -Force

Write-Host "Создан комбинированный файл кода: $newNumberedCodeFilePath"
Write-Host " " # Пустая строка для разделения вывода

Write-Host "--- Запуск генерации файла структуры проекта ---"
# --- НОВОЕ: Задача 3: Генерация структуры проекта ([имя_проекта]_structure_N.txt) ---

# Формируем имя файла структуры, используя имя проекта и тот же номер, что и у комбинированного файла
$newStructureFileName = "{0}_structure_{1}.txt" -f $projectName, $nextCodeNumber
$newStructureFilePath = Join-Path -Path $codeFilesDestination -ChildPath $newStructureFileName

# Генерируем структуру папки 'lib' и сохраняем ее в файл
tree /f /a "$projectRoot\lib" > $newStructureFilePath

Write-Host "Создан файл структуры проекта: $newStructureFilePath"
Write-Host " " # Пустая строка для разделения вывода

Write-Host "--- Запуск генерации копии директории lib ---"
# --- Задача 2: Создание копии lib директории ([имя_проекта]_lib_N) ---

$sourceLibDir = "$projectRoot\lib"

# Определяем следующий номер для копии директории lib ([имя_проекта]_lib_N)
# Ищем папки, начинающиеся с имени проекта, "_lib_" и числа
$existingLibFolders = Get-ChildItem -Path $libFilesDestination -Directory -Filter "$projectName_lib_*"
$countLib = 1
if ($existingLibFolders.Count -gt 0) {
    # Извлекаем числа из найденных имен папок и находим максимальное
    $existingLibNumbers = $existingLibFolders | ForEach-Object {
        if ($_.Name -match "^$([regex]::Escape($projectName))_lib_(\d+)$") {
            [int]$matches[1]
        } else {
            0 # Возвращаем 0, если имя не соответствует ожидаемому шаблону
        }
    }
    $maxExistingLibNumber = ($existingLibNumbers | Measure-Object -Maximum).Maximum
    $countLib = $maxExistingLibNumber + 1
}

# Формируем новое имя папки, включая имя проекта и "lib"
$newLibFolder = "{0}_lib_{1}" -f $projectName, $countLib
$newLibFolderFullPath = Join-Path -Path $libFilesDestination -ChildPath $newLibFolder

# Копируем директорию lib
Copy-Item -Path $sourceLibDir -Destination $newLibFolderFullPath -Recurse -Force

Write-Host "Папка 'lib' скопирована в: $newLibFolderFullPath"
Write-Host " " # Пустая строка для разделения вывода

Write-Host "--- Все операции завершены! ---"