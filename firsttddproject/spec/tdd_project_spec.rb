require 'rspec'
require 'tdd_projects'

describe "#my_uniq" do
    it "takes an array as an argument" do
        expect { my_uniq([1, 2, 1, 3, 3]) }.to_not raise_error
    end

    it "requires an array as an agument" do
        expect { my_uniq() }.to raise_error(ArgumentError)
        expect { my_uniq("onetwothree") }.to raise_error(TypeError)
    end

    it "returns the unique elements of an array" do
        expect(my_uniq([1, 2, 1, 3, 3])).to eq([1, 2, 3])
    end
end

describe "Array#two_sum" do
    it "gets called on an array" do
        expect { [-1, 0, 2, -2, 1].two_sum }.to_not raise_error
        expect { "onetwothree".two_sum }.to raise_error(NoMethodError)
    end

    it "finds pairs of positions where the elements sum to zero" do
        expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
end

describe "#my_transpose" do
    it "takes an array as an argument" do
        expect { my_transpose([
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]) }.to_not raise_error
    end

    it "requires an array as an agument" do
        expect { my_transpose() }.to raise_error(ArgumentError)

        expect { my_transpose(123456987) }.to raise_error(TypeError)
    end
end