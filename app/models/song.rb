class Song < ActiveRecord::Base
    validates :title, presence: true
    #cannot be repeated by the same artist in
    #the same year
    validates :title, uniqueness:{
        scope: %i[release_year artist_name],
        message: 'cannot be repeated by the same artist in the same year'
        }

    validates :released, inclusion: { in: [true, false] }
    #if song was never officialy released optional
    #else presence true
    # must be less than or equal to
    #current year
    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
            less_than_or_equal_to: Date.today.year
        }
    end
    def released?
        released
    end

    validates :artist_name, presence: true
    validates :genre, presence: true
end
