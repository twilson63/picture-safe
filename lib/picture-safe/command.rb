require File.dirname(__FILE__) + '/commands/base'
 
module PictureSafe
  module Command
    class InvalidCommand < RuntimeError; end
    class CommandFailed < RuntimeError; end
 
    class << self
      def run(command, args, retries=0)
        #run_internal 'auth:reauthorize', args.dup if retries > 0
        run_internal(command, args.dup)
      rescue InvalidCommand
        error "Unknown command. Run 'picture-safe help' for usage information."
      rescue CommandFailed => e
        error e.message
      rescue Interrupt => e
        error "\n[canceled]"
      end
 
      def run_internal(command, args, heroku=nil)
        namespace, command = parse(command)
        require File.dirname(__FILE__) + "/commands/#{namespace}"
        klass = PictureSafe::Command.const_get(namespace.capitalize).new(args)
        raise InvalidCommand unless klass.respond_to?(command)
        klass.send(command)
      end
 
      def error(msg)
        STDERR.puts(msg)
        exit 1
      end
 
      def parse(command)
        parts = command.split(':')
        case parts.size
          when 1
            if namespaces.include? command
              return command, 'index'
            else
              return 'app', command
            end
          when 2
            raise InvalidCommand unless namespaces.include? parts[0]
            return parts
          else
            raise InvalidCommand
        end
      end
 
      def namespaces
        @@namespaces ||= Dir["#{File.dirname(__FILE__)}/commands/*"].map do |namespace|
          namespace.gsub(/.*\//, '').gsub(/\.rb/, '')
        end
      end
 
      def extract_not_found(body)
        body =~ /^(\w+) not found$/ ? body : "Resource not found"
      end
 
      def extract_error(body)
        msg = parse_error_xml(body) rescue ''
        msg = 'Internal server error' if msg.empty?
        msg
      end
 
      def parse_error_xml(body)
        xml_errors = REXML::Document.new(body).elements.to_a("//errors/error")
        xml_errors.map { |a| a.text }.join(" / ")
      end
    end
  end
end