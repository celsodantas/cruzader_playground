module Repository
  @@counter = 0
  @@elements = {}

  def elements
    @@elements
  end

  def clear
    @@counter = 0
    @@elements.clear
  end

  def save(element)
    @@counter += 1

    if element.id.nil?
      element.id = @@counter
      @@elements[element.id] = element
    else
      @@elements[element.id]
    end
  end

  def where(params)
    results = @@elements.select do |id, element|
      params.each.select do |param_node|
        key = param_node[0]
        value = param_node[1]

        element.public_send(key) == value
      end.any?
    end

    results.values
  end
end
