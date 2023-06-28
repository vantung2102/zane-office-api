# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id                         :bigint           not null, primary key
#  address                    :text
#  apple_uid                  :string
#  dob                        :date
#  email                      :string           default(""), not null
#  email_verification_sent_at :datetime
#  email_verification_token   :string
#  email_verified_at          :datetime
#  first_name                 :string
#  gender                     :string
#  google_uid                 :string
#  join_date                  :date
#  last_name                  :string
#  password_digest            :string           default(""), not null
#  phone_code                 :string
#  phone_number               :string
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  status                     :integer
#  user_name                  :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_employees_on_apple_uid   (apple_uid)
#  index_employees_on_google_uid  (google_uid)
#
class Employee < ApplicationRecord
  rolify
  has_secure_password

  # validations
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, on: :create

  def generate_email_verification_token!
    self.email_verification_token = generate_token
    self.email_verification_sent_at = Time.current
    save!
  end

  def verify_email!
    self.email_verified_at = Time.current
    self.email_verification_token = nil
    save!
  end

  def email_token_expired?
    (email_verification_sent_at + 4.hours) < Time.current
  end

  private

  def generate_token
    (SecureRandom.random_number(9e5) + 1e5).to_i.to_s
  end
end
