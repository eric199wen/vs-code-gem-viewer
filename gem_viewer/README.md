# Gem Viewer
  - Gem Viewer is a tool for easy accessing gem which is defined in your gemspec
    - Load selected gem to VS Code workspace
    - Open the the file in a new tab in VS code
    - Find the version and path for the selected gem

## Usage
  `Person` is a class which incldues the file, `PhoneNumber`, from Gem, `ContactInfo`

  ```ruby
  class Person
    include ContactInfo::PhoneNumber
  ```

  You can execute the script with
  ```
  >>  ~/src/gem_viewer/main.rb ContactInfo::PhoneNumber
  ```

  Then Gem Viewer will open the folder and show you the information of the gem
  ```md
  << contactInfo >>
  version: 1.0.0
  path : /Users/[your_user_name]/.rvm/gems/ruby-2.6.3/gems/contactInfo-1.0.0
  << phone_number.rb >>
  path: /Users/[your_user_name]/.rvm/gems/ruby-2.6.3/gems/contactInfo-1.0.0/lib/phone/controllers/phone_number.rb
  ```

  Also, it would load the gem to your vscode workspace so you can do further search with the built-in search in VScode

  ----

  You can also set up the alias in your `.bashrc`

  ```
  alias gv='ruby ~/src/[folder you put the gem]/main.rb'
  ```

  So it would be
  ```
  >>  gv ContactInfo::PhoneNumber
  ```

  ## Miscellaneous
  - Gem Viewer only support VS code at this point
  - Make sure the directory you run the script have bundler setup
  - If there are multiple files with the same name. Gem Viewer will open the first one it finds and generates the list of paths for all matching files





