require 'active_support/inflector'

module CRUDGenerator
  def generate_crud_actions(*args)
    actions = [:index, :show, :new, :create, :edit, :update, :destroy]

    #Allows user input to set the methods one of two ways
    if args.length == 1 && args[0].is_a?(Hash)
      actions = args[0].values.flatten if args[0].keys.first == :only
      actions -= args[0].values.flatten if args[0].keys.first == :except
    elsif !args.empty?
      actions = args
    end

    actions.each do |action|
      send("define_#{action}")
    end
  end

  def define_index
    define_method(:index) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name.pluralize}",
        model_class.all
        )
    end
  end

  def define_show
    define_method(:show) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name}",
        model_class.find(params[:id])
        )
    end
  end

  def define_new
    define_method(:new) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name}",
        model_class.new
        )
    end
  end

  def define_edit
    define_method(:edit) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name}",
        model_class.find(params[:id])
        )
    end
  end

  def define_create
    define_method(:create) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name}",
        model_class.new(params[instance_name.to_sym])
        )

      obj = instance_variable_get("@#{instance_name}")

      if obj.save
        redirect_to obj
      else
        flash.now[:errors] = obj.errors.full_messages
        render :new
      end
    end
  end

  def define_update
    define_method(:update) do
      instance_name = self.class.instance_name
      model_class = self.class.model_class
      instance_variable_set(
        "@#{instance_name}",
        model_class.find(params[:id])
        )

      obj = instance_variable_get("@#{instance_name}")

      if obj.update_attributes(params[instance_name.to_sym])
        redirect_to obj
      else
        flash.now[:errors] = obj.errors.full_messages
        render :edit
      end
    end
  end

  def define_destroy
    define_method(:destroy) do
      index_url = self.class.index_url
      model_class = self.class.model_class
      obj = model_class.find(params[:id])

      obj.destroy
      redirect_to index_url
    end
  end

  def instance_name
    self.to_s.underscore[0..-12].singularize
  end

  def model_class
    instance_name.camelize.constantize
  end

  def index_url
    url = root_url
    url += "/#{instance_name.pluralize}"
  end
end