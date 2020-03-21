# Gem Viewer
  - Gem Viewer is a tool for easy accessing gem defined in your `Gemfile`.

    <img src="https://media.giphy.com/media/MZ8rI0zuPZYDHcJyzn/giphy.gif"></img>

## Features
  - Load selected gem to VS Code workspace
  - Open the selected file in a new tab in VS code
  - Display the version and path for the selected gem
    ```md
    >> gem_viewer Gem::File

    << Gem >>
    version: 1.0.0
    path : /Users/[your_user_name]/.rvm/gems/ruby-2.6.3/gems/gem-1.0.0
    << file.rb >>
    path: /Users/[your_user_name]/.rvm/gems/ruby-2.6.3/gems/gem-1.0.0/lib/files/file.rb
    ```


### How to use:
  1. Select the gem and file you want to access
  2. Press `Cmd+Shift+P` to trigger command action
  3. Type of select `Gem Viewer`

## Requirements

- ruby
- bundler
