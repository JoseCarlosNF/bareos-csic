# Novos serviços! Novos Backups

## TL;DR

Guia para auxiliar na criação de novos serviços de backup.

## Items necessários

### Director

1. **Job**: Define as especificações do serviço de backup.

`/etc/bareos/bareos-dir.d/job/arquivo.conf`

```conf
Job {
  Name = NOME_DO_JOB
  JobDefs = NOME_DO_JOB-defs
  Client = NOME_DO_CLIENTE-fd
}

JobDefs {
  Name = NOME_DO_JOB-defs
  Type = Backup
  Level = Full
  Client = NOME_DO_CLIENTE-fd
  FileSet = NOME_DO_FILESET
  Schedule = NOME_DO_SCHEDULE
  Pool = NOME_DO_POOL
  Storage = NOME_DO_STORAGE
  Messages = Standard
  Priority = 10
}

```

É a principal estrutura na criação de um novo serviço/job de backup. **As especificações aqui definidas serão abordas com mais detalhes a seguir**.

2. **Fileset**: Define o que será salvo.

`/etc/bareos/bareos-dir.d/fileset/arquivo.conf`

```conf
FileSet {
  Name = NOME_DO_FILESET
  Description = "DESCRIÇÃO DO FILESET"
  Include {
    Options {
      Signature = SHA1
      Compression = GZIP6
    }
    # ------ Locais para backup ------
    File = /home/vagrant/teste1
    File = /home/vagrant/teste2
    File = /home/vagrant/teste3
  }
}

```

Usar nomes descritivos e descrever o fileset, na seção Description, é extremamente importante. Qualquer documentação que pudermos ter acesso é de bom grado, principalmente para o caso de uma manutenção, e se ela for no próprio documento que necessita de manutenção melhor ainda.

3. **Schedule**: Agendamento do serviço/job de backup.

`/etc/bareos/bareos-dir.d/schedule/arquivo.conf`

```conf
Schedule {
  Name = NOME_DO_SCHEDULE
  Run = Level=Full Pool=Mensal 1st sat at 03:05
  Run = Level=Full Pool=Semanal 2nd-5th sat at 03:05
  Run = Level=Differential Pool=Diario tue-fri at 03:05
}

```

Através dos agendamentos/schedules podemos definir a política de backup - quantos backups serão feitos e quando serão feitos e seus níveis.

O serviço configurado com o agendamento/schedule acima, por exemplo, será executado:

- Em nível full no primeiro sábado de cada mês, afim de ter um backup por mês, provavelmente com um prazo de rotação anual.
- Uma vez por semana ainda aos sábados e em nível full, backup semanal, provavelmente com um prazo de rotação mensal.
- Diariamente, de segunda a sexta, em nível diferencial, backup diário, provavelmente com um prazo de rotação semanal.

Dessa maneira temos a seguinte política de backup.

| **Dia**   | Dom  | Seg  | Ter  | Qua  | Qui  | Sex  | Sáb  |
| --------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| **Nível** | ---- | diff | diff | diff | diff | diff | full |

Essa política é uma das mais genéricas, sendo uma boa opção para a maioria dos casos.

**Obs**: Os pools associados devem ser válidos. Vamos falar um pouco sobre eles na seção a seguir.

4. **Pool**: Agrupamento dos backups.

`/etc/bareos/bareos-dir.d/pool/arquivo.conf`

```conf
Pool {
  Name = NOME_DO_POOL
  Pool Type = Backup
  Storage = NOME_DO_STORAGE
  Recycle Oldest Volume = yes
  Volume Retention = 6 days
  Recycle = yes
  AutoPrune = yes
  LabelFormat = NOME_DO_POOL-
  Maximum Volume Bytes = 5G
}

```

Basicamente, especifica como o volume - arquivo do backup - deve se comportar, por exemplo, em relação ao tempo de retenção do backup e tamanho máximo dos volumes por ele armazenados. É importante definir essas políticas para que não ocorra a paralisação dos backups por falta de espaço de armazenamento.

Através dele também especificamos a etiqueta do backup, no campo `LabelFormat`. No acima exemplo acima a etiqueta seria, `NOME_DO_POOL-xxx`. Essa etiqueta é essencial para o sucesso da restauração, uma vez que ela é a principal associação do backup, no cátalogo. Você pode até mover o backup de lugar, mas nunca deverá mudar seu nome, pois ele é a etiqueta associada no cátalogo.


5. **Storage**: Indica, para o director, o servidor de armazenamento e o tipo de mídia que utilizará.

`/etc/bareos/bareos-dir.d/storage/arquivo.conf`

```conf
Storage {
  Name = NOME_DO_STORAGE
  Address = 192.168.0.2
  Password = "senha_do_storage_daemon"
  Device = NOME_DO_DEVICE
  Media Type = File
}

```

O storage é uma configuração indicativa, que mostrar ao director daemon qual storage daemon usar, o tipo de mídia e o device.
A seguir, algumas recomendações sobre a configuração dos storages:
- No campo de `Address` não utilizar `localhost` ou `127.0.0.1`. Apesar de na maioria das vezes tratar-se do mesmo host, essa informação é repassada para os clientes, que tentarão se conectar ao storage local, ocasionando um erro no backup.
- A senha, é a mesma do arquivo `/etc/bareos/bareos-sd.d/director/bareos-dir.conf`

### Storage Daemon

6. **Device**: São os dispositivos e/ou locais onde serão armazenados os backups.

`/etc/bareos/bareos-sd.d/device/arquivo.conf`

```conf
Device {
  Name = NOME_DO_DEVICE
  Media Type = File
  Archive Device = /diretorio_de_armazenamento
  LabelMedia = yes;
  Random Access = yes;
  AutomaticMount = yes;
  RemovableMedia = no;
  AlwaysOpen = no;
}

```

Nele você apontará onde os backups deverão/estão guardados, e o tipo de mídia utilizada.
