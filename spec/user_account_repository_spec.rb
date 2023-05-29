require 'user_account_repository'
def reset_user_accounts_table
    seed_sql = File.read('spec/seeds_socialnetwork.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  describe UserAccountRepository do
    before(:each) do 
      reset_user_accounts_table
    end

    it "returns all user accounts" do
        repo = UserAccountRepository.new

        users = repo.all
    
        expect(users.length).to eq 2
    
        expect(users[0].id).to eq '1'
        expect(users[0].username).to eq 'joebloggs99'
        expect(users[0].email).to eq 'joebloggs99@hotmail.com'
    end

    it "returns a single user account" do
        repo = UserAccountRepository.new
        user = repo.find(1)
        expect(user.id).to eq '1'
        expect(user.username).to eq 'joebloggs99'
        expect(user.email).to eq 'joebloggs99@hotmail.com'
    end

    it "creates a new user account" do

        repo = UserAccountRepository.new
        new_user = UserAccount.new
        new_user.username ='jessbealey88'
        new_user.email = 'jessbealey88@yahoo.com'
        repo.create(new_user)
        expect(repo.all).to include(
        have_attributes(
        username: new_user.username,
        email: new_user.email))
    end

    xit "deletes a user" do
      repo = UserAccountRepository.new
      repo.delete(1)
      user = repo.find(1)
      expect(user.length).to eq 0
    end

  end