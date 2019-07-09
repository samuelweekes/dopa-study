class StudyController < ApplicationController
  skip_before_action :verify_authenticity_token 

  def index
    @studySessions = Study.monthSessions
    myUser = User.find(1)
    myAccount = myUser.account
    @balance = myAccount.balance
  end

  def create
     time = params[:time]
     #Get user account
     myUser = User.find(1)
     myAccount = myUser.account

     maxBalance = myAccount.maxBalance
     bonus = generateBonus(time.seconds)
     reward = generateReward(maxBalance, bonus)

     if(isNumber?(time.seconds))
       #Generate reward and save
       study = Study.new
       study.time = time.seconds
       study.reward = generateReward(maxBalance, bonus)
       study.save
  
       #Save new account balance after reward
       myAccount.balance -= study.reward  
       myAccount.save 

       render json: {time: study.time, 
                     reward: study.reward,
                     date: study.created_at,
                     balance: myAccount.balance
                     }
     end
  end

  def generateBonus(time)
    bonus = 1
    #60Mins
    if time > 3600 
      bonus = rand(1..3)
    end
    #90Mins
    if time > 5400 
      bonus = rand(1..4)
    end
    #120Mins
    if time > 7200 
      bonus = rand(1..6)
    end
    return bonus
  end

  def generateReward(balance, bonus=false)
    if balance <= 0
      return false
    end

    monthSessions = Study.monthSessions

    consistencyBonus = ((monthSessions.count)/4).floor;

    max = (balance/5).floor
    min = (balance/35).floor 
    reward = rand(min..max).floor
    percentOfBalance = ((reward*100)/balance).ceil.to_f

    random = rand(1..100)
    rewardModifier = ((2/percentOfBalance)*100).ceil

    if bonus 
      reward = reward * bonus;
    end 

    if random < rewardModifier + consistencyBonus
      return reward
    end

    return 0;
  end

  def isNumber? string
    true if Float(string) rescue false
  end
end
