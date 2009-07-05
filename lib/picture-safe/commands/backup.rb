module PictureSafe::Command
  class Backup < Base
    def index
      display psafe.backup(home_directory)
    end
    
  end
end