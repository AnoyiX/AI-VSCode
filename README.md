<p align="center">
  <h2 align="center">Visual Studio Code for AI Developer</h2>
</p>

### 🚀 Quick Start

AI-VSCode based on [openvscode-server](https://github.com/gitpod-io/openvscode-server).

#### 🐳 Run openvscode-server

```bash
docker run -d -p 3000:3000 anoyi/ai-vscode --without-connection-token
```

Visit the URL printed in your terminal. [http://localhost:3000/](http://localhost:3000/)

#### 🌈 User Settings

When you first access ，Enter `command + shift + p`，input `user` and select `Perferences: Open User Settings (JSON)`，copy below config to your editor and save.

```json
{
    "workbench.colorTheme": "Monokai Pro (Filter Spectrum)",
    "workbench.iconTheme": "Monokai Pro (Filter Spectrum) Icons",
    "window.menuBarVisibility": "classic",
    "terminal.integrated.defaultProfile.linux": "zsh",
    "editor.fontSize": 14
}
```


