class CreateEmployee < ActiveRecord::Migration[7.0]
  def change
    create_table :employees, id: :uuid do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :gender
      t.string :nationality_code
      t.text :address
      t.date :join_date
      t.integer :status, limit: 2
      t.string :email, null: false, default: ''
      t.string :password_digest, null: false, default: ''
      t.string :phone_code
      t.string :phone_number
      t.datetime :email_verified_at
      t.string :email_verification_token
      t.datetime :email_verification_sent_at
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps
    end
  end
end
