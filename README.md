## 使用 Flutter 组件化开发项目

### 项目结构
```
.
├── app
├── features
│   ├── home
│   ├── login
│   ├── splash
│   └── user_center
├── infrastructure
│   ├── authentication
│   ├── common_dependencies
│   ├── core
│   ├── navigator
│   └── network
├── flutter_tool.sh
├── README.md
├── all_lint_rules.yaml
├── analysis_options.yaml
├── melos.yaml
└── melos_multi_package_sample.iml
```
### 目录说明
#### app
* 项目主工程，只有基础框架，不涉及业务，很少改动，所有实现都依赖接口
#### infrastructure
* 项目基础库
    * authentication 鉴权中心，所有用户信息鉴权数据都从这里获取
    * common_dependencies 依赖中心，所有依赖收归到这里，对外开放
    * core 项目核心，多语言、依赖注入、路由，只创建接口，不做具体实现
    * navigator 路由中心，提供组件之间跳转，组件内部跳转不走这里
    * network 网络中心，提供基础网络请求能力，封装dio
#### features
* 业务模块
    * home 主页模块
    * login 登录模块
    * splash 启动引导模块
    * user_center 用户个人中心模块
### 功能说明
* 1、代码格式化，样式检查参考了firebase，执行命令：melos lint:all
配置在all_lint_rules.yaml、analysis_options.yaml
* 2、flutter_tool.sh 脚本实现多环境配置，根据env.xx文件生成dart-define命令，具体参考dart-define
* 3、flutter多版本使用了asdf，.tool-versions配置有flutter版本
### 其他
* 使用到的技术：
    * 1、melos
    * 2、bloc
    * 3、hook

## 感谢

:star: 项目参考了 [building-a-multi-package-project-with-flutter](https://engineer-journal.hashnode.dev/building-a-multi-package-project-with-flutter) 并对其部分代码进行了引用.
