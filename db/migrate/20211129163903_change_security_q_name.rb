class ChangeSecurityQName < ActiveRecord::Migration[6.1]
  if Rails.env != 'production'
    def change
      rename_column :password_join_authorizations, :security_question_id, :security_questions_id
    end
  end
end
