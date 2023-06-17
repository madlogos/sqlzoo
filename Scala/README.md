# SQLZOO试题的Spark实现 | Scala Implementation of SQLZOO Solutions

## 步骤 Steps

1. 需要安装好Spark环境，可直接从[官网](http://spark.apache.org/downloads.html)下载Spark with Hadoop，解压到宿主机本地。推荐用Spark2。
2. 将`SPARK_HOME`路径写入环境PATH，命令行输入`spark-shell`可调出Scala CLI，或`pyspark`调出pyspark CLI。
    - Windows，在环境变量界面配置SPARK_HOME入口
    - Linux/macOS，在/etc/profile中export SPARK_HOME，并添加到PATH
3. 确保Docker镜像已启动，Hive metastore service已启动：
    1. CDH5：8020、9083端口已映射到宿主机。
    2. Hadoop-hive-spark：7077、9000、9083端口已映射到宿主机。

4. Jupyter中，通过NotebookSparkSession配置`spark.sql.warehouse.dir`,`hive.metastore.uris`, `spark.sql.catalogImplementation`，（初次Notebook会自动下载安装各类依赖，如spark-hive, spark-stubs），让scala连接到Docker镜像中的Hive数据库。

---

1. Install Spark environment. You can download Spark with Hadoop from [Official website](http://spark.apache.org/downloads.html) andunzip it to host local disk. Spark2 is recommended.
2. Write SPARK_HOME to environment PATH. Then you can call Scala CLI by inputing `spark-shell` or pyspark by inputing `pyspark`in the CLI.
    - Windows: configure SPARK_HOME entry in the environment variable pane
    - Linux/macOS: export SPARK_HOME in /etc/profile and then combine it into PATH
3. Ensure that Docker image is booted and Hive metastore service is started
    1. CDH5: ensure ports 8020, 9083 are exposed to the host machine.
    2. Hadoop-hive-spark: ensure ports 7077, 9000, 9083 are exposed to the host machine.

4. In Jupyter, configure `spark.sql.warehouse.dir`,`hive.metastore.uris`, `spark.sql.catalogImplementation`, etc. (the Notebook will download and install necessary dependencies automatically at the first time, e.g., spark-hive, spark-stubs) in NotebookSparkSession to establish connection of Scala to Hive database in Docker imae.

---

- Scala (CDH5)

    ```scala
    // lower down the logger level
    import org.apache.log4j.{Level, Logger}
    Logger.getLogger("org").setLevel(Level.OFF)
    
    // import modules
    import $ivy.`org.apache.spark::spark-sql:2.4.0`
    import org.apache.spark.sql._
    import org.apache.spark.sql.functions._
    
    // set up NotebookSparkSession, 
    val spark = {
        NotebookSparkSession.builder()
        .progress(false)
        .appName("app00")
        .master("local[*]")
        .config("spark.sql.warehouse.dir", "hdfs://quickstart.cloudera:8020/user/hive/warehouse")
        .config("hive.metastore.uris", "thrift://quickstart.cloudera:9083")
        .config("spark.sql.catalogImplementation", "hive")
        .config("spark.sql.repl.eagerEval.enabled", "True")
        .getOrCreate()
    }
    
    // import implicits
    import spark.implicits._
    ```


- Scala (Hadoop-hive-spark)

  ```scala
  // import ivy
  import $ivy.`org.apache.spark::spark-sql:3.4.0`
  
  // lower down log level
  import org.apache.log4j.{Level, Logger}
  Logger.getLogger("org").setLevel(Level.OFF)
  
  // import modules
  import org.apache.spark._
  import org.apache.spark.sql._
  import org.apache.spark.sql.functions._
  
  // set up spark session
  val spark = {
      NotebookSparkSession.builder()
      .progress(false)
      .appName("app00")
      // .master("spark://192.168.31.31:7077")
      .master("local[*]")
      .config("spark.sql.warehouse.dir", 
              "hdfs://192.168.31.31:9000/user/hive/warehouse") 
      .config("spark.cores.max", "4") 
      .config("spark.executor.instances", "1") 
      .config("spark.executor.cores", "2") 
      .config("spark.executor.memory", "10g") 
      .config("spark.shuffle.service.enabled", "false") 
      .config("spark.dynamicAllocation.enabled", "false") 
      .config("spark.sql.catalogImplementation", "hive")
      .config("spark.sql.repl.eagerEval.enabled", "true")
      .config("spark.driver.allowMultipleContexts", "true")
      .getOrCreate()
  }
  ```

  ```scala
  // create HiveContext
  import spark.implicits._
  def sc = spark.sparkContext
  val hiveCxt = new org.apache.spark.sql.hive.HiveContext(sc)
  ```

  

## 举例 Example

```scala
val world = hiveCxt.table("sqlzoo.world")
world.show()
```

```
+-----------+-------------+---------+----------+---------------+----------------+---+-----------------------------------------------------------------------------------+
|name       |continent    |area     |population| gdp           | capital        |tld|flag                                                                               |
+-----------+-------------+---------+----------+---------------+----------------+---+-----------------------------------------------------------------------------------+
|Afghanistan|Asia         | 652230.0|32225560.0|  21992000000.0|Kabul           |.af|//upload.wikimedia.org/wikipedia/commons/9/9a/Flag_of_Afghanistan.svg              |
|Albania    |Europe       |  28748.0| 2845955.0|  13039000000.0|Tirana          |.al|//upload.wikimedia.org/wikipedia/commons/3/36/Flag_of_Albania.svg                  |
|Algeria    |Africa       |2381741.0|43000000.0| 167555000000.0|Algiers         |.dz|//upload.wikimedia.org/wikipedia/commons/7/77/Flag_of_Algeria.svg                  |
|Andorra    |Europe       |    468.0|   77543.0|   3278000000.0|Andorra la Vella|.ad|//upload.wikimedia.org/wikipedia/commons/1/19/Flag_of_Andorra.svg                  |
|Angola     |Africa       |1246700.0|31127674.0| 126505000000.0|Luanda          |.ao|//upload.wikimedia.org/wikipedia/commons/9/9d/Flag_of_Angola.svg                   |
|Antigua and|Caribbean    |    442.0|   96453.0|   1248000000.0|St. John's      |.ag|//upload.wikimedia.org/wikipedia/commons/8/89/Flag_of_Antigua_and_Barbuda.svg      |
|Barbuda    |             |         |          |               |                |   |                                                                                   |
|Argentina  |South America|2780400.0|44938712.0| 637486000000.0|Buenos Aires    |.ar|//upload.wikimedia.org/wikipedia/commons/1/1a/Flag_of_Argentina.svg                |
|Armenia    |Eurasia      |  29743.0| 2957500.0|  11536000000.0|Yerevan         |.am|//upload.wikimedia.org/wikipedia/commons/2/2f/Flag_of_Armenia.svg                  |
|Australia  |Oceania      |7692024.0|25690023.0|1408675000000.0|Canberra        |.au|//upload.wikimedia.org/wikipedia/commons/8/88/Flag_of_Australia_%28converted%29.svg|
|Austria    |Europe       |  83871.0| 8902600.0| 416835000000.0|Vienna          |.at|//upload.wikimedia.org/wikipedia/commons/4/41/Flag_of_Austria.svg                  |
+-----------+-------------+---------+----------+---------------+----------------+---+-----------------------------------------------------------------------------------+
```

## 目录 Table of Contents

### 基础题 Fundermentals

Title | Link
------|--------
00 SELECT basics  | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/00%20SELECT%20basics.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/00%20SELECT%20basics.ipynb)
01 SELECT name | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/01%20SELECT%20name.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/01%20SELECT%20name.ipynb)
02 SELECT from World | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/02%20SELECT%20from%20World.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/02%20SELECT%20from%20World.ipynb)
03 SELECT from Nobel | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/03%20SELECT%20from%20Nobel.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/03%20SELECT%20from%20Nobel.ipynb)
04 SELECT within SELECT | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/04%20SELECT%20within%20SELECT.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/04%20SELECT%20within%20SELECT.ipynb)
05 SUM and COUNT | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/05%20SUM%20and%20COUNT.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/05%20SUM%20and%20COUNT.ipynb)
06 JOIN | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/06%20JOIN.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/06%20JOIN.ipynb)
07 More JOIN operations | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/07%20More%20JOIN%20operations.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/07%20More%20JOIN%20operations.ipynb)
08 Using Null | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/08%20Using%20Null.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/08%20Using%20Null.ipynb)
08+ Numeric Examples | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/08+%20Numeric%20Examples.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/08+%20Numeric%20Examples.ipynb)
09- Window function | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/09-%20Window%20function.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/09-%20Window%20function.ipynb)
09 Self join | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/09%20Self%20join.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/09%20Self%20join.ipynb)
09+ COVID-19 | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/09%2B%20COVID%2019.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/09%2B%20COVID%2019.ipynb)

