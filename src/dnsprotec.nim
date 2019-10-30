import os, osproc, strutils, rdstdin, times

setControlCHook((proc {.noconv.} = quit" CTRL+C Pressed,shutting down,Bye! "))
template prepro(s: string): string =
  gorge("curl -ks " & s & r" | sed -e 's/\r//' -e 's/127.0.0.1/0.0.0.0/' -e '/localhost/d' -e 's/ \+/\t/' -e 's/#.*$//' -e 's/[ \t]*$//'")

const
  cmdChecksum = "sha512sum --tag "
  cmdTar = "tar cafv "
  adServers = prepro("https://hosts-file.net/ad_servers.txt")
  emd = prepro("https://hosts-file.net/emd.txt")
  exp = prepro("https://hosts-file.net/exp.txt")
  fsa = prepro("https://hosts-file.net/fsa.txt")
  grm = prepro("https://hosts-file.net/grm.txt")
  hfs = prepro("https://hosts-file.net/hfs.txt")
  hjk = prepro("https://hosts-file.net/hjk.txt")
  mmt = prepro("https://hosts-file.net/mmt.txt")
  pha = prepro("https://hosts-file.net/pha.txt")
  psh = prepro("https://hosts-file.net/psh.txt")
  pup = prepro("https://hosts-file.net/pup.txt")
  wrz = prepro("https://hosts-file.net/wrz.txt")

proc backup(): tuple[output: TaintedString, exitCode: int] =
  let filesha = getCurrentDir() / "hosts_" & replace($now(), ":", "_") & ".sha512"
  let filetar = getCurrentDir() / "hosts_" & replace($now(), ":", "_") & ".tar.gz"
  if findExe("sha512sum").len > 0:
    result = execCmdEx(cmdChecksum & "/etc/hosts > " & filesha)
    if result.exitCode == 0 and findExe("tar").len > 0:
      result = execCmdEx(cmdTar & filetar & " /etc/hosts " & filesha)
      if result.exitCode == 0: discard tryRemoveFile(filesha) else: echo result.output
      echo "Backup (tar.gz): " & filetar

when isMainModule:
  var newHosts = static(staticRead"/etc/hosts") # "# " & $now() & " by " & getEnv"USER" & "\n127.0.0.1 localhost\n::1 localhost"
  echo "DNS Protec!\n(ENTER = No, CTRL+C = Cancel)"
  if readLineFromStdin"Backup /etc/hosts ? (y/n): ".normalize == "y":
    discard backup()
  if readLineFromStdin("Block Ads, Tracking ? (y/N): ").normalize == "y":
    newHosts.add adServers
  if readLineFromStdin("Block Virus, Malwares, Ransomwares ? (y/N): ").normalize == "y":
    newHosts.add emd
  if readLineFromStdin("Block Exploit Malwares, Spyware ? (y/N): ").normalize == "y":
    newHosts.add exp
  if readLineFromStdin("Block Scam, Frauds ? (y/N): ").normalize == "y":
    newHosts.add fsa
  if readLineFromStdin("Block Spamm, Spamm Flooders, Spam Bots ? (y/N): ").normalize == "y":
    newHosts.add grm & hfs
  if readLineFromStdin("Block Hijacking, Fakes ? (y/N): ").normalize == "y":
    newHosts.add hjk
  if readLineFromStdin("Block Misleading Ads ? (y/N): ").normalize == "y":
    newHosts.add mmt
  if readLineFromStdin("Block Viagra Spam, Fake Pharmacy, Penis Pill Scam ? (y/N): ").normalize == "y":
    newHosts.add pha
  if readLineFromStdin("Block Phishing ? (y/N): ").normalize == "y":
    newHosts.add psh
  if readLineFromStdin("Block Potentially Unwanted Programs ? (y/N): ").normalize == "y":
    newHosts.add pup
  if readLineFromStdin("Block Warez, Cracks ? (y/N): ").normalize == "y":
    newHosts.add wrz
  let newfile = getCurrentDir() / "hosts"
  writeFile(newfile, newHosts)
  echo $newHosts.countLines & " hosts --> " & newfile
  when defined(overwrite): moveFile(newfile, "/etc/hosts")
  else: echo "\nsudo mv --force " & newfile & " /etc/hosts\n"
  if readLineFromStdin("Suicide, Delete Itself ? (y/N): ").normalize == "y":
    echo tryRemoveFile(getCurrentDir() / "dnsprotec")
