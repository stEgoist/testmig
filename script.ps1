clear
Import-Module ActiveDirectory
Write-Host "Начало миграции пользователей и групп из домена target.local в домен void.int"
try {
    $ou = "OU=!mig,DC=target,DC=local"
    $u = "C:\!mig\u.txt"  # Путь и имя файла для сохранения списка пользователей
    $g = "C:\!mig\g.txt"  # Путь и имя файла для сохранения списка групп

    try {
        # Получение списка учетных записей пользователей в OU
        $users = Get-ADUser -SearchBase $ou -Filter * -Properties SamAccountName

        # Сохранение списка учетных записей пользователей в файл
        $users | Select-Object -ExpandProperty SamAccountName | Out-File -FilePath $u
    }
    catch {
        Write-Host "Ошибка при получении списка учетных записей пользователей: $_"
        throw  # Пробросить исключение дальше для прекращения выполнения кода
    }

    try {
        # Получение списка групп в OU
        $groups = Get-ADGroup -SearchBase $ou -Filter * -Properties Name

        # Сохранение списка групп в файл
        $groups | Select-Object -ExpandProperty Name | Out-File -FilePath $g
    }
    catch {
        Write-Host "Ошибка при получении списка групп: $_"
        throw  # Пробросить исключение дальше для прекращения выполнения кода
    }

    try {
        # Запуск файла пакетного скрипта ADMT
        
        $startmig = "c:\!mig\migrate.cmd"
        Invoke-Expression $startmig
    }
    catch {
        Write-Host "Ошибка при выполнении пакетного скрипта ADMT: $_"
        throw  # Пробросить исключение дальше для прекращения выполнения кода
    }
}
catch {
    Write-Host "Ошибка при выполнении миграции: $_"
}
