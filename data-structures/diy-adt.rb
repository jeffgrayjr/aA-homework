#require pry

class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack.push(el)
    end

    def pop
        @stack.pop
    end

    def peek
        @stack[-1]
    end
end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue.push(el)
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue[0]
    end
end

class Map
    def initialize
        @map = []
    end

    def set(key, value)
       if !self.get(key)
        @map.push([key, value])
       else
        @map[find_idx(key)][1] = value
       end
    end

    def get(key)
        @map.find {|kv_pair| kv_pair[0] == key}
    end

    def delete(key)
        @map.delete_at(self.find_idx(key)) if self.get(key)
    end

    def show
        @map.each do |kv_pair|
            print kv_pair[0]
            print kv_pair[1]
        end
    end

    def find_idx(key)
        @map.each_with_index do |kv_pair, idx|
            return idx if kv_pair[0] == key
        end
    end
end

#test_stack = Stack.new