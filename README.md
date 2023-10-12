<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/AnoyiX/cdn@main/vscode/main.png" width="100%" style="border-radius:5%" />  
</p>

## 🚀 Quick Start

AI-VSCode based on [openvscode-server](https://github.com/gitpod-io/openvscode-server).

### Start Server

```sh
docker run -d -p 3000:3000 anoyi/ai-vscode -- --host 0.0.0.0 --without-connection-token
```

Then, visit [http://localhost:3000/](http://localhost:3000/).

There are some possible entrypoint arguments:

| Argument                   | Type   | Default   | Description                            |
| -------------------------- | ------ | --------- | -------------------------------------- |
| --host                     | string | localhost | the host the server is listening on    |
| --port                     | number | 3000      | the port number to start the server on |
| --without-connection-token |        |           | access without token                   |
| --connection-token         | string |           | access with specified token            |
| --connection-token-file    | string |           | the token file path                    |

### User Settings

Enter `command + shift + p`, then input `user` and select `Perferences: Open User Settings (JSON)`, copy below config to your editor and save.

```json
{
    "workbench.colorTheme": "Monokai Pro (Filter Spectrum)",
    "workbench.iconTheme": "Monokai Pro (Filter Spectrum) Icons",
    "window.menuBarVisibility": "classic",
    "terminal.integrated.defaultProfile.linux": "zsh",
    "editor.fontSize": 14
}
```


## ☁️ Cloud

### Huggingface

1. Create a new Space
2. Copy file `Dockerfile.huggingface` and `requirements.txt` to Space
3. Rename `Dockerfile.huggingface` to `Dockerfile`

huggingface will build and run automatically
