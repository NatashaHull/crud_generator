require 'rspec'
require 'crud_generator'

describe CRUDGenerator do
  context "Controller variables" do
    before(:each) do
      class ParentsController
        extend CRUDGenerator
        
        def self.root_url
          "localhost:3000"
        end
      end

      class ChildrenController < ParentsController
      end
    end

    it "has the right instance name" do
      name1 = ParentsController.instance_name
      name2 = ChildrenController.instance_name

      name1.should == "parent"
      name2.should == "child"
    end

    it "has the right model class" do
      Parent = Struct.new(:name)
      Child = Struct.new(:name)
      model1 = ParentsController.model_class
      model2 = ChildrenController.model_class

      model1.should == (Parent)
      model2.should == (Child)
    end

    it "has the right index_url" do
      index1 = ParentsController.index_url
      index2 = ChildrenController.index_url

      index1.should == "localhost:3000/parents"
      index2.should == "localhost:3000/children"
    end
  end

  context "Controller actions" do
    before(:each) do
      class ParentsController
        extend CRUDGenerator
        include CRUDGenerator
      end
    end
    
    it "creates all crud methods automatically" do
      class ChildrenController
        generate_crud_actions
      end
      child1 = ChildrenController.new

      child1.methods.should include(:index)
      child1.methods.should include(:show)
      child1.methods.should include(:new)
      child1.methods.should include(:create)
      child1.methods.should include(:edit)
      child1.methods.should include(:update)
      child1.methods.should include(:destroy)
    end

    it "add all and only specified crud methods (when specified)" do
      class MoreChildrenController < ParentsController
        generate_crud_actions :index, :show
      end
      child2 = MoreChildrenController.new

      child2.methods.should include(:index)
      child2.methods.should include(:show)
      child2.methods.should_not include(:new)
      child2.methods.should_not include(:create)
      child2.methods.should_not include(:edit)
      child2.methods.should_not include(:update)
      child2.methods.should_not include(:destroy)
    end

    it "only creates included crud methods" do
      class EvenMoreChildrenController < ParentsController
        generate_crud_actions :only => [:index, :show]
      end
      child3 = EvenMoreChildrenController.new

      child3.methods.should include(:index)
      child3.methods.should include(:show)
      child3.methods.should_not include(:new)
      child3.methods.should_not include(:create)
      child3.methods.should_not include(:edit)
      child3.methods.should_not include(:update)
      child3.methods.should_not include(:destroy)
    end

    it "creates all crud methods except ones that are excluded" do
      class LastChildrenController < ParentsController
        generate_crud_actions :except => [:index, :show]
      end
      child4 = LastChildrenController.new

      child4.methods.should_not include(:index)
      child4.methods.should_not include(:show)
      child4.methods.should include(:new)
      child4.methods.should include(:create)
      child4.methods.should include(:edit)
      child4.methods.should include(:update)
      child4.methods.should include(:destroy)
    end
  end
end