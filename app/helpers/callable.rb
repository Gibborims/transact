module Callable
  def call(*args, **keyword_args, &block)
    # Capture all args and pass to the initializer.
    if keyword_args.empty?
      new(*args).call(&block)
    else
      new(*args, **keyword_args).call(&block)
    end
  end
end
