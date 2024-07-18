# longleaf_lending
Setup Instructions
  Prerequisites
    Ruby 2.7.7
    Rails 6
    Sidekiq 
    PostgreSQL 

Installation
  1.Clone the repository:
    git clone https://github.com/waleed988/longleaf_lending.git
    cd longleaf_lending

  2.Install dependencies:
    bundle install

  3.Set up the database:
    rails db:create
    rails db:migrate

  4.Run Sidekiq For Background Jobs Processing
    bundle exec sidekiq

Running the Application
  Start the Rails server:
    rails s
Access the application at http://localhost:3000