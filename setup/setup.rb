#!/usr/bin/env ruby
require "yaml"
require "fileutils"
require "open3"

class Setup
  TEMPLATE_REPO = "https://github.com/SketchUp/sketchup-extension-vscode-project.git"

  def initialize
    @params = YAML.load_file("setup/params.yaml")
    @project_dir = @params["project_name"]
  end

  def run
    check_ruby_version
    create_project_directory
    copy_template_files
    create_extension_structure
    setup_git
    install_gems
    install_vscode_extensions
    puts "\nSetup completed successfully! 🎉"
    puts "\nNext steps:"
    puts "1. cd #{@project_dir}"
    puts "2. code ."
    puts "3. Create a new repository on GitHub"
    puts "4. git remote add origin YOUR_REPOSITORY_URL"
    puts "5. git push -u origin main"
    puts "\nYou can now safely delete the 'setup' directory as it's no longer needed."
  end

  def cleanup
    puts "\nCleaning up..."
    if File.directory?(@project_dir)
      FileUtils.rm_rf(@project_dir)
      puts "✓ Project directory removed"
    end
    puts "✓ Cleanup completed"
  end

  private

  def check_ruby_version
    required_version = @params["ruby_version"]
    current_version = RUBY_VERSION

    unless current_version.start_with?(required_version)
      puts "Error: Required Ruby version #{required_version}, but found #{current_version}"
      return
    end
    puts "✓ Ruby version check passed"
  end

  def create_project_directory
    puts "\nCreating project directory..."
    if File.directory?(@project_dir)
      puts "! Warning: Directory #{@project_dir} already exists. Removing it..."
      FileUtils.rm_rf(@project_dir)
    end
    FileUtils.mkdir_p(@project_dir)
    puts "✓ Project directory created at #{@project_dir}"
  end

  def copy_template_files
    puts "\nCopying template files..."
    # Копируем все файлы кроме setup и .git
    Dir.glob("*", File::FNM_DOTMATCH).each do |file|
      next if file == "." || file == ".." || file == ".git" || file == "setup" || file == @project_dir
      FileUtils.cp_r(file, @project_dir)
    end
    puts "✓ Template files copied"
  end

  def create_extension_structure
    puts "\nCreating extension structure..."
    extension_dir = File.join(@project_dir, "src", @params["extension_folder_name"])
    FileUtils.mkdir_p(extension_dir)

    # Создаем основной файл расширения
    main_file = File.join(@project_dir, "src", "#{@params["extension_folder_name"]}.rb")
    main_content = <<~RUBY
      # Copyright #{Time.now.year} #{@params["author_name"]}
      # Licensed under the MIT license

      require 'sketchup.rb'
      require 'extensions.rb'

      module #{@params["extension_name"].split("_").map(&:capitalize).join}
        module #{@params["extension_folder_name"].split("_").map(&:capitalize).join}

          unless file_loaded?(__FILE__)
            ex = SketchupExtension.new('#{@params["extension_name"]}', '#{@params["extension_folder_name"]}/main')
            ex.description = '#{@params["extension_description"]}'
            ex.version     = '#{@params["extension_version"]}'
            ex.copyright   = '#{@params["author_name"]} © #{Time.now.year}'
            ex.creator     = '#{@params["author_name"]}'
            Sketchup.register_extension(ex, true)
            file_loaded(__FILE__)
          end

        end # module #{@params["extension_folder_name"].split("_").map(&:capitalize).join}
      end # module #{@params["extension_name"].split("_").map(&:capitalize).join}
    RUBY
    File.write(main_file, main_content)

    # Создаем main.rb
    main_rb = File.join(extension_dir, "main.rb")
    main_rb_content = <<~RUBY
      # Copyright #{Time.now.year} #{@params["author_name"]}
      # Licensed under the MIT license

      require 'sketchup.rb'

      module #{@params["extension_name"].split("_").map(&:capitalize).join}
        module #{@params["extension_folder_name"].split("_").map(&:capitalize).join}

          def self.reload
            original_verbose = $VERBOSE
            $VERBOSE = nil
            pattern = File.join(File.dirname(__FILE__), '**/*.rb')
            Dir.glob(pattern).each { |file| load file }.size
          ensure
            $VERBOSE = original_verbose
          end

        end # module #{@params["extension_folder_name"].split("_").map(&:capitalize).join}
      end # module #{@params["extension_name"].split("_").map(&:capitalize).join}
    RUBY
    File.write(main_rb, main_rb_content)

    puts "✓ Extension structure created"
  end

  def setup_git
    puts "\nSetting up git repository..."
    system("cd #{@project_dir} && git init")
    system("cd #{@project_dir} && git add .")
    system("cd #{@project_dir} && git commit -m 'Initial commit from template'")
    puts "✓ Git repository initialized"
  end

  def install_gems
    puts "\nInstalling gems..."
    system("cd #{@project_dir} && bundle install")
    puts "✓ Gems installed"
  end

  def install_vscode_extensions
    puts "\nInstalling VSCode extensions..."
    extensions = [
      "rebornix.ruby",
      "Shopify.ruby-lsp",
      "misogi.ruby-rubocop",
      "castwide.solargraph",
      "kaiwood.endwise",
      "mbessey.vscode-rufo",
    ]

    extensions.each do |extension|
      system("code --install-extension #{extension}")
    end
    puts "✓ VSCode extensions installed"
  end
end

if ARGV.include?("--cleanup")
  Setup.new.cleanup
else
  Setup.new.run
end
