class Context

  def initialize(actor_repository: nil)
    @actor_repository = actor_repository
  end

  def find_actor(params = {})
    @actor_repository.where(params)
  end
end
