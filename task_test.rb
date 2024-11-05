require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'task.rb'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(report_path: "test_results_unit.html")

class StudentTest < Minitest::Test
    def setup
        @student1 = Student.new("Іванов", "Іван", Date.new(2000, 1, 1))
    end

    def test_initialize
        assert_equal "Іванов", @student1.surname
        assert_equal "Іван", @student1.name
        assert_equal Date.new(2000, 1, 1), @student1.date_of_birth
    end

    def test_calculate_age
        age = @student1.calculate_age
        expected_age = Date.today.year - 2000
        expected_age -= 1 if Date.today < Date.new(Date.today.year, 1, 1)
        assert_equal expected_age, age
    end

    def test_invalid_date_of_birth
        assert_raises(ArgumentError) { Student.new("Петров", "Петро", Date.today + 1) }
    end

    def test_add_student
        students_count = Student.students.size
        new_student = Student.new("Сидоров", "Сидір", Date.new(1998, 6, 15))
        assert_equal students_count + 1, Student.students.size
        assert_includes Student.students, new_student
    end

    def test_remove_student
        Student.remove_student(@student1)
        refute_includes Student.students, @student1
    end

    def test_get_students_by_name
        results = Student.get_students_by_name("Іван")
        assert_includes results, @student1
    end

    def test_get_students_by_age
        age = @student1.calculate_age
        results = Student.get_students_by_age(age)
        assert_includes results, @student1
    end
end
