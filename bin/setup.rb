#!/usr/bin/env ruby


backend_setup_script = "bin/setuprails.rb"

db_setup_script = "bin/setupdb.rb"

def open_terminal_tab(title, script)
    current_dir = Dir.pwd
    system("osascript -e 'tell app \"Terminal\" to do script \"cd \\\"#{Dir.pwd}\\\" && ruby #{script}\"'")
  end
  
  
  system("chmod +x bin/setuprails.rb")
  system("chmod +x bin/setuprailsdb.rb")
  system("chmod +x bin/setupsidekiqdb.rb")
  

  open_terminal_tab("Backend Setup", 'backendapp/bin/setuprails.rb')

  open_terminal_tab("DB Setup", 'backendapp/bin/setupdb.rb')

  open_terminal_tab("REDIS Setup", 'backendapp/bin/setupsidekiqdb.rb')