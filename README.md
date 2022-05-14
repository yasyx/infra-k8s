## 客户模板项目

#### 项目中需要设置Action-secrets:

- TOKEN
  个人的token为了克隆私有项目使用：https://github.com/settings/tokens/new
- REGISTRY_USERNAME
  镜像仓库的用户名
- REGISTRY_PASSWORD
  镜像仓库的密码

#### 项目中需要设置的变量
在.github/workflows/autobuild.yml配置相关的变量
- domain 镜像仓库的域名
- repo 仓库名称
- prefix 镜像前缀
- sealos sealos的版本号默认4.0.0-alpha.11

#### 如何使用
1. 在根目录创建应用目录，放入集群镜像相关需要的文件，支持Dockerfile和Kubefile
2. 创建Issue可以看到使用说明
