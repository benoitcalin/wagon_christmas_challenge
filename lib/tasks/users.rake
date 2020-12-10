namespace :users do
  desc "update user score"
    task update: :environment do
      UsersController.update_score
    end
end
