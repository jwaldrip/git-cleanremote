require "pry"

class Git::CleanRemote::Cleaner

  def initialize(branch, options={})
    binding.pry
    return dryrun! if options[:dryrun]
  end

end