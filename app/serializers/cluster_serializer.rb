class ClusterSerializer < ActiveModel::Serializer
    attributes :id
    
    has_one :presentation
    has_one :question
end