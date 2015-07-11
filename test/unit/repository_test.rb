require "test_helper"

describe Repository do
  class Repo
    extend Repository
  end

  def setup
    Repo.clear
  end

  it "should any elements" do
    Repo.save(5)
    Repo.save("a")

    assert_equal [5, "a"], Repo.elements
  end

  it "should find element by its public methods" do
    Repo.save(5)
    Repo.save(10)
    Repo.save(55)

    result = Repo.where(inspect: "5")

    assert_equal 1, result.size
    assert_equal 5, result[0]
  end

  it "should find multiple elements by its public methods" do
    Repo.save(5)
    Repo.save(10)
    Repo.save("55")

    result = Repo.where(class: Fixnum)

    assert_equal 2, result.size
    assert_equal 5, result[0]
    assert_equal 10, result[1]
  end

end
