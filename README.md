# Dev Container Templates Profesionais

Este repositório contém uma coleção de templates Dev Container profissionais, projetados para acelerar o desenvolvimento em diversos cenários, com foco em ambientes pré-configurados e otimizados.

## Como Usar

Você pode utilizar estes templates diretamente no VS Code ou através do `devcontainer` CLI.

### No VS Code

1.  Abra a Paleta de Comandos (Ctrl+Shift+P ou Cmd+Shift+P).
2.  Procure por "Dev Containers: Add Dev Container Configuration Files..." ou "Dev Containers: Create New Dev Container...".
3.  Quando solicitado a escolher um template, você pode apontar para este repositório localmente ou publicá-lo no GitHub e adicioná-lo como um "Custom Template Repository".
    *   **Publicando no GitHub:** Após fazer o upload deste repositório para o GitHub, você pode adicionar a URL do seu repositório nas configurações do VS Code: `dev.containers.templates.repositories`.
    *   **Uso Local (Avançado):** Você pode copiar as pastas dos templates (`src/<template-id>`) para o diretório `.devcontainer/` de um projeto existente e adaptar o `devcontainer.json` manualmente, ou usar o CLI.

### Com o `devcontainer` CLI

1.  **Adicionar o repositório localmente:**
    ```bash
    devcontainer templates add --template-repo /caminho/para/seu/devcontainer-templates --base-path src
    ```
2.  **Criar um novo projeto a partir de um template:**
    ```bash
    devcontainer new --template <template-id> --workspace-folder /caminho/para/seu/novo/projeto
    ```
    Por exemplo, para o template `cuda-uv`:
    ```bash
    devcontainer new --template cuda-uv --workspace-folder ~/meu-novo-projeto-cuda
    ```
    O CLI irá então pedir as opções definidas no `devcontainer-template.json` (versão do Python, nome do projeto, etc.).

## Templates Disponíveis

-   **`cuda-uv`**: Ambiente de desenvolvimento para Python com suporte a CUDA 12 e gerenciamento de pacotes via `uv`, incluindo cache compartilhado e persistente.

---

Este repositório é expansível. Sinta-se à vontade para adicionar mais templates em `src/` seguindo a [especificação de Dev Container Templates](https://containers.dev/implementors/templates/).
