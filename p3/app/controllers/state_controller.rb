class StateController < ApplicationController
  def filter
    @state_list = []
    @substring = ''
    if params.key?(:substring)
      @substring = params[:substring]
      @state_list = State.filter(@substring) 
    end
  end
end
