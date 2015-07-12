require "test_helper"

describe Actor do
  def setup
  end

  describe "marriage" do

    def setup
      @actor = Actor.new(params:{age: MarriageHelper::MINIMUM_MARRY_AGE, sex: ActorSex.new(:male)})
      ActorRepository.save(@actor)
    end

    it "should decide to marry someone if he is single and marriable" do
      context = Context.new(actor_repository: ActorRepository)

      suggested_spouse = Actor.new
      ActorRepository.save(suggested_spouse)

      MarriageHelper.expects(:find_partner_for).with(@actor, context).returns(suggested_spouse)

      decisions = @actor.make_decisions(context)

      assert_equal 1, decisions.size
      assert_equal [@actor.id, :marry_to, suggested_spouse.id], decisions[0]
    end

    it "should not decide to marry if under minimum marry age" do
      @actor.age = MarriageHelper::MINIMUM_MARRY_AGE-1
      ActorRepository.save(@actor)

      context = Context.new(actor_repository: ActorRepository)
      decisions = @actor.make_decisions(context)

      assert_equal 0, decisions.size
    end

    it "should accept marriage if it is not married and requirements meets" do

    end
  end


end
