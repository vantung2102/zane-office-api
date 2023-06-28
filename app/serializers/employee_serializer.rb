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
class EmployeeSerializer < ApplicationSerializer
  fields :email,
         :email_verified_at

  view :auth do
    fields :auth_token
  end
end
