# SQLZOO试题的Hive实现 | Hive Implementation of SQLZOO Solutions

## 步骤 Steps

1. 需要用到[`ipython-sql`](https://github.com/catherinedevlin/ipython-sql/)包，安装方法：

    ```bash
    pip install ipython-sql
    ```

1. 需要用到`PyHive`，但要注意安装次序
    1. 安装必要的依赖，如Ubuntu需要apt-get安装`sasl2-bin`和`libsasl2-dev`
    1. pip安装`pyhs2`
    1. pip安装`'pyhive[hive]'`
1. 启动Hive（数据需提前导入）。
1. 通过`sqlalchemy`形式的DB URI连接sqlzoo数据库。本案例中，是通过宿主机连接到Cloudera Docker镜像机10000端口，故URI为`hive://cloudera@quickstart.cloudera:10000/sqlzoo`。

---

1. [`ipython-sql`](https://github.com/catherinedevlin/ipython-sql/) is required. Installation:

    ```bash
    pip install ipython-sql
    ```

1. `PyHive` is required, mind the order of installation
    1. Install neccesary dependencies, e.g., apt-get install `sasl2-bin` & `libsasl2-dev` in Ubuntu
    1. pip install `pyhs2`
    1. pip install `'pyhive[hive]'`
1. Run Hive (data should be imported before hand)
1. Connect the sqlzoo database with `sqlalchemy` compatible DB URI. In this repo, we connected to Cloudera Docker mirror by 10000 port from the host machine, so the URI is `hive://cloudera@quickstart.cloudera:10000/sqlzoo`

```sql
from pyhive import hive
%load_ext sql
%sql hive://cloudera@quickstart.cloudera:10000/sqlzoo
```

连接上以后还可以做一些设置，比如将长度显示行数的上限为10. Do some configuration after connection, e.g., set the display upper limit of rows = 10.

```sql
%config SqlMagic.displaylimit = 10
```

记得每次运行SQL语句时，前面都要加`%%sql` magic符。 Remember to add `%%sql` magic before running SQL syntax.

## 举例 Example

```sql
%%sql
SELECT * FROM world
```

name | continent | area | population | gdp | capital | tld | flag
--------|---------------|-------|----------------|-------|---------|-----|------------
Afghanistan | Asia | 652230.0 | 32225560.0 | 21992000000.0 | Kabul | .af | //upload.wikimedia.org/wikipedia/commons/9/9a/Flag_of_Afghanistan.svg
Albania | Europe | 28748.0 | 2845955.0 | 13039000000.0 | Tirana | .al | //upload.wikimedia.org/wikipedia/commons/3/36/Flag_of_Albania.svg
Algeria | Africa | 2381741.0 | 43000000.0 | 167555000000.0 | Algiers | .dz | //upload.wikimedia.org/wikipedia/commons/7/77/Flag_of_Algeria.svg
Andorra | Europe | 468.0 | 77543.0 | 3278000000.0 | Andorra la Vella | .ad | //upload.wikimedia.org/wikipedia/commons/1/19/Flag_of_Andorra.svg
Angola | Africa | 1246700.0 | 31127674.0 | 126505000000.0 | Luanda | .ao | //upload.wikimedia.org/wikipedia/commons/9/9d/Flag_of_Angola.svg
Antigua and Barbuda | Caribbean | 442.0 | 96453.0 | 1248000000.0 | St. John's | .ag | //upload.wikimedia.org/wikipedia/commons/8/89/Flag_of_Antigua_and_Barbuda.svg
Argentina | South America | 2780400.0 | 44938712.0 | 637486000000.0 | Buenos Aires | .ar | //upload.wikimedia.org/wikipedia/commons/1/1a/Flag_of_Argentina.svg
Armenia | Eurasia | 29743.0 | 2957500.0 | 11536000000.0 | Yerevan | .am | //upload.wikimedia.org/wikipedia/commons/2/2f/Flag_of_Armenia.svg
Australia | Oceania | 7692024.0 | 25690023.0 | 1408675000000.0 | Canberra | .au | //upload.wikimedia.org/wikipedia/commons/8/88/Flag_of_Australia_%28converted%29.svg
Austria | Europe | 83871.0 | 8902600.0 | 416835000000.0 | Vienna | .at | //upload.wikimedia.org/wikipedia/commons/4/41/Flag_of_Austria.svg

> 195 rows, truncated to displaylimit of 10

`world`表一共195行，但由于全局设置了`SqlMagic.displaylimit`，默认只显示了前10行。 There are a total of 195 rows in `world`. But only 10 rows are displayed due to the global setting `SqlMagic.displaylimit`.

## 目录 Table of Contents

### 基础题 Fundermentals

Title | Link
------|--------
00 SELECT basics | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/00%20SELECT%20basics.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/00%20SELECT%20basics.ipynb)
01 SELECT name | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/01%20SELECT%20name.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/01%20SELECT%20name.ipynb)
02 SELECT from World | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/02%20SELECT%20from%20World.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/02%20SELECT%20from%20World.ipynb)
03 SELECT from Nobel | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/03%20SELECT%20from%20Nobel.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/03%20SELECT%20from%20Nobel.ipynb)
04 SELECT within SELECT | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/04%20SELECT%20within%20SELECT.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/04%20SELECT%20within%20SELECT.ipynb)
05 SUM and COUNT | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/05%20SUM%20and%20COUNT.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/05%20SUM%20and%20COUNT.ipynb)
06 JOIN | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/06%20JOIN.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/06%20JOIN.ipynb)
07 More JOIN operations | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/07%20More%20JOIN%20operations.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/07%20More%20JOIN%20operations.ipynb)
08 Using Null | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/08%20Using%20Null.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/08%20Using%20Null.ipynb)
08+ Numeric Examples | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/08+%20Numeric%20Examples.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/08+%20Numeric%20Examples.ipynb)
09- Window function | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/09-%20Window%20function.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/09-%20Window%20function.ipynb)
09 Self join | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/09%20Self%20join.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/09%20Self%20join.ipynb)
09+ COVID-19 | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/09%2B%20COVID%2019.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/09%2B%20COVID%2019.ipynb)

