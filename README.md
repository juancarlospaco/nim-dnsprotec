# DNS Protec

- DNS `/etc/hosts` file manager, Block 1 Million malicious domains on 1 command.
- 1 File, 0 Dependency, no config, no setup, works Offline, for any Linux, 60 lines of code.
- Does **NOT overwrite `/etc/hosts` by default**, Backup by default, can delete itself (for Docker), runs on Alpine.

![](https://raw.githubusercontent.com/juancarlospaco/nim-dnsprotec/master/temp.png "Does NOT run 'sudo mv', just prints the command for you")


# Use

```
$ dnsprotec
```

- If you reply `n` to everything it gives you your current `/etc/hosts` file.


# Download

- https://github.com/juancarlospaco/nim-dnsprotec/releases


# Install

- `nimble install dnsprotec`


# Compile

```
$ nim c dnsprotec.nim
```

- Force overwriting of `/etc/hosts` with `-d:overwrite`.
- Your current `/etc/hosts` will be statically read as a base template for new host files.
- Compilation requires Internet, but after that it works 100% Offline.
- You can add your custom local or remote DNS Blacklists on `hosts` file format, separated by comma:

```
-d:customUrls="http://foo.io/hosts,http://bar.io/blacklist,http://127.0.0.1/blockedDNS"
```


# Spotify

As a side-effect, Spotify desktop app behaves like Premium, it will not show Ads, but plays music.

If it stops playing music disable the DNS protec, use it for a while, and you can enable it back later,
it seems from time to time it checks with Spotify servers, but yeah Spotify Premium for free ;)


# Why

I know there are other scripts, but those need a virtual machine or interpreter,
and need to be online to work properly, I needed one that can work offline and standalone.
