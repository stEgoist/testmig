clear
Import-Module ActiveDirectory
Write-Host "������ �������� ������������� � ����� �� ������ target.local � ����� void.int"
try {
    $ou = "OU=!mig,DC=target,DC=local"
    $u = "C:\!mig\u.txt"  # ���� � ��� ����� ��� ���������� ������ �������������
    $g = "C:\!mig\g.txt"  # ���� � ��� ����� ��� ���������� ������ �����

    try {
        # ��������� ������ ������� ������� ������������� � OU
        $users = Get-ADUser -SearchBase $ou -Filter * -Properties SamAccountName

        # ���������� ������ ������� ������� ������������� � ����
        $users | Select-Object -ExpandProperty SamAccountName | Out-File -FilePath $u
    }
    catch {
        Write-Host "������ ��� ��������� ������ ������� ������� �������������: $_"
        throw  # ���������� ���������� ������ ��� ����������� ���������� ����
    }

    try {
        # ��������� ������ ����� � OU
        $groups = Get-ADGroup -SearchBase $ou -Filter * -Properties Name

        # ���������� ������ ����� � ����
        $groups | Select-Object -ExpandProperty Name | Out-File -FilePath $g
    }
    catch {
        Write-Host "������ ��� ��������� ������ �����: $_"
        throw  # ���������� ���������� ������ ��� ����������� ���������� ����
    }

    try {
        # ������ ����� ��������� ������� ADMT
        
        $startmig = "c:\!mig\migrate.cmd"
        Invoke-Expression $startmig
    }
    catch {
        Write-Host "������ ��� ���������� ��������� ������� ADMT: $_"
        throw  # ���������� ���������� ������ ��� ����������� ���������� ����
    }
}
catch {
    Write-Host "������ ��� ���������� ��������: $_"
}
