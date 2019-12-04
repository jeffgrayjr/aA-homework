def my_uniq(arr)
    raise TypeError unless arr.is_a?(Array)
    unique_arr = []
    arr.each { |ele| unique_arr << ele if !unique_arr.include?(ele)}
    return unique_arr
end 

class Array
    def two_sum
        return_arr = []
        self.each_with_index do |ele, idx|
            (idx + 1...self.length).each { |idx2| return_arr << [idx, idx2] if self[idx] + self[idx2] == 0}  
        end
        return return_arr
    end
end

def my_transpose(arr)
    raise TypeError unless arr.is_a?(Array)
    return_arr = []
    arr.length.times { return_arr << [] }
    (0...arr.length).each do |idx|
        arr.each { |row| return_arr[idx] << row[idx]} 
    end
    return return_arr
end