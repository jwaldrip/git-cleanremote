require "git-cleanremote/version"
require "thor"

module Git
  class CleanRemote < Thor::Group
    autoload :Cleaner, 'git-cleanremote/cleaner'
    autoload :Branch, 'git-cleanremote/branch'

    argument :branch_name, :default => 'master', :type => :string, :desc => "The remote branch to cleanup"
    class_option :dryrun, :type => :boolean, :default => false
    class_option :version, :type => :boolean, :default => false
    class_option :local, :type => :boolean, :default => false
    class_option :ask, :type => :boolean, :default => true
    class_option :remote, :type => :string, :default => "origin"
    desc "Cleans up a remote branch."

    def clean
      Cleaner.new(branch_name, options)
    end

  end
end
