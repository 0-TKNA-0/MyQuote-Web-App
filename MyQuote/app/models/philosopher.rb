class Philosopher < ApplicationRecord
    has_many :quotes, dependent: :destroy

    # This makes sure that when necessary, a philosopher first name, last name and date of birth has been entered. The first and last names only allow alphabetical characters and spaces
    validates :pfname, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "" }
    validates :plname, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "" }
    validates :pdob, presence: true
end