### 提高题 Advanced

Title | Link
------|--------
11 Module Feedback | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/11%20Module%20Feedback.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/11%20Module%20Feedback.ipynb)
12-1 Helpdesk - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/12-1%20Helpdesk%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/12-1%20Helpdesk%20-%20Easy.ipynb)
12-2 Helpdesk - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/12-2%20Helpdesk%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/12-2%20Helpdesk%20-%20Medium.ipynb)
12-3 Helpdesk - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/12-3%20Helpdesk%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/12-3%20Helpdesk%20-%20Hard.ipynb)
13-1 Guest House - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/13-1%20Guest%20House%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/13-1%20Guest%20House%20-%20Easy.ipynb)
13-2 Guest House - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/13-2%20Guest%20House%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/13-2%20Guest%20House%20-%20Medium.ipynb)
13-3 Guest House - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/13-3%20Guest%20House%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/13-3%20Guest%20House%20-%20Hard.ipynb)
14-1 AdventureWorks - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/14-1%20AdventureWorks%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/14-1%20AdventureWorks%20-%20Easy.ipynb)
14-2 AdventureWorks - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/14-2%20AdventureWorks%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/14-2%20AdventureWorks%20-%20Medium.ipynb)
14-3 AdventureWorks - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/14-3%20AdventureWorks%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/14-3%20AdventureWorks%20-%20Hard.ipynb)
14-4 AdventureWorks - Resit | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/14-4%20AdventureWorks%20-%20Resit.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/14-4%20AdventureWorks%20-%20Resit.ipynb)
15-1 University Timetables - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/15-1%20University%20Timetables%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/15-1%20University%20Timetables%20-%20Easy.ipynb)
15-2 University Timetables - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/15-2%20University%20Timetables%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/15-2%20University%20Timetables%20-%20Medium.ipynb)
15-3 University Timetables - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/15-3%20University%20Timetables%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/15-3%20University%20Timetables%20-%20Hard.ipynb)
15-4 University Timetables - Resit | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/15-4%20University%20Timetables%20-%20Resit.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/15-4%20University%20Timetables%20-%20Resit.ipynb)
16-1 Musicians - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/16-1%20Musicians%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/16-1%20Musicians%20-%20Easy.ipynb)
16-2 Musicians - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/16-2%20Musicians%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/16-2%20Musicians%20-%20Medium.ipynb)
16-3 Musicians - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/16-3%20Musicians%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/16-3%20Musicians%20-%20Hard.ipynb)
17-0 Dressmaker - Samples | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/17-0%20Dressmaker%20-%20Samples.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/17-0%20Dressmaker%20-%20Samples.ipynb)
17-1 Dressmaker - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/17-1%20Dressmaker%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/17-1%20Dressmaker%20-%20Easy.ipynb)
17-2 Dressmaker - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/17-2%20Dressmaker%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/17-2%20Dressmaker%20-%20Medium.ipynb)
17-3 Dressmaker - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/17-3%20Dressmaker%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/17-3%20Dressmaker%20-%20Hard.ipynb)
18-1 Congestion - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/18-1%20Congestion%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/18-1%20Congestion%20-%20Easy.ipynb)
18-2 Congestion - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/18-2%20Congestion%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/18-2%20Congestion%20-%20Medium.ipynb)
18-3 Congestion - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/18-3%20Congestion%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/18-3%20Congestion%20-%20Hard.ipynb)

### 挑战 Challenge

Title | Link
------|--------
19 White Christmas | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Hive/19%20White%20Christmas.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Hive/19%20White%20Christmas.ipynb)
