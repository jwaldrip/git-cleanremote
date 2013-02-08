class Git::CleanRemote::Cleaner < Thor::Shell::Color

  attr_reader :branch, :remote, :options

  def initialize(branch, options={})
    @padding = 0
    return say ["git-cleanremote", Git::CleanRemoteVersion::STRING].join(' ') if options[:version]
    options  = options.dup
    @branch  = branch
    @remote  = options.delete :remote
    @options = options
    if options[:dryrun]
      dryrun
    else
      run
    end
  end

  private

  def dryrun
    get_merged_branches
    array = @merged_branches.map do |branch|
      [branch.to_s, set_color("will be deleted!", :red)]
    end
    print_table array
    count = array.count
    say "\n" + [count, (count == 1 ? 'branch' : 'branches'), 'will be deleted!'].join(' ')
  end

  def run
    if options[:ask]
      dryrun
      say "\n"
      if yes? "Do you want to delete the above branches?", :yellow
        delete_merged_branches
      else
        say "ABORTED!", :red
      end
    else
      get_merged_branches
      delete_merged_branches
    end
  end

  def delete_merged_branches
    say "Deleting branches on #{remote}", :blue, true
    status  = @merged_branches.reduce({}) do |hash, branch|
      hash[:success] ||= 0
      hash[:error]   ||= 0
      begin
        branch.delete!
        branch.local_delete! if options[:local]
        say [set_color("DELETED", :yellow), branch].join(" ")
        hash[:success] += 1
      rescue => message
        say [set_color("ERROR  ", :red), branch, set_color(message, :magenta)].join(" ")
        hash[:error] += 1
      end
      hash
    end
    system "git fetch #{remote} --prune"
    message = []
    message << [status[:success], (status[:success] == 1 ? 'deletion' : 'deletions')].join(' ')
    message << [status[:error], (status[:error] == 1 ? 'error' : 'errors')].join(' ')
    say message.join(', ')
  end

  def get_merged_branches
    say "Invalid Remote!", :red and exit unless system "git fetch #{remote} --prune"
    say "Checking merge status on #{remote} for #{branch}", :blue
    @merged_branches = `git branch -r --merged #{remote}/#{branch}`.lines.reduce([]) do |branches, branch|
      remote, branch = branch.strip.split('/')
      unless (branch == self.branch && remote == self.remote) || remote != self.remote
        branches << Git::CleanRemote::Branch.new(branch, remote)
      end
      branches
    end
    if @merged_branches.empty?
      say "Nothing to clean!", :blue and exit
    end
  end

end