# SedovSG_infra
SedovSG Infra repository

bastion_IP = 51.250.19.223
someinternalhost_IP = 10.129.0.26

# SSH подключение к внутренним серверам за бастионом

**Есть 2 варианта использования данной опции**.

## Использовать флаг `-J` командной строки:

```$: ssh -A -J appuser@infra.yc appuser@10.129.0.26```

## Использовать опцию `ProxyJump` в конфигурации клиента:

*~/.ssh/config*

```ini
Host infra.yc
HostName 51.250.19.223
User appuser
IdentityFile ~/.ssh/id_rsa.yc

Host infra-internal.yc
HostName 10.129.0.26
User appuser
ProxyJump infra.yc
```

# Создание ВМ яндекс облака через CLI:

testapp_IP = 51.250.9.8
testapp_port = 9292

```bash
$: yc compute instance create \
--name reddit-app-test \
--hostname reddit-app-test \
--memory=4 \
--zone=ru-central1-a \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata-from-file user-data=cloud-config.yaml \
--metadata serial-port-enable=1
```

# Использование сборщика образов Packer:

Возможно собрать минимальный образ ОС и полный (со всеми зависимостями и приложением)

## Для сборки минимального образа для Яндекс Облака выполнить:

```bash
$: cd packer && cp -n variables.json.examples variables.json && packer build -var-file="variables.json" ./ubuntu16.json
```

## Для сборки полного образа для Яндекс Облака выполнить:

```bash
$: cd packer && cp -n variables.json.examples variables.json && packer build -var-file="variables.json"./immutable.json
```

# Использование Terraform для управления инфраструктурой:

Используемая версия Terraform **0.12.3**

## Для зупуска выполнить:

```bash
$: cd terraform && cp -n terraform.tfvars.example terraform.tfvars && terraform apply
```
