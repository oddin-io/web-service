# == Schema Information
#
# Table name: lectures
#
#  id       :integer          not null, primary key
#  code     :string(30)       not null
#  name     :string(100)      not null
#  workload :decimal(7, 2)    default(0.0), not null
#

class LectureSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :workload
end
