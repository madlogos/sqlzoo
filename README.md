# 基于不同数据科学工具栈的SQLZOO习题求解

[English Version](README_EN.md)

## 前言

[SQLZOO](https://www.sqlzoo.net)是Andrew Cumming基于MediaWiki开发的免费在线SQL训练网站。它提供了复杂程度不等的一系列SQL问题，用户可以自行提交解答并实时获得正误反馈。该服务的数据库引擎为MariaDB，兼容MySQL语法。本repo使用SQLZOO的数据用例，通过PostgreSQL、R（主要是`dplyr`）、Python（主要是`Pandas`）、Hive、Spark等常用的数据科学工具栈实现求解。

## 用法

`git clone`本repo (<https://github.com/madlogos/sqlzoo.git>) 到本地，目录结构如下：

> 本repo在码云上有同步镜像，国内网速较差的话可换用[gitee](https://gitee.com/madlogos/sqlzoo.git)。

```txt
--|
  |--[+] Hive
  |--[+] PostgreSQL
  |--[+] Python
  |--[+] R
  |--[+] Spark
  |--[+] src
  |   `--[+] img
  |-- create_tbl_mysql.sql
  |-- create_tbl_postgres.sql
  |-- import_csv_mysql.txt
  |-- import_csv_postgresql.txt
  |-- import_sqoop_sh.txt
  |-- LICENCE
  `-- README.md
```

- 只浏览求解结果：
  - 上述5个不同工具栈的解决方案存放于同名文件夹内，均以.ipynb格式存储。启动jupyter-lab或jupyter notebook服务后即可打开这些notebook文件。
  - 每个文件夹均包含一个README.md文件，介绍该解决方案的环境配置步骤，以及目录。
- 自行复现/重写求解方法，需额外完成下列步骤：
  - 创建本地数据库后，可直接运行根目录的`create_tbl_xxx.sql`DDL脚本（详见[后文](#创建RDBMS数据表)），创建分析中涉及到的表。
  - 创建数据表后，可逐条运行根目录下`import_csv_xxx.txt`文件中的命令（详见[后文](#csv数据导入RDBMS)），将src目录中解压出来的.csv原始数据导入数据库。
  -  安装并配置好Hadoop/Hive/Sqoop环境后，将`import_sqoop_sh.txt`后缀重命名为.sh并执行，从而把前述步骤中通过`import_csv_mysql.txt`导入MySQL的数据导进Hive（详见[后文](#RDBMS数据导入Hive)）。

## 环境搭建

### 基础环境

本repo所有解决方案均建基于jupyter-lab（或jupyter notebook），建议安装[Anaconda](https://www.anaconda.com)工具集。

- 非大数据环境 (PostgreSQL、R、Python)：
  - 安装并运行[PostgreSQL](https://www.postgresql.org/download/)
  - 将SQLZOO数据导入PostgreSQL实例中
- 大数据环境 (Hive、Spark)：
  - Hive: 需Linux环境下安装Hadoop、Hive。也可租用云服务，或Docker安装CDH工具集。
  - Spark: 可安装Hadoop+Spark工具包，租用云服务，或Docker安装CDH工具集。

### 特定环境

- PostgreSQL: pip安装`ipython-sql`包
- R：需安装`IRkernel`、`IRdisplay`及其依赖包以支持R核，并在R中安装`dplyr`包
- Python：pip安装`pandas`包
- Hive：安装sqoop所需要的jdbc驱动，并安装`sasl2-bin`、`libsasl2-dev`，pip安装`pyhs2`和`pyhive[hive]`
- Spark：

## 数据准备

### 创建RDBMS数据表

首先，要在数据库中创建`sqlzoo`实例，并通过命令行进入该库：

- MySQL: `use sqlzoo;`
- PostgreSQL: `\c sqlzoo`

本repo根目录下有`create_tbl_mysql.sql`和`create_tbl_postgres.sql`两个脚本。根据自己实际使用的数据库环境选择合适的版本。
在上述命令行中调用脚本，即可一次性创建所有需要的表。也可以在数据库GUI管理界面中调用脚本。

你还可以自行编写这两个脚本。在SQLZOO网页的求解框中输入`show create table world;`即可显示创建`world`表的DDL语句：

```sql
CREATE TABLE `world` (
     `name` varchar(50) NOT NULL,
     `continent` varchar(60) DEFAULT NULL,
     `area` decimal(10,0) DEFAULT NULL,
     `population` decimal(11,0) DEFAULT NULL,
     `gdp` decimal(14,0) DEFAULT NULL,
     `capital` varchar(60) DEFAULT NULL,
     `tld` varchar(5) DEFAULT NULL,
     `flag` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`name`),
     KEY `world` (`continent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
```

用类似的方法，即可还原出所有数据表的DDL。这是MySQL语法，如改写成PostgreSQL脚本，需要相应做必要的语法调整。

### csv数据导入RDBMS

本repo根目录的src文件夹内有一个data.7z文件。用支持7z算法的工具（如Windows下的7z）解压后即得到所有.csv格式的原始数据（共78个）。

| TABLE_NAME                     | TABLE_ROWS |
|:-------------------------------|-----------:|
| Address                        |        450 |
| CAM_SMO                        |        354 |
| Caller                         |        148 |
| Customer                       |         50 |
| CustomerAW                     |        440 |
| CustomerAddress                |        450 |
| INS_CAT                        |          4 |
| INS_MOD                        |         19 |
| INS_PRS                        |         18 |
| INS_QUE                        |         19 |
| INS_RES                        |       5988 |
| INS_SPR                        |        119 |
| Issue                          |        496 |
| Level                          |          6 |
| Product                        |        295 |
| ProductCategory                |         41 |
| ProductDescription             |        762 |
| ProductModel                   |        128 |
| ProductModelProductDescription |        762 |
| SalesOrderDetail               |        500 |
| SalesOrderHeader               |         32 |
| Shift                          |          2 |
| Shift_type                     |          2 |
| Staff                          |         24 |
| actor                          |      47247 |
| band                           |          9 |
| booking                        |        347 |
| camera                         |         19 |
| casting                        |     118922 |
| composer                       |         12 |
| composition                    |         21 |
| concert                        |          8 |
| construction                   |         30 |
| covid                          |      16149 |
| dept                           |          3 |
| dress_order                    |         12 |
| dressmaker                     |          7 |
| eteam                          |         16 |
| extra                          |        207 |
| game                           |         31 |
| garment                        |          6 |
| ge                             |       9945 |
| goal                           |         76 |
| guest                          |        648 |
| hadcet                         |       7626 |
| has_composed                   |         23 |
| image                          |         49 |
| jmcust                         |          8 |
| keeper                         |          6 |
| material                       |         14 |
| movie                          |      11726 |
| musician                       |         22 |
| nobel                          |        895 |
| nss                            |      50689 |
| order_line                     |         31 |
| performance                    |         20 |
| performer                      |         29 |
| permit                         |         47 |
| place                          |          9 |
| plays_in                       |         31 |
| quantities                     |         36 |
| rate                           |          8 |
| room                           |         30 |
| room_type                      |          4 |
| route                          |       1174 |
| stops                          |        246 |
| teacher                        |          6 |
| ut_attends                     |        659 |
| ut_event                       |        201 |
| ut_modle                       |        106 |
| ut_occurs                      |       4669 |
| ut_room                        |         30 |
| ut_staff                       |         73 |
| ut_student                     |         92 |
| ut_teaches                     |        483 |
| ut_week                        |         15 |
| vehicle                        |         36 |
| world                          |        195 |

根目录下有`import_csv_mysql.txt`和`import_csv_postgresql.txt`两个文件，根据实际数据库环境选择正确的版本。这两个文件包含了导入csv数据的命令，需要在数据库命令行界面中逐条执行。如在PostgreSQL中执行

```sql
COPY teacher FROM '~/Documents/sqlzoo/src/teacher.csv' WITH DELIMITER ',' CSV NULL AS 'NULL' HEADER;
```

或在MySQL中执行

```sql
load data local infile '~/Documents/sqlzoo/src/data/teacher.csv' into table teacher 
  character set latin1 fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' ignore 1 lines
  (id,@dept,name,phone,@mobile)
  set dept=NULLif(@dept, 'NULL'), mobile=NULLif(@mobile, 'NULL');
```

即可将actor.csv导入到actor表内。但该命令中的文件路径与你的实际情况可能不符，需要自行调整。

> 需要注意，本repo中csv文件的空值被储存为NULL，能被PostgreSQL识别，但MySQL不行（默认存储为\N），所以需要额外通过`NULLif()`函数转换。可以事先在.csv文件中进行文本替换。
> 另外，在`import_csv_mysql.txt`记录的命令中，有部分日期型字段需要通过`str_to_date(@<field name>, '%a, %d %b %Y %T GMT')`来转换，否则可能无法被MySQL正常识别。

### RDBMS数据导入Hive

将数据导入Hive，有两种基本办法：

1. 利用与[上一节](#csv数据导入RDBMS)相似的方法编写.hql脚本，在Hive中创建空表，再逐条执行`load data`命令，将.csv文件导入空表。
2. 利用sqoop，将数据从[上一节](#csv数据导入RDBMS)所获得的RDBMS数据库中导入Hive。

以下是本repo采用的方法(第二种)。

#### Docker安装CDH5.13

##### 拉取镜像

镜像很大（7G），速度太慢的话，可使用镜像加速，或将镜像下载到本地后`docker import`。

```bash
docker pull  cloudera/quickstart:lastest
```

##### 启动CDH镜像

之后可通过Kitematic图形化管理。

```bash
docker run --privileged=true --hostname=quickstart.cloudera \
-p 8020:8020 -p 7180:7180 -p 21050:21050 -p 10000:10000 -p 50070:50070 \
-p 50075:50075 -p 50010:50010 -p 50020:50020 -p 8888:8888 \
-t -i -d <cdh docker image id> /usr/bin/docker-quickstart
```

##### 进入CDH镜像，启动cloudera-manager

```bash
docker exec -t -i <cdh docker image id> /bin/bash
[root@quickstart /]# /home/cloudera/cloudera-manager --force --express
```

##### 允许Docker镜像访问宿主MySQL数据库（在宿主机命令行界面操作）

- 找到MySQL数据库配置文件 (如Ubuntu中，是/etc/mysql/mysql.conf.d/mysqld.cnf）编辑，将bind 127.0.0.1这句注释掉。
- root进入数据库（本repo以MySQL为例），执行授权命令

```sql
grant all privileges on *.* to 'root'@'172.17.0.2' identified by '<pwd>' with grant option;
flush privileges;
```

> pwd为数据库密码。本案例中，宿主机的虚拟IP为172.17.0.1，镜像的虚拟IP为127.17.0.2，故只给cdh镜像开放访问权限。ip可通过`ifconfig`查看。

- 退出数据库，重启MySQL服务

```bash
/etc/init.d/mysqld restart
```

##### 创建.sh脚本，执行sqoop导入

在镜像命令行界面内创建一个.sh脚本，将`import_sqoop_sh.txt`中的内容复制进去，执行，即可将MySQL sqlzoo库中的78张表都导入CDH镜像的Hive中。该脚本循环遍历`tbls`变量并执行`sqoop import`指令:

```bash
#! /bin/bash
read -p "input username:" usernm
read -p "input password:" pwd
tbls=("table 1", "table 2", ...)
for tbl in ${tbls[*]}
do
sqoop import --connect jdbc:mysql://172.17.0.1:3306/sqlzoo \
--username ${usernm} -password ${pwd} --table ${tbl} \
--null-string '\\N' --null-non-string '\\N' --fields-terminated-by '\t' \
--delete-target-dir --num-mappers 1 --hive-import --hive-overwrite \
--hive-database sqlzoo --hive-table ${tbl}
echo "${tbl} imported"
done
```

最值得注意的地方是`--null-string`和`--null-non-string`。如未指定，则MySQL中的空值会被导为文本'null'。

## 获取原始数据

SQLZOO在[about](https://sqlzoo.net/wiki/SQLZOO:About)中提供了获取原始数据的方法。本repo则使用Selenium爬取。

在根目录下的src中有`scrapy_selemium.py`脚本，在命令行中执行`pytest scrapy_selenium.py`即可自动爬取。

### 准备

- 安装Google Chrome或Firefox（本repo中使用的是Chrome）
- 在Python中pip安装selenium和pytest
- 下载并解压正确版本的chrome-driver或firfox-driver

### 配置

在运行scrapy_selenium.py脚本前，需要做一些简单配置。

首先，在`test_copytext()`函数中，定义了`prefix`, `db`, `dblen`, `header`几个变量。

如爬取'covid'表，则prefix=''，db='covid'， dblen=19200（该表行数），header='name whn confirmed deaths recovered' (表头行，以空格分开）。而爬取University Timetables中的'event'表，则prefix='ut_', db='event', dblen=201（该表行数），header='id modle kind dow tod duration room'（表头行，以空格分开），这是为了重命名'room'等表，以避免和其他表冲突。

然后，设定正确的爬取路径，如:

```python
self.driver.get("https://sqlzoo.net/wiki/Window_LAG")
```

由于SQLZOO最多显示50条记录，因此必须循环爬取。有些表数据需要换网页爬取，结果存入`txt`变量。需要根据数据对应网址的不同，将源代码中读取文本框的代码切换注释状态。比如，路径为 <https://sqlzoo.net/wiki/AdventureWorks> 时，需解除48行的注释，而将54行注释掉。

爬取结果存入以prefex+db命名的.csv文件中。你还需要手工添加逗号分隔符，并把必要的字段列套上引号，才能正确解析。SQLZOO会不定期地更新数据，所以你也可能需要不定期地重新爬取数据。
