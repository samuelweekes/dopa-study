class UserController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create 
    #@user = User.new
    #@user.name = 'Samuel Weekes'
    #@user.email = 'samueljweekes@gmail.com'
    #@user.save
    #@account = Account.new
    #@account.user_id = 1
    #@account.balance = 0
    #@account.save
    #@user = User.find(1)
    #@account = @user.account
    #@account.balance = 10
    #@account.save 
  end

  def resetBalance 
     myUser = User.find(1)
     myAccount = myUser.account
     myAccount.balance = 0
     myAccount.maxBalance = 0
     myAccount.save
     render json: {balance: myAccount.balance}
  end 

  def addFunds
    funds = params[:funds]
    myUser = User.find(1)
    myAccount = myUser.account

    currentBalance = myAccount.balance
    myAccount.balance = currentBalance + funds.to_i
    
    if myAccount.balance > myAccount.maxBalance
       myAccount.maxBalance = myAccount.balance
    end

    myAccount.save
    render json: {balance: myAccount.balance}
  end
end
