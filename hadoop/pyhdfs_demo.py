import pyhdfs
# 建立pyhdfs客户端
fs = pyhdfs.HdfsClient(hosts="47.74.48.102:9870", user_name="root")
# 返回用户根目录
userhomedir = fs.get_home_directory()
print(userhomedir)
availablenode = fs.get_active_namenode()
print(availablenode)
# 创建data文件夹
fs.mkdirs("/data")
print(fs.listdir("/"))
# fs.create('/user/root/shared/abc.txt','abc')
# print(fs.listdir("/app-logs/root/logs-tfile/application_1649210324468_0001"))
# fs.copy_to_local("/app-logs/root/logs-tfile/application_1649210324468_0001/2de7eff3f8ad_37543", '2de7eff3f8ad_37543')  
# 从本地上传到hadoop上
fs.copy_from_local("/root/docker-hadoop/http.log", "/data/http.log", overwrite=True)  
# # 从hadoop下载到本地
fs.copy_to_local("/data/http.log", 'http3.log')
# 删除文件
# fs.delete("/data/http.log")  

