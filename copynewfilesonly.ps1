#$readfolder = Read-host -Prompt "Input folder to read from"
#$writefolder = Read-host -Prompt "Input folder to write to"

$readfolder = "F:\test read"
$writefolder = "F:\test write"

$readfiles = Get-ChildItem $readfolder -Recurse
$writefiles = Get-ChildItem $writefolder -Recurse

#copy's files that do not exist yet
copy-item $readfolder\* $writefolder -Recurse -Exclude $writefiles

#compares files and copies newer files only
Foreach ($readfile in $readfiles){
	Foreach ($writefile in $writefiles){
        if("$($readfile.DirectoryName.Replace($readfolder,''))\$readfile" -eq "$($Writefile.DirectoryName.Replace($writefolder,''))\$writefile"){
            Write-host "duplicate file found $($readfile.DirectoryName)\$readfile and $($Writefile.DirectoryName)\$writefile"
            if($readfile.LastWriteTime -gt $writefile.LastWriteTime){
                Write-Host "File is newer"
                copy-item "$($readfile.DirectoryName)\$readfile" "$($Writefile.DirectoryName)\$writefile" -Verbose -force
            }else{write-host "file is not newer"}
        }
	}
}
