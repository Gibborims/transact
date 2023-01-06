module Utils

  def self.errors(model)
    errors = []
    keys = []
    model.errors.each do |error|
      key = error.attribute
      value = error.message
      errors << { property: key.to_s.camelize(:lower), description: value } if !keys.include?(key)
      keys << key
    end
    errors
  end
end
