require 'user_account'
class UserAccountRepository
    def all
        sql ='SELECT id, username, email FROM user_accounts;'
        result_set = DatabaseConnection.exec_params(sql, [])

        user_accounts = []

        result_set.each do |record|
            user_account = UserAccount.new
            user_account.id = record['id']
            user_account.username = record['username']
            user_account.email = record['email']

            user_accounts << user_account
        end
        return user_accounts
    end

    def find(id)
        sql = 'SELECT id, username, email FROM user_accounts WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])

        record = result_set[0]


        user_account = UserAccount.new
        user_account.id = record['id']
        user_account.username = record['username']
        user_account.email = record['email']

      
        return user_account


    end

    def create (useraccount)
        sql = 'INSERT INTO user_accounts (username, email) VALUES($1, $2);'
        DatabaseConnection.exec_params(sql, [useraccount.username, useraccount.email])

    end

    def delete(id)
       
        sql = 'DELETE FROM user_accounts WHERE id = $1;'
        DatabaseConnection.exec_params(sql, [id])
    end
end