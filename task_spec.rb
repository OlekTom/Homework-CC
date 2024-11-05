require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'task.rb'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(report_path: "test_results_spec.html")

describe Student do
    before do
        @student = Student.new("Сергієнко", "Сергій", Date.new(2002, 2, 2))
    end

    it "ініціалізує студента з правильними даними" do
        _(@student.surname).must_equal "Сергієнко"
        _(@student.name).must_equal "Сергій"
        _(@student.date_of_birth).must_equal Date.new(2002, 2, 2)
    end

    it "обчислює вік студента" do
        age = @student.calculate_age
        expected_age = Date.today.year - 2002
        expected_age -= 1 if Date.today < Date.new(Date.today.year, 2, 2)
        _(age).must_equal expected_age
    end

    it "піднімає помилку для некоректної дати народження" do
        _(proc { Student.new("Некоректний", "Дата", Date.today + 1) }).must_raise ArgumentError
    end

    it "додає студента до списку" do
        student_count = Student.students.size
        new_student = Student.new("Новицький", "Олег", Date.new(1995, 3, 3))
        _(Student.students.size).must_equal student_count + 1
        _(Student.students).must_include new_student
    end

    it "видаляє студента зі списку" do
        Student.remove_student(@student)
        _(Student.students).wont_include @student
    end

    it "знаходить студентів за ім'ям" do
        results = Student.get_students_by_name("Сергій")
        _(results).must_include @student
    end

    it "знаходить студентів за віком" do
        age = @student.calculate_age
        results = Student.get_students_by_age(age)
        _(results).must_include @student
    end
end
