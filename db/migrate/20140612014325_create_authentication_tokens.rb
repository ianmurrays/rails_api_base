class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.string :token
      t.datetime :expires_at
      t.references :user, index: true

      t.timestamps
    end
  end
end
