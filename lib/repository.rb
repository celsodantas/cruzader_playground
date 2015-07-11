module Repository
  @@counter = 0
  @@elements = []

  def elements
    @@elements
  end

  def clear
    @@counter = 0
    @@elements.clear
  end

  def save(element)
    @@counter += 1
    element.id = @@counter if element.respond_to? :id

    @@elements << element
  end

  def where(params)
    @@elements.select do |element|
      params.each.select do |node|
        key = node[0]
        value = node[1]

        element.public_send(key) == value
      end.any?
    end
  end
end
