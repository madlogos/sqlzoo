# Solutions for SQLZOO with Multiple Data Science Toolkit Stacks

[中文版](README.md)

## Foreword

[SQLZOO](https://www.sqlzoo.net) is a free online SQL bootcamp playground developed with MediaWiki by Andrew Cumming. It provides a series of SQL problems varying from easy to difficult for users to submit solutions and get instant feedback interactively. This service use MariaDB as database engine which is also compatible with MySQL syntax. My repo uses the data set use cases from SQLZOO, with Jupyter Notebook solutions using various popular data science tool stacks such as PostgreSQL, R (majorly `dplyr`), Python (majorly `Pandas`), Hive, Spark (`PySpark` and `Scala`), etc.

## Usage

`git clone` this repo (<https://github.com/madlogos/sqlzoo.git>) to local disk. The directory is as below:

> This repo has a synchronous mirror on Gitee. If the connection to GitHub is interupted in China, you may try [gitee](https://gitee.com/madlogos/sqlzoo.git).

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

- For browsing my solutions only：
  - All the solutions with different tool stacks were stored in their according folders, in .ipynb format. You can open them by initiating `jupyter-lab` or `jupyter notebook`.
  - Each solution folder contains a README.md to introduce how to configure the operation environment and the table of contents.
- For replicate / recode the solutions, you may need to do the following additional jobs:
  - Run the commands in `create_tbl_xxx.sql` DDL scripts after creating the database instance (refer to [this chapter](#Create-RDBMS-Tables)) to create tables required in the analysis.
  - Run the commands in `import_csv_xxx.txt` file after creating the tables (refer to [this chapter](#Import-.csv-Data-to-RDBMS)) to import the .csv raw data unzipped from src directory to the database.
  - Rename `import_sqoop_sh.txt` to .sh and execute it after configuring the Hadoop/Hive/Sqoop environment to import the data (imported into MySQL using `import_csv_mysql.txt`) to Hive (refer to [this chapter](#Import-RDBMS-Data-to-Hive)).

## Environment Build-up

### Basic Environment

All the solutions in this repo were based on `jupyter-lab` (or `jupyter notebook`). [Anaconda](https://www.anaconda.com) toolkit is recommended.

- Non-Hadoop solutions (PostgreSQL, R, Python):
  - Install and run [PostgreSQL](https://www.postgresql.org/download/)
  - Import SQLZOO data to PostgreSQL instance
- Hadoop solutions (Hive, Spark):
  - Hive: install [Hadoop & Hive](http://spark.apache.org/downloads.html) in Linux, or Docker version of CDH, or Docker image of Hadoop+Hive cluster. Cloud service is also applicable.
  - Spark: install independent Hadoop+Spark packages, or Docker version of CDH, or Docker image of Spark cluster. Cloud servie is also applicable.

### Specific Environment

- PostgreSQL: pip install `ipython-sql`
- R：install `IRkernel`, `IRdisplay` and other dependencies to support R kernel, install `dplyr` in R
- Python：pip install `pandas`
- Hive：install jdbc drivers required by sqoop, and bash install `sasl2-bin`, `libsasl2-dev`, pip install `pyhs2` & `pyhive[hive]`
- Spark：
  - `PySpark`: Spark computation environment is set, pip install `findspark`
  - `Scala` kernel: Download, compile install and configure [almond.sh](https://almond.sh/docs/quick-start-install) according to the manual. Note that the almond version should be compatible with the scala. In this instance, almond 0.14 and scala 2.13 were applied, with spark 3.4.0.
## Data Preparations

### Create RDBMS Tables

First of all, create a `sqlzoo` instance in the database and use it

- MySQL: `use sqlzoo;`
- PostgreSQL: `\c sqlzoo`

Under the root directory of this repo there are two scripts `create_tbl_mysql.sql` & `create_tbl_postgres.sql`. Use the correct one according to your actual database environment.
Run the script in command line interface (cli) to create all the tables in one time. You can also call the script in a DB Admin GUI if applicable.

You can also write your own script. Input `show create table world;` in a SQLZOO solution textarea and you will get the DDL syntax to create the table `world`:

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

All the DDLs can be obtained in this way. It is MySQL syntax, you need to adjust it a little bit if you use PostgreSQL.

### Import .csv Data to RDBMS

There is a data.7z archive under src directory of this repo. Unzip it using any tool that supports 7z algorithm (e.g., 7z in Windows) to get all the raw .csv data files (78 in total).

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

There are two script files `import_csv_mysql.txt` & `import_csv_postgresql.txt` under the root directory. Choose the correct one according to your own database environment. The two files stored all the commands that import .csv data to database. You need to run them one by one in a database CLI. For example, execute the follwing command in PostgreSQL

```sql
\COPY teacher FROM '~/Documents/sqlzoo/src/teacher.csv' WITH DELIMITER ',' CSV NULL AS 'NULL' HEADER;
```

or the following in MySQL

```sql
load data local infile '~/Documents/sqlzoo/src/data/teacher.csv' into table teacher 
  character set latin1 fields terminated by ',' optionally enclosed by '"' escaped by '"' lines terminated by '\n' ignore 1 lines
  (id,@dept,name,phone,@mobile)
  set dept=NULLif(@dept, 'NULL'), mobile=NULLif(@mobile, 'NULL');
```

to import actor.csv to the table actor. But note that the file location may be different from yours, adjust it accordingly.

> Please cautious that the in this repo, missing values were stored as 'NULL' in the .csv files. It could be identified by PostgreSQL but not MySQL (by default, '\N'). So an additional `NULLif()` conversion function is needed. You can also replace them manually before importing.
> PS, in the commands stored in `import_csv_mysql.txt`, some date/timestamp fields need to be converted by `str_to_date(@<field name>, '%a, %d %b %Y %T GMT')` function, otherwose they may not be identified correctly by MySQL.

### Import RDBMS Data to Hive

There are two basic approaches to import data to Hive

1. Compose similar .hql scripts as depicted in [this chapter](#Import-.csv-Data-to-RDBMS) to create empty tables in Hive, and then execute `load data` commands to import .csv file to the empty tables.
2. Import the data imported into RDBMS based on [this chapter](#Import-.csv-Data-to-RDBMS) to Hive using sqoop scripts.

The following is what was applied in this repo (the 2nd approach).

#### Docker Install CDH5.13

##### Pull the Mirror

The mirror is large (7G). You can use mirror boosting if the connection is bad, or download the mirror file to local disk and then apply `docker import`.

```bash
docker pull  cloudera/quickstart:lastest
```

##### Initialize CDH Mirror

After initialization, you can use Kitematic GUI to manage the docker mirror.

```bash
docker run --privileged=true --hostname=quickstart.cloudera \
-p 4040:4040 -p 7077:7077 -p 8020:8020 -p 7180:7180 -p 21050:21050 \
-p 10000:10000 -p 50070:50070 -p 50075:50075 -p 50010:50010 -p 50020:50020 \
-p 28080:8080 -p 18080:18080 -p 8888:8888 -p 9083:9083 \
-t -i -d <cdh docker image id> /usr/bin/docker-quickstart
```

##### Initiate cloudera-manager inside CDH

```bash
docker exec -ti <cdh docker image id> /bin/bash
[root@quickstart /]# /home/cloudera/cloudera-manager --force --express && service ntpd start
```

##### Allow Docker Mirror to Access the Host MySQL Database

You need to operate in the host machine's CLI.

- Find and edit the MySQL configuration file (e.g., in Ubuntu, '/etc/mysql/mysql.conf.d/mysqld.cnf'), comment the sentence 'bind 127.0.0.1'
- Enter the database with root (take MySQL for instance in this repo) to execute authentication commands

```sql
grant all privileges on *.* to 'root'@'172.17.0.2' identified by '<pwd>' with grant option;
flush privileges;
```

> pwd is the password of the database. In this repo, the virtual IP of the host machine is 172.17.0.1 while that of the docker mirror is 127.17.0.2. The access is only approved for the docker mirror. You can check the ip by `ifconfig`.

- Exit the database CLI and restart MySQL service

```bash
/etc/init.d/mysqld restart
```

##### Create .sh Script to Import with sqoop

Create a .sh script inside the docker mirror and copy the codes in `import_sqoop_sh.txt` for execution. All the 78 tables in sqlzoo database on MySQL will then be imported to Hive inside the CDH mirror. This script loops over `tbls` variable to execute `sqoop import` command:

```bash
#! /bin/bash
read -p "input username:" usernm
read -s -p "input password:" pwd
tbls=("table 1", "table 2", ...)
for tbl in ${tbls[*]}
do
sqoop import --connect jdbc:mysql://172.17.0.1:3306/sqlzoo \
--username ${usernm} -password ${pwd} --table ${tbl} \
--null-string '\\N' --null-non-string '\\N' --fields-terminated-by '\t' \
--delete-target-dir --num-mappers 1 --hive-import --hive-overwrite \
--hive-database sqlzoo --hive-table ${tbl}
hive -S -e 'ALTER TABLE sqlzoo.'${tbl}' SET TBLPROPERTIES("EXTERNAL"="TRUE");'
echo "${tbl} imported"
done
```

Take care of the parameters `--null-string` & `--null-non-string`. If not assigned, the missing values in MySQL will be replaced with string 'null'.

#### Install Dockerized Hadoop+Hive+Spark Cluster

Since CDH 6 has no longer been free, it is recommended to pull [repo](https://github.com/myamafuj/hadoop-hive-spark-docker) from GitHub and create a pseudo-cluster based on Docker compose scripts.

## Obtain Raw Data

SQLZOO provides detailed instruction on how to get the raw data in [about](https://sqlzoo.net/wiki/SQLZOO:About). In this repo, crawling techniques were applied with Selenium.

There is a `scrapy_selemium.py` script under the root directory. Execute it by typing `pytest scrapy_selenium.py` in the bash to extract the data from the SQLZOO page.

### Preparation

- Install Google Chrome or Mozilla Firefox (in this repo, Chrome was applied)
- pip install selenium & pytest
- Download and unzip correct version of chrome-driver or firfox-driver

### Configuration

Do some simple configuration before running scrapy_selenium.py.

First of all, some variables `prefix`, `db`, `dblen`, `header` were defined in `test_copytext()` funciton.

Suppose you are going to extract the table 'covid', then set prefix='', db='covid', dblen=19200 (total row number of the table 'covid'), header='name whn confirmed deaths recovered' (the table header row, separated by space). If you are going to extract the table 'event' in 'University Timetables' series, then set prefix='ut_', db='event', dblen=201 (total row number of the table), header='id modle kind dow tod duration room' (the table header row, separated by space). The prefix is to distinguish it with existing table 'room' to get rid of name conflicts.

Then, set the correct path, for example, 

```python
self.driver.get("https://sqlzoo.net/wiki/Window_LAG")
```

SQLZOO displays 50 records at most, so we have to loop the extraction. Some tables must be extracted from a different page. The final result was stored in the `txt` variable. You will need to switch the commenting status to change the URL and page element accordingly. For example, when the URL is <https://sqlzoo.net/wiki/AdventureWorks>, uncomment line 48 while commenting line 54.

The final output will be store in the .csv file named after prefex+db. Some additional manual work might be needed to add comma separators and wrap some fields with paired quotes to ensure successful parsing. The data on SQLZOO is subject to change, so you might also need to update your version periodically.
