# SedovSG_infra
SedovSG Infra repository

# SSH подключение к внутренним серверам за бастионом

**Есть 2 варианта использования данной опции**.

## Использовать флаг `-J` командной строки:

```$: ssh -A -J appuser@infra.yc appuser@10.129.0.26```

## Использовать опцию `ProxyJump` в конфигурации клиента:

*~/.ssh/config*

```ini
Host infra.yc
    HostName 51.250.21.21
    User appuser
    IdentityFile ~/.ssh/id_rsa.yc

Host infra-internal.yc
    HostName 10.129.0.23
    User appuser
    ProxyJump infra.yc
```
