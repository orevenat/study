module Inatra
  class << self
    def routes(&block)
      @routes ||= {}
      instance_eval(&block)
    end

    def call(env)
      path = env['PATH_INFO']
      req_method = env['REQUEST_METHOD'].downcase.to_sym
      return [404, {}, ['']] if @routes[req_method][path].nil?
      @routes[req_method][path].call
    end

    def get(path, &block)
      @routes[:get] ||= {}
      @routes[:get][path] = block
    end
  end
end
