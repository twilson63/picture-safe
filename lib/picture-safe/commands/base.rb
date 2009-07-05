require 'fileutils'
 
module PictureSafe::Command
  class Base
    attr_accessor :args
    attr_reader :autodetected_app
    def initialize(args, psafe=PictureSafe)
      @args = args
      @psafe = psafe
      @autodetected_app = false
    end
 
    def display(msg, newline=true)
      if newline
        puts(msg)
      else
        print(msg)
        STDOUT.flush
      end
    end
 
    def error(msg)
      PictureSafe::Command.error(msg)
    end
 
    def ask
      gets.strip
    end
 
    def shell(cmd)
      FileUtils.cd(Dir.pwd) {|d| return `#{cmd}`}
    end
 
    def psafe
      @psafe ||= PictureSafe::Command.run_internal('auth:client', args)
    end
  
    def extract_option(options, default=true)
      values = options.is_a?(Array) ? options : [options]
      return unless opt_index = args.select { |a| values.include? a }.first
      opt_position = args.index(opt_index) + 1
      if args.size > opt_position && opt_value = args[opt_position]
        if opt_value.include?('--')
          opt_value = nil
        else
          args.delete_at(opt_position)
        end
      end
      opt_value ||= default
      args.delete(opt_index)
      block_given? ? yield(opt_value) : opt_value
    end
  
    def home_directory
      running_on_windows? ? ENV['USERPROFILE'] : ENV['HOME']
    end
 
    def running_on_windows?
      RUBY_PLATFORM =~ /mswin32/
    end
 
    # def escape(value)
    #    heroku.escape(value)
    #  end
  end
 
  # class BaseWithApp < Base
  #   attr_accessor :app
  #  
  #   def initialize(args, heroku=nil)
  #     super(args, heroku)
  #     @app ||= extract_app
  #   end
  # end
end
