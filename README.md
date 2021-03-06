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

## Для запуска в среде развёртывания **stage** выполнить:

```bash
$: cd terraform/stage && cp -n terraform.tfvars.example terraform.tfvars && terraform apply
```

## Для запуска в среде развёртывания **prod** выполнить:

```bash
$: cd terraform/prod && cp -n terraform.tfvars.example terraform.tfvars && terraform apply
```

# Использование Ansible для удалённого управления конфигурацией:

Используемая версия Ansible **2.12.1**

```bash
$: cd ansible && ansible all -m ping -i inventory.yml
$: ansible app -m shell -a 'ruby -v; bundler -v' && ansible db -m service -a name=mongod
$: ansible app -m git -a 'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit'
```

# Использование пьес Ansible для удалённого управления конфигурацией:

Для выполнения отдельных задач можно использовать теги и шаблоны ограничения хостов:

```bash
$: cd ansible && \
ansible-playbook reddit_app_one_play.yml --limit db --tags db-tag && \
ansible-playbook reddit_app_one_play.yml --limit app --tags app-tag && \
ansible-playbook reddit_app_one_play.yml --limit app --tags deploy-tag
```

Либо только теги:

```bash
$: cd ansible && \
ansible-playbook reddit_app_multiple_plays.yml --tags db-tag && \
ansible-playbook reddit_app_multiple_plays.yml --tags app-tag && \
ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag
```

Кроме того пьесы можно разделять по контекстам выполнения задач:

```bash
$: cd ansible && ansible-playbook site.yaml
```

# Использование ролей в Ansible, для управления режимами сред окружения:

Для промежуточной среды окружения:

```bash
$: cd ansible && ansible-playbook playbooks/site.yml
```

Для среды производства:

```bash
$: cd ansible && ansible-playbook -i environments/prod/inventory playbooks/site.yml
```

# Использование Ansible Vault для шифрования ключей:

```bash
$: cd ansible && \
ansible-vault encrypt environments/prod/credentials.yaml
ansible-vault encrypt environments/stage/credentials.yml
```
