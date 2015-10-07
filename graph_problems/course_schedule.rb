require 'byebug'
require 'set'
def can_finish(num_courses = 0, prerequisites = [])
  prereq_array = calculate_prerequisites(num_courses, prerequisites)
  prereq_proc = Proc.new {| num | prereq_array[num] }
  !CycleFinder.new((0...num_courses), prereq_proc).has_cycle?
end

def calculate_prerequisites(num_courses, prerequisites)
  prerequisites.uniq!
  prerequisites.sort_by! { |a, b| a }
  prereq_array = Array.new(num_courses) { Set.new }
  current_index = 0
  num_courses.times do |course_num|
    while current_index < prerequisites.length &&
          prerequisites[current_index][0] == course_num
      prereq_array[course_num] << prerequisites[current_index][1]
      current_index += 1
    end
  end
  prereq_array
end


def update_course_prereqs(array, num1, num2)
  array[num1] = Set.new unless array[num1]
  array[num1] << num2
  array[num1] = array[num1].union(array[num2]) if array[num2]
end

class CycleFinder
  def initialize(nodes, calculate_children_proc)
    @nodes = nodes
    @calculate_children = calculate_children_proc
  end

  def calculate_children(node)
    @calculate_children.call(node)
  end

  def has_cycle?
    visited = Set.new
    call_stack = InclusionStack.new
    recur = find_cycle_from_node(visited, call_stack)
    @nodes.each do |node|
      if !visited.include?(node)
        call_stack << node
        return true if recur.call(node)
        visited << node
      end
    end
    false
  end

  def find_cycle_from_node(visited, call_stack)
    cycle_lambda = lambda do |start_node|
      calculate_children(start_node).each do |child|
        # debugger
        if call_stack.include?(child)
          return true
        elsif !visited.include?(child)
          call_stack << child
          return true if cycle_lambda.call(child)
          visited << child
          call_stack.pop
        end
      end
      false
    end
    cycle_lambda
  end

end

class InclusionStack < Array
  #should be used only for stack purposes.
  def initialize(*args)
    @included = Hash.new {0}
    super(args)
  end

  def push(val)
    @included[val] += 1
    super(val)
  end

  def <<(val)
    push(val)
  end

  def pop
    @included[super] -= 1
  end

  def include?(val)
    @included[val] > 0
  end
end

puts can_finish(2, [[1, 0], [0, 1]])
