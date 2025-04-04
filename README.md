# SketchUp Extension Starter Template

This template will help you quickly start developing SketchUp extensions using Ruby.

## Quick Start

1. Clone this repository:

```bash
git clone https://github.com/vvdimoff/sketchup-extension-starter.git my-extension
cd my-extension
```

2. Edit `setup/params.yaml` to configure your extension:

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

3. Run the setup script:

```bash
ruby setup/setup.rb
```

4. Navigate to the created directory and open the project in VSCode:

```bash
cd my-extension
code .
```

5. Create a new repository on GitHub and push your code:

```bash
git remote add origin https://github.com/your-username/my-extension.git
git push -u origin main
```

6. After successful setup, you can safely delete the `setup` directory as it's no longer needed.

## Project Structure

```
my-extension/
├── src/                    # Extension source code
│   └── my_extension/      # Your extension directory
│       └── main.rb        # Main extension file
├── .vscode/               # VSCode settings
├── .rubocop.yml          # RuboCop settings
├── .solargraph.yml       # Solargraph settings
├── Gemfile               # Ruby dependencies
└── README.md             # Documentation
```

## Requirements

- Ruby 3.3.7 or higher
- SketchUp 2025 or higher
- Visual Studio Code with recommended extensions

## Recommended VSCode Extensions

- rebornix.ruby
- Shopify.ruby-lsp
- misogi.ruby-rubocop
- castwide.solargraph
- kaiwood.endwise
- mbessey.vscode-rufo

## License

MIT License

## Author

Your Name (your.email@example.com)
