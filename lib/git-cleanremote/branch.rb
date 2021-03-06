require 'open4'

class Git::CleanRemote::Branch

  attr_reader :name, :remote

  def initialize(name, remote)
    @name = name
    @remote = remote
  end

  def to_s
    [remote, name].join('/')
  end

  def delete!
    error = ''
    status = Open4::popen4("git push #{remote} --delete #{name}") do |pid, stdin, stdout, stderr|
      error = stderr.gets.to_s
    end
    raise StandardError, error if status.to_i > 0
    true
  end

  def local_delete!
    error = ''
    status = Open4::popen4("git branch -D #{name}") do |pid, stdin, stdout, stderr|
      error = stderr.gets.to_s
    end
    raise StandardError, error if status.to_i > 0
    true
  end

end