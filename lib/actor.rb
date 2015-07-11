class Actor
  attr_accessor :id, :age, :partner, :sex

  def initialize(params = {})
    self.age = params[:age]
    self.partner = params[:partner]
    self.sex = params[:sex]
  end

  def make_decisions(context)
    @decisions = []

    if MarriageHelper.needs_marriage?(self)
      partner = MarriageHelper.find_partner_for(self, context)
      @decisions << [self.id, :marry_to, partner.id]
    end

    @decisions
  end

  def needs_marriage
  end
end

class Actor::Builder

  def initialize(params = {})
    @actor = Actor.new(params)
  end

  def build
    @actor
  end
end

class MarriageHelper
  MINIMUM_MARRY_AGE = 16

  def self.needs_marriage?(who)
    who.age >= MINIMUM_MARRY_AGE && who.partner.nil?
  end

  def self.find_partner_for(who, context)
    sex = who.sex
    context.find_actor(sex: sex.oposite, partner: nil, age: {gt: MINIMUM_MARRY_AGE}).first
  end
end

class ActorSex
  attr_accessor :value

  def initialize(value)
    self.value = value
  end

  def oposite
    if value == :male
      :female
    else
      :male
    end
  end
end

class ActorRepository
  def where(params = {})
    [Actor.new]
  end
end

