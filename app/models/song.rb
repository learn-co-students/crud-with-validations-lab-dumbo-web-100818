class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {scope: [:artist_name, :release_year]}
  validates :released, inclusion: {in: [true, false]}
  validates :artist_name, presence: true
  validate :release_year_validate, on: [:create, :update]

  def release_year_validate
    if self.released == true && self.release_year == nil
      errors.add(:release_year, 'You must enter a release year')
    elsif self.released == true && self.release_year > Time.now.year
      errors.add(:release_year, 'You must enter the current or a previous year!')
    end
  end

end
