require "test_helper"

describe Actor do
  def setup
  end

  describe "marriage" do

    it "should decide to marry someone if he is single and marriable" do
      @actor = Actor::Builder.new(age: MarriageHelper::MINIMUM_MARRY_AGE, sex: ActorSex.new(:male)).build

      context = Context.new(actor_repository: ActorRepository.new)
      decisions = @actor.make_decisions(context)

      assert_equal 1, decisions.size
      assert_equal [1, :marry_to, @actor.id], decisions[0]
    end

    it "should" do
      @actor = Actor::Builder.new(age: MarriageHelper::MINIMUM_MARRY_AGE-1, sex: ActorSex.new(:male)).build

      context = Context.new(actor_repository: ActorRepository.new)
      decisions = @actor.make_decisions(context)

      assert_equal 0, decisions.size
    end

  end
end
