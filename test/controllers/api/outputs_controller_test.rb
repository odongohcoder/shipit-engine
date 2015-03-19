require 'test_helper'

class Api::OutputsControllerTest < ActionController::TestCase
  setup do
    @stack = stacks(:shipit)
    authenticate!
  end

  test "#show returns the task output as plain text" do
    task = @stack.tasks.last

    get :show, stack_id: @stack.to_param, task_id: task.id
    assert_response :ok
    assert_equal 'text/plain', response.content_type
    assert_equal task.chunk_output, response.body
  end
end