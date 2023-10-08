<p align="center">
  <h2 align="center">Visual Studio Code for AI Developer</h2>
</p>

## 🚀 快速开始

### 🐳 启动 VSCode Server

```
docker run -d -p 3000:3000 anoyi/ai-vscode --without-connection-token
```

可选的运行参数：

- `--port` 服务端口号
- `--without-connection-token` 无需 token 即可访问
- `--connection-token` 指定访问 token 

### 🌈 个性化配置 VSCode

VSCode Server 启动成功后，在浏览器访问 [http://localhost:3000/](http://localhost:3000/) 即可访问。首次访问，可以按下 `command + shift + p`，搜索 `user` 并选择 `Perferences: Open User Settings (JSON)`，进入用户个性化配置页面：

```
{
    "workbench.colorTheme": "Monokai Pro (Filter Spectrum)",
    "workbench.iconTheme": "Monokai Pro (Filter Spectrum) Icons",
    "window.menuBarVisibility": "classic",
    "terminal.integrated.defaultProfile.linux": "zsh",
    "editor.fontSize": 14
}
```


