COPY rsa public key to remote server for ssh no passwd login
===
前提是所有服务器都有个统一的用户名与密码
# 安装步骤
1. 在操作系统上安装expect

  ```bash
  yum install -y expect
  ```

2. 生成本地的rsa公钥秘钥
  ```bash
  ssh-keygen -t rsa
  ```
3. 编辑hosts文件添加要复制rsa的服务器名称

  请确保所有的服务器登录用户名和密码是一样的，否则无法批量复制ssh key
4. 运行批量处理脚本复制本地的公钥到服务器上
  ```bash
  ./rsa_copy.sh
  ```
