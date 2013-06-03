require 'octokit'

require 'always_be_contributing/user'

module AlwaysBeContributing
  class Org < Struct.new(:name)
    # returns a list of Users for each member of the Org
    def members
      member_ids.map {|id| User.new id }
    end

    # take each member of the Org, create a pair of the User name and
    # the user's contributions since begin_date, and reverse sort the
    # list by number of contributions
    def member_contribution_count_since(begin_date)
      {}.tap do |contribution_counts|
        members.each do |m|
          contribution_counts[m.name] = m.contribution_count_since(begin_date)
        end
      end.
      sort_by {|u| u[1] }.
      reverse
    end

    private
    def member_ids
      Octokit.org_members(name).map(&:login)
    end
  end
end
