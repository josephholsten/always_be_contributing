require 'always_be_contributing/user'

module AlwaysBeContributing
  class Org < Struct.new(:name)
    def members
      member_ids.map {|id| User.new id }
    end

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
