# Installation

Run `gem install crud_generator`.

#Setup

Note: This gem is designed for Rails so only Rails setup instructions are provided, though it could work with any MVC framework.

Once you have created your rails app add the following to your Gemfile

```
gem 'crud_generator', '~>0.0'
```

Once you have run `bundle install` you can use this gem by adding the following to your ApplicationController

```
extend CRUDGenerator
```

#Use

This gem allows you to create all and only the standard CRUD actions you want in any controller.  If you want to generate all of the standard CRUD actions, you can simply type in the following:


```
generate_crud_actions
```

However, if you only want some of the standard CRUD actions, such as `index`, `new` and `create`, you can specify which actions you want in one of the following ways:

First, you can simply type in the CRUD actions you want.
```
generate_crud_actions :index, :new, :create
```

Second, you can specify that you only want `index` and `show`.
```
generate_crud_actions :only => [:index, :new, :create]
```

Third, you can specify that you want everything except `show`, `edit`, `update`, and `delete` (i.e. `index`, `new`, and `create`).
```
generate_crud_actions :except => [:show, :edit, :update, :delete]
```

If you choose to specify which CRUD actions you want, none of the other methods will be created and you can simply create them yourself however you want.

#Generated code

All of the above explains how to use this gem, but does not show what the gem actually does. Suppose that you are creating a basic posts resource for you application and that you want to have `index` and `show` pages, in addition to giving your users the ability to `create`, `update` and `destroy` posts (using the related `new` and `edit` views). You can simply type in `generate_crud_actions` into your PostsController and the following controller actions will be created for you:

The `index` action:
```
def index
  @posts = Post.all
end
```

The `show` action:
```
def show
  @post = Post.find(params[:id])
end
```

The `new` action:
```
def new
  @post = Post.new
end
```

The `create` action:
```
def create
  @post = Post.new(params[:post])
  
  if @post.save
    redirect_to @post
  else
    flash.now[:errors] = @user.errors.full_messages
    render :new
  end
end
```

The `edit` action:
```
def edit
  @post = Post.find(params[:id])
end
```

The `update` action:
```
def update
  @post = Post.find(params[:id])
  
  if @post.update_attributes(params[:post])
    redirect_to @post
  else
    flash.now[:errors] = @post.errors.full_messages
    render :new
  end
end
```

The `destroy` action:
```
def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_url
end
```

Creating every CRUD action would work if you want all of the code above. However, if you would prefer to make the `create` action more specific, like giving it the ability to make the author of the post the current user, then you should probably specify that you want every CRUD action above except `create` and make your own `create` action as needed (if you need an example of how to do this, look at the previous section).

#Note on Incorrect Usage

The code is generated based on your controller name and the assumption that there is an associated model and set of routes. This means that you should never create any of these actions if there is no associated model or you do not have the routes that the generated action.
