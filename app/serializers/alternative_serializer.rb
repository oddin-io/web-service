class AlternativeSerializer < ActiveModel::Serializer
  attributes :id, :description, :choice_count

  def choice_count
    object.choices.count
  end
end
