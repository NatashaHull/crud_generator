require 'rspec'
require 'crud_generator'

describe CRUDGenerator do
  context "Controller variables" do
    it "has the right instance name"
    it "has the right model class"
    it "has the right index_url"
  end

  context "Controller actions" do
    it "creates all crud methods automatically"
    it "add all and only specified crud methods (when specified)"
    it "only creates included crud methods"
    it "creates all crud methods except ones that are excluded"
  end
end