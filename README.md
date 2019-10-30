# DNS Protec

- DNS `/etc/hosts` file manager, Block 1 Million malicious domains on 1 command.
- 1 File, 0 Dependency, no config, no setup, crossplatform, works Offline, 60 lines of code.
- Does **NOT overwrite `/etc/hosts` by default**, Backup by default, can delete itself (for Docker).

![](https://raw.githubusercontent.com/juancarlospaco/nim-dnsprotec/master/temp.png)


# Use

```
$ dnsprotec
```


# Compile

```
$ nim c dnsprotec.nim
```

- Force overwriting of `/etc/hosts` with `-d:overwrite`.
- Your current `/etc/hosts` will be statically read as a base template for new host files.
- Compilation requires Internet, but after that it works 100% Offline.