### 提高题 Advanced

Title | Link
------|--------
11 Module Feedback | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/11%20Module%20Feedback.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/11%20Module%20Feedback.ipynb)
12-1 Helpdesk - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/12-1%20Helpdesk%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/12-1%20Helpdesk%20-%20Easy.ipynb)
12-2 Helpdesk - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/12-2%20Helpdesk%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/12-2%20Helpdesk%20-%20Medium.ipynb)
12-3 Helpdesk - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/12-3%20Helpdesk%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/12-3%20Helpdesk%20-%20Hard.ipynb)
13-1 Guest House - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/13-1%20Guest%20House%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/13-1%20Guest%20House%20-%20Easy.ipynb)
13-2 Guest House - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/13-2%20Guest%20House%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/13-2%20Guest%20House%20-%20Medium.ipynb)
13-3 Guest House - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/13-3%20Guest%20House%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/13-3%20Guest%20House%20-%20Hard.ipynb)
14-1 AdventureWorks - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/14-1%20AdventureWorks%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/14-1%20AdventureWorks%20-%20Easy.ipynb)
14-2 AdventureWorks - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/14-2%20AdventureWorks%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/14-2%20AdventureWorks%20-%20Medium.ipynb)
14-3 AdventureWorks - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/14-3%20AdventureWorks%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/14-3%20AdventureWorks%20-%20Hard.ipynb)
14-4 AdventureWorks - Resit | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/14-4%20AdventureWorks%20-%20Resit.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/14-4%20AdventureWorks%20-%20Resit.ipynb)
15-1 University Timetables - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/15-1%20University%20Timetables%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/15-1%20University%20Timetables%20-%20Easy.ipynb)
15-2 University Timetables - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/15-2%20University%20Timetables%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/15-2%20University%20Timetables%20-%20Medium.ipynb)
15-3 University Timetables - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/15-3%20University%20Timetables%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/15-3%20University%20Timetables%20-%20Hard.ipynb)
15-4 University Timetables - Resit | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/15-4%20University%20Timetables%20-%20Resit.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/15-4%20University%20Timetables%20-%20Resit.ipynb)
16-1 Musicians - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/16-1%20Musicians%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/16-1%20Musicians%20-%20Easy.ipynb)
16-2 Musicians - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/16-2%20Musicians%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/16-2%20Musicians%20-%20Medium.ipynb)
16-3 Musicians - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/16-3%20Musicians%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/16-3%20Musicians%20-%20Hard.ipynb)
17-0 Dressmaker - Samples | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/17-0%20Dressmaker%20-%20Samples.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/17-0%20Dressmaker%20-%20Samples.ipynb)
17-1 Dressmaker - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/17-1%20Dressmaker%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/17-1%20Dressmaker%20-%20Easy.ipynb)
17-2 Dressmaker - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/17-2%20Dressmaker%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/17-2%20Dressmaker%20-%20Medium.ipynb)
17-3 Dressmaker - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/17-3%20Dressmaker%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/17-3%20Dressmaker%20-%20Hard.ipynb)
18-1 Congestion - Easy | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/18-1%20Congestion%20-%20Easy.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/18-1%20Congestion%20-%20Easy.ipynb)
18-2 Congestion - Medium | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/18-2%20Congestion%20-%20Medium.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/18-2%20Congestion%20-%20Medium.ipynb)
18-3 Congestion - Hard | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/18-3%20Congestion%20-%20Hard.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/18-3%20Congestion%20-%20Hard.ipynb)

### 挑战 Challenge

Title | Link
------|--------
19 White Christmas | [GitHub](https://github.com/madlogos/sqlzoo/blob/master/Spark/19%20White%20Christmas.ipynb)  [Gitee](https://gitee.com/madlogos/sqlzoo/blob/master/Spark/19%20White%20Christmas.ipynb)
