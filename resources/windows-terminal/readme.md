
Opening a tab or pane in ther same directory in Windows Terminal

- Command prompt (cmd.exe)
# set PROMPT=$e]9;9;$P$e\%PROMPT%
# setx PROMPT "%PROMPT%"

- PowerShell
``` batch
function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation;

  $out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
  return $out
}
```
