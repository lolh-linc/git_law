class ProposedLaw < ActiveRecord::Base
  belongs_to :jurisdiction, inverse_of: :proposed_laws
  belongs_to :user, inverse_of: :proposed_laws

  has_one :adopted_law, inverse_of: :proposed_law

  validates :jurisdiction, presence: true
  validates :user, presence: true
  validates :title, presence: true

  acts_as_git_flow_repo node_class: ProposedLawNode

  after_create_working_repo :initialize_working_repo

  private

  def initialize_working_repo
    # TODO is this the best way to assure the jurisdiction has a repo initialized?
    jurisdiction.working_repo
    # Track the public-facing canonical repo, and pull up to current version
    working_repo.add_remote 'canonical', jurisdiction.repo_path
    # Master branch of proposed law will track canonical master
    working_repo.pull 'canonical', 'master'
    # TODO: Should this branch include a numerical identifier for proposed law?
    working_repo.add_remote 'proposed-law', repo_path
    working_repo.branch("proposed-law").create
    working_repo.checkout("proposed-law")
    # If proposed repo already has content, pull it in
    if working_repo.branches['proposed-law/proposed-law']
      working_repo.pull 'proposed-law', 'proposed-law'
    # Otherwise, initialize proposed repo with stub content
    else
      FileUtils.cp_r Dir.glob("#{::Rails.root}/lib/assets/proposed_law/*"), working_repo_path
      working_repo.add '.'
      working_repo.commit 'Set up initial stub for proposed law.'
      working_repo.push 'proposed-law', 'proposed-law'
    end
  end
end
