class Doc
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  field :category_id, type: Integer
end
