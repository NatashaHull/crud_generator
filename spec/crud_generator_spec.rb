require 'rspec'
require 'crud_generator'

describe CRUDGenerator do
  context "Controller variables" do
    before(:each) do
      class ParentsController
        include CRUDGenerator
        
        def root_url
          "localhost:3000"
        end
      end

      class ChildrenController < ParentsController
      end
    end

    it "has the right instance name" do
      name1 = ParentsController.new.instance_name
      name2 = ChildrenController.new.instance_name

      name1.should == "parent"
      name2.should == "child"
    end

    it "has the right model class" do
      Parent = Struct.new(:name)
      Child = Struct.new(:name)
      model1 = ParentsController.new.model_class
      model2 = ChildrenController.new.model_class

      model1.should == (Parent)
      model2.should == (Child)
    end

    it "has the right index_url" do
      index1 = ParentsController.new.index_url
      index2 = ChildrenController.new.index_url

      index1.should == "localhost:3000/parents"
      index2.should == "localhost:3000/children"
    end
  end

  context "Controller actions" do
    before(:each) do
      class ParentsController
        extend CRUDGenerator
      end
    end

    let(:child_controller) { ChildrenController.new }
    
    it "creates all crud methods automatically" do
      class ChildrenController
        generate_crud_actions
      end

      child_controller.methods.should include(:index)
      child_controller.methods.should include(:show)
      child_controller.methods.should include(:new)
      child_controller.methods.should include(:create)
      child_controller.methods.should include(:edit)
      child_controller.methods.should include(:update)
      child_controller.methods.should include(:destroy)
    end

    it "add all and only specified crud methods (when specified)"
    it "only creates included crud methods"
    it "creates all crud methods except ones that are excluded"
  end
end