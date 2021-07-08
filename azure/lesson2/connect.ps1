$connectTestResult = Test-NetConnection -ComputerName brazhaevcourse.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"brazhaevcourse.file.core.windows.net`" /user:`"localhost\brazhaevcourse`" /pass:`"9PB1L/pzHnswZSbMLxsxliRVh7wz8ySInoCVP6N9A4iDu7LhVK5a3Jpj+FGDcglVgC5x0T8BrimEsoB0H1VC+g==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\brazhaevcourse.file.core.windows.net\lesson2share" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}