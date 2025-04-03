# SketchUp Extension Starter Template

Этот шаблон поможет вам быстро начать разработку расширений для SketchUp с использованием Ruby.

## Быстрый старт

1. Клонируйте этот репозиторий:

```bash
git clone https://github.com/your-username/sketchup-extension-starter.git my-extension
cd my-extension
```

2. Отредактируйте файл `setup/params.yaml` под свои нужды:

```yaml
project_name: "my-extension"
ruby_version: "3.3.7"
sketchup_version: "2025"
author_name: "Your Name"
author_email: "your.email@example.com"
extension_name: "MyExtension"
extension_description: "Description of your extension"
extension_version: "1.0.0"
extension_folder_name: "my_extension"
```

3. Запустите установщик:

```bash
ruby setup/setup.rb
```

4. Перейдите в созданную директорию и откройте проект в VSCode:

```bash
cd my-extension
code .
```

5. Создайте новый репозиторий на GitHub и отправьте код:

```bash
git remote add origin https://github.com/your-username/my-extension.git
git push -u origin main
```

6. После успешной установки вы можете удалить папку `setup`, она больше не нужна.

## Структура проекта

```
my-extension/
├── src/                    # Исходный код расширения
│   └── my_extension/      # Директория вашего расширения
│       └── main.rb        # Основной файл расширения
├── .vscode/               # Настройки VSCode
├── .rubocop.yml          # Настройки RuboCop
├── .solargraph.yml       # Настройки Solargraph
├── Gemfile               # Зависимости Ruby
└── README.md             # Документация
```

## Требования

- Ruby 3.3.7 или выше
- SketchUp 2025 или выше
- Visual Studio Code с рекомендуемыми расширениями

## Рекомендуемые расширения VSCode

- rebornix.ruby
- Shopify.ruby-lsp
- misogi.ruby-rubocop
- castwide.solargraph
- kaiwood.endwise
- mbessey.vscode-rufo

## Лицензия

MIT License

## Автор

Your Name (your.email@example.com)
