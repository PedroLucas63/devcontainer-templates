# CUDA 12 + UV Template - Notas

Este template oferece um ambiente de desenvolvimento robusto para projetos Python que utilizam CUDA, com a conveniência e performance do gerenciador de pacotes `uv` (da Astral).

## Funcionalidades Principais

*   **CUDA 12.8.0:** Baseado na imagem `nvidia/cuda:12.8.0-devel-ubuntu22.04`, garantindo acesso completo às bibliotecas e ferramentas de desenvolvimento CUDA.
*   **Gerenciamento Python com `uv`:** O `uv` é pré-instalado e configurado para gerenciar ambientes virtuais e dependências de pacotes Python de forma rápida e eficiente.
*   **Cache Global e Persistente do `uv`:** O cache do `uv` (`~/.cache/uv`) é montado em um volume Docker chamado `global-uv-cache`. Isso significa que:
    *   As dependências baixadas são armazenadas e reutilizadas em **diferentes projetos** que utilizam este template, economizando tempo e banda larga.
    *   O cache persiste mesmo se o container for destruído e recriado, garantindo uma experiência de desenvolvimento contínua.
*   **Setup Inicial Flexível:** Permite configurar o ambiente Python no momento da criação do Dev Container.

## Opções do Template

Ao criar um Dev Container a partir deste template, você será questionado sobre as seguintes opções:

*   **`pythonVersion`**: A versão do Python que o `uv` deve utilizar para o ambiente virtual. (Ex: `3.12`, `3.11`).
*   **`projectName`**: Nome do projeto para `uv init`. Se deixado vazio, o nome do diretório atual será utilizado. (Ignorado se `runInitialSetup` estiver desativado).
*   **`runInitialSetup`**: Se `true` (padrão), o `postCreateCommand` inicializará um projeto `uv` (`uv init`) se não houver um `pyproject.toml`. Se `false`, criará apenas um ambiente virtual (`.venv`) com a versão do Python especificada.

## Como o `uv` Gerencia o Python

Este template instala apenas o `uv` globalmente. As versões do Python são gerenciadas pelo `uv` em ambientes virtuais (`.venv`) específicos para o seu projeto. O VS Code será configurado automaticamente para utilizar o interpretador Python do `.venv` do seu projeto.

## Extensões VS Code Pré-configuradas

As seguintes extensões são recomendadas e instaladas automaticamente no Dev Container:

*   `ms-python.python`: Suporte principal para a linguagem Python.
*   `ms-python.vscode-pylance`: Ferramenta de análise de código e preenchimento inteligente para Python.

---
**Dica:** Para otimizar ainda mais, considere adicionar um arquivo `pyproject.toml` no seu projeto com suas dependências e a configuração `[tool.uv]` para especificar o Python preferido.
