require "git-cleanremote/version"
require "thor"

module Git
  class CleanRemote < Thor::Group
    autoload :Cleaner, 'git-cleanremote/cleaner'

    argument :branch_name, :default => 'master', :type => :string, :desc => "The remote branch to cleanup"
    class_option :dryrun, :type => :boolean
    class_option :remote, :type => :string
    desc "Cleans up a remote branch"

    def clean
      Cleaner.new(branch_name, options)
    end

  end
end
