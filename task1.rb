require 'date'

class Student
    attr_accessor :surname, :name, :date_of_birth

    @@students = []

    def initialize(surname, name, date_of_birth)
        @surname = surname
        @name = name
        self.date_of_birth = date_of_birth
        add_student
    end

    def date_of_birth=(db)
        if db > Date.today
            raise ArgumentError, "Invalid date of birth"
        end
        @date_of_birth = db
    end

    def calculate_age
        now = Date.today
        age = now.year - @date_of_birth.year
        birthday_this_year = Date.new(now.year, @date_of_birth.month, @date_of_birth.day)
        age -= 1 if now < birthday_this_year
        age
    end

    def add_student
        unless @@students.any? { |student| student == self }
            @@students << self
            puts "#{self} додано до списку."
        else
            puts "#{self} вже існує в списку!"
        end
    end

    def self.remove_student(student)
        @@students.delete(student)
    end

    def self.get_students_by_age(age)
        @@students.select { |student| student.calculate_age == age }
    end

    def self.get_students_by_name(name)
        @@students.select { |student| student.name.strip.downcase == name.strip.downcase }
    end

    def ==(other)
        other.is_a?(Student) && surname == other.surname && name == other.name && date_of_birth == other.date_of_birth
    end

    def to_s
        "#{surname}, #{name}, #{date_of_birth}"
    end

    def self.students
        @@students
    end
end

begin
    student1 = Student.new("Пліщенко", "Владислав", Date.new(2001, 3, 1))
    student2 = Student.new("Петров", "Петро", Date.new(1999, 8, 20))
    student3 = Student.new("Романенко", "Іван", Date.new(2000, 5, 15))
    student4 = Student.new("Коваленко", "Максим", Date.new(2005, 11, 24))
    student5 = Student.new("Дегтярьов", "Юрій", Date.new(2004, 7, 10))
    student6 = Student.new("Кононенко", "Олександр", Date.new(2000, 1, 30))
    puts"\n"

    # тест на дублікат
    puts"Спробуємо додати до списку дублікат студента:"
    student_duplicate = Student.new("Романенко", "Іван", Date.new(2000, 5, 15)) # Не буде додано
    puts"\n"

    # вивід студентів
    puts "Список студентів:"
    Student.students.each { |student| puts student }
    puts "\n"

    # видалення студента
    puts "Для прикладу, видалемо студента з іменем 'Петро'"
    Student.remove_student(student2)
    puts "Оновлений список після видалення обраного студенту:"
    Student.students.each { |student| puts student }
    puts "\n"

    # за віком
    age = 24
    puts "Студент(и) віком #{age} років:"
    students_with_age = Student.get_students_by_age(age)
    if students_with_age.empty?
        puts "Немає студентів яким '#{age}' років"
    else
        students_with_age.each { |student| puts student }
    end
    puts "\n"

    # за ім'ям 
    name = "Юрій"
    puts "Студент(и) з ім'ям '#{name}':"
    students_with_name = Student.get_students_by_name(name)
    if students_with_name.empty?
        puts "Немає студентів з ім'ям '#{name}'"
    else
        students_with_name.each { |student| puts student }
    end

     
    rescue ArgumentError => e
        puts "Помилка: #{e.message}"
end
