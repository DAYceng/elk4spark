# elk4spark

#### 介绍

![image](https://github.com/DAYceng/elk4spark/assets/39471587/efaff0ff-4eb1-4ddb-aa24-0eb292728163)


#### 首次安装平台步骤

初始化安装（本机环境为anaconda的则跳过这一步）

```shell
cd dev_env/
bash zero_init_env.sh
```

* 安装

```shell
cd dev_env/
bash docker_compose_run.sh
bash elasticsearch-head_run.sh
```

* 采集流量协议日志

```shell
cd zeek/
bash get_pcap_for_test.sh
bash zeek_to_kafka.sh
```

* 进行分析操作

```
elasticsearch数据查看：http://本机ip:9100
Kibana数据展示：http://本机ip:5601
python spark数据分析：http://本机ip:8888，Jupyter notebooks password is 'net-research'
```

#### 已安装过，再次启动步骤

* docker ps 查看当前容器状态

* 如无意外，所有容器都应该正常启动着

（若发现某个容器掉了，执行docker-compose down后再运行docker_compose_run.sh重启容器，然后继续下面的步骤）

* 此时，仅需执行bash elasticsearch-head_run.sh，将es-head重启即可

#### 常见问题

1、conda下搭建平台注意事项

    * 若所使用的环境为anaconda，请不要运行zero_init_env.sh！

2、相应web界面无法访问

解决办法：

   * 确认es容器是否正常启动
   * 尝试将ip地址改为服务器的对应地址（若使用的是由docker分配的服务器，请资讯管理员服务器的ip地址）
   * 若为本地虚拟机搭建，尝试将ip地址改为0.0.0.0或者localhost

3、notebook无法创建/保存文件
    * 将elk_spark下的jupyter文件夹权限更改为777

#### References

https://github.com/coyiotis/ELK-SJ

https://github.com/zeek/zeek-docker

https://github.com/xuqinghan/docker-kafka
