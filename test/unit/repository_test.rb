require "test_helper"
require 'ostruct'

describe Repository do
  class Repo
    extend Repository
  end

  def setup
    Repo.clear
  end

  it "should save any elements" do
    element_5 = OpenStruct.new(id: nil, value: 5)
    Repo.save element_5

    element_a = OpenStruct.new(id: nil, value: "a")
    Repo.save element_a

     assert_equal element_5, Repo.where(value: 5).first
     assert_equal element_a, Repo.where(value: "a").first
  end

  it "should find element by its public methods" do
    Repo.save OpenStruct.new(id: nil, value: 5)
    Repo.save OpenStruct.new(id: nil, value: 10)
    Repo.save OpenStruct.new(id: nil, value: 55)

    result = Repo.where(value: 5)

    assert_equal 1, result.size
    assert_equal 5, result[0].value
  end

  it "should find multiple elements by its public methods" do
    Repo.save OpenStruct.new(id: nil, value: 5)
    Repo.save OpenStruct.new(id: nil, value: 5)
    Repo.save OpenStruct.new(id: nil, value: "55")

    result = Repo.where(value: 5)

    assert_equal 2, result.size
    assert_equal 5, result[0].value
    assert_equal 5, result[1].value
    assert result[0].id != result[1].id
  end

  it "should update existing saved element" do
    @object = OpenStruct.new(id: nil, value: 10)

    Repo.save(@object)
    assert object_id = @object.id

    result = Repo.where(id: object_id)
    assert_equal 1, result.size
    assert_equal 10, result[0].value

    @object.value = 22
    Repo.save(@object)
    assert_equal object_id, @object.id

    result = Repo.where(id: object_id)
    assert_equal 1, result.size
    assert_equal 22, result[0].value
  end

end
