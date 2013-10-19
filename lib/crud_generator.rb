require 'active_support/inflector'

module CRUDGenerator
  def generate_crud_actions(*args)
    actions = [:index, :show, :new, :create, :edit, :update, :destroy]

    actions.each do |action|
      send("define_#{action}")
    end
  end

  def define_index
    define_method(:index) do
      instance_variable_set(
        "@#{instance_name.pluralize}",
        model_class.all
        )
    end
  end

  def define_show
    define_method(:show) do
      instance_variable_set(
        "@#{instance_name}",
        model_class.find(params[:id])
        )
    end
  end

  def define_new
    define_method(:new) do
      instance_variable_set(
        "@#{instance_name}",
        model_class.new
        )
    end
  end

  def define_edit
    define_method(:edit) do
      instance_variable_set(
        "@#{instance_name}",
        model_class.find(params[:id])
        )
    end
  end

  def define_create
    define_method(:create) do
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