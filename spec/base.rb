require 'rubygems'
require 'spec'
require 'fileutils'
 
require File.dirname(__FILE__) + '/../lib/picture-safe'
require 'command'
require 'commands/base'
Dir["#{File.dirname(__FILE__)}/../lib/picture-safe/commands/*"].each { |c| require c }
 
def prepare_command(klass)
  command = klass.new(['--app', 'myapp'])
  command.stub!(:args).and_return([])
  command.stub!(:display)
  #command.stub!(:psafe).and_return(mock('heroku client', :host => 'heroku.com'))
  #command.stub!(:extract_app).and_return('myapp')
  command
end
 
module SandboxHelper
  def bash(cmd)
    FileUtils.cd(@sandbox) { |d| return `#{cmd}` }
  end
end
