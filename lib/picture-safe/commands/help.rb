module PictureSafe::Command
  class Help < Base
    def index
      display usage
    end
    
    def usage
      usage = <<EOTXT
== General Commands
  help    # show help
  backup  # backup photos

EOTXT
    end
  end
end