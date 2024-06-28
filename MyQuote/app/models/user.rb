class User < ApplicationRecord
    has_secure_password
    has_many :quotes, dependent:  :destroy
    
    # This makes sure that when necessary, a users first name, last name and email have been entered. The first and last names only allow alphabetical characters and spaces. 
    # The email address must contain an @. The status creates 3 options for a drop down box to choose from.
    validates :ufname, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters" } 
    validates :ulname, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "can only contain letters" }
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^A\s]+@[^@\s]+\z/, message: "Address Is Not Correct, Please Try Again" }
    validates :status, inclusion: { in: %w(Active Suspended Banned) }
    validates :password, length:  { minimum: 8, message: " Must Be At Least 8 Characters Long"}, allow_blank: true
end