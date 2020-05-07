# 利用不同的数据科学工具栈求解SQLZOO问题

## 前言

[SQLZOO](https://www.sqlzoo.net)是Andrew Cumming基于MediaWiki开发的免费在线SQL训练网站。它提供了复杂程度不等的一系列SQL问题，用户可以自行提交解答并实时获得正误反馈。该服务的数据库引擎为MariaDB，兼容MySQL语法。本repo使用SQLZOO的数据用例，通过PostgreSQL、R（主要是`dplyr`）、Python（主要是`Pandas`）、Hive、Spark等常用的数据科学工具栈实现求解。

## 用法

`git clone`本repo (<https://github.com/madlogos/sqlzoo.git>) 到本地，目录结构如下：

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
  |-- LICENCE
  `-- README.md
```

- 只浏览求解结果：
  - 上述5个不同工具栈的解决方案存放于同名文件夹内，均以.ipynb格式存储。启动jupyter-lab或jupyter notebook服务后即可打开这些notebook文件。
  - 每个文件夹均包含一个README.md文件和置顶的'00  how to start.ipynb'文件，介绍该解决方案的环境配置。
- 自行复现/重写求解方法，需额外完成下列步骤：
  - 创建本地数据库后，可直接运行根目录的`create_tbl_xxx.sql`DDL脚本（详见[后文](#/创建数据表)），创建分析中涉及到的表。
  - 创建数据表后，可逐条运行根目录下`import_csv_xxx.txt`文件中的命令（详见[后文](#/导入csv数据)），将src目录中解压出来的.csv原始数据导入数据库。

> 本repo在Gitee上有同步镜像，国内网速较差的话可换用gitee

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
- Hive：
- Spark：

## 数据准备

### 创建数据表

首先，要在数据库中创建`sqlzoo`实例，并通过命令行进入该库：

- MySQL: `use sqlzoo;`
- PostgreSQL: `\c sqlzoo`

本repo根目录下有`create_tbl_mysql.sql`和`create_tbl_postgres.sql`两个脚本。根据自己实际使用的数据库环境选择合适的版本。
在上述命令行中调用脚本，即可一次性创建所有需要的表。也可以在数据库GUI管理界面中调用脚本。

你可以自行编写这两个脚本。在SQLZOO网页的求解框中输入`show create table world;`即可显示创建`world`表的DDL语句：

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

用类似的方法，即可还原出所有数据表的DDL。这是MySQL语法，如改写成PostgreSQL脚本，需要做必要的调整。

### 导入csv数据

本repo根目录的src文件夹内有一个data.7z文件。用支持7z算法的工具（如Windows下的7z）解压后即得到所有.csv格式的原始数据。

根目录下有`import_csv_mysql.txt`和`import_csv_postgresql.txt`两个文件，根据实际数据库环境选择正确的版本。这两个文件包含了导入csv数据的命令，需要在数据库命令行界面中逐条执行。如在PostgreSQL中执行

```sql
COPY actor FROM './src/actor.csv' WITH DELIMITER ',' CSV NULL AS 'NULL' HEADER;
```

或在MySQL中执行

```sql
load data local infile './src/actor.csv' into table actor character set utf8 fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' ignore 1 lines;
```

即可将actor.csv导入到actor表内。但该命令中的文件路径与你的实际情况可能不符，需要自行调整。

### 获取原始数据

SQLZOO在[about](https://sqlzoo.net/wiki/SQLZOO:About)中提供了获取原始数据的方法。本repo则使用Selenium爬取。

在根目录下的src中有`scrapy_selemium.py`脚本，在命令行中执行`pytest scrapy_selenium.py`即可自动爬取。

#### 准备

- 安装Google Chrome或Firefox（本repo中使用的是Chrome）
- 在Python中pip安装selenium和pytest
- 下载并解压正确版本的chrome-driver或firfox-driver

#### 配置

在运行scrapy_selenium.py脚本前，需要做一些简单配置。

首先，在`test_copytext()`函数中，定义了`prefix`, `db`, `dblen`, `header`几个变量。

如爬取'covid'表，则prefix=''，db='covid'， dblen=19200（该表行数），header则是其表头（以空格分开）。而爬取University Timetables中的'event'表，则prefix='ut_', db='event', dblen=201（该表行数），header则为其表头（以空格分开），这是为了重命名'room'等表，以避免和其他表冲突。

然后，设定正确的爬取路径，如:

```python
self.driver.get("https://sqlzoo.net/wiki/Window_LAG")
```

由于SQLZOO最多显示50条记录，因此必须循环爬取。有些表数据需要换网页爬取，结果存入`txt`变量。需要根据数据对应网址的不同，将源代码中读取文本框的代码切换注释状态。比如，路径为 <https://sqlzoo.net/wiki/AdventureWorks> 时，需解除48行的注释，而将54行注释掉。

爬取结果存入以prefex+db命名的.csv文件中。你还需要手工添加逗号分隔符，并把必要的字段列套上引号，才能正确解析。SQLZOO会不定期地更新数据，所以你也可能需要不定期地重新爬取数据。
