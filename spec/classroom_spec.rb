require 'rspec'
require_relative '../lib/classroom'

describe Classroom do
  context 'Classroom with one teacher and ten students' do
    let(:teacher) { Teacher.new }
    let(:students) { [Students.new] * 10 }
    let(:classroom) { Classroom.new(teacher, students) }

    it 'has 10 students' do
      expect(classroom.students.size).to eq(10)
    end

    it 'has one teacher' do
      expect(classroom.teacher).to be_instance_of(Teacher)
    end
  end

  describe 'Apple' do
    it 'has colors' do
      expect(Apple::COLORS.keys).to match_array([:green, :red])
    end

    it 'could be green' do
      green_apple = Apple.new(:green)
      expect(green_apple.color).to eq(:green)
    end

    it 'could be red' do
      red_apple = Apple.new(:red)
      expect(red_apple.color).to eq(:red)
    end

    it 'couldn`t be random color' do
      expect{Apple.new(:some_random_id)}.to raise_error
    end
  end

  describe 'Teacher' do
    let(:teacher) { Teacher.new }

    it 'likes green apples' do
      decision = teacher.likes? Apple.new(:green)
      expect(decision).to be true
    end
    it 'hates red apples' do
      decision = teacher.likes? Apple.new(:red)
      expect(decision).to be false
    end
  end

  describe 'Student' do
    let (:student) { Student.new }

    it 'could have an one apple' do
      student.get_next_random_apple
      expect(student.apple).to be_instance_of(Apple)
    end

    it 'could give an apple to the Teacher' do
      teacher  = Teacher.new
      student.get_next_random_apple
      expect{ student.give_apple_to teacher }.to change{ teacher.has_apples? }.from(false).to(true)
    end
    it 'thanked by the Teacher when the *green* Apple was gifted'
    it 'haven`t thanked by the Teacher when the *red* Apple was gifted'
  end

  context 'Student gives an apple to the Teacher' do
    let (:student) { Student.new }
    let (:teacher) { Teacher.new }

    context 'Teacher has eaten an apple' do
      it 'should say "Thank You" if apple was green' do
        student.get_new_apple Apple.new(:green)
        student.give_apple_to teacher
        teacher.eat_last_apple # could be parallel if eat_apple_from_student(student))
        thank_you_message = "Thank You #{student.name}!"
        expect{ teacher.eat_apple }.to output(thank_you_message).to_stdout
      end

      it 'should track how many apples left' do
        student.get_next_random_apple
        student.give_apple_to teacher
        student.get_next_random_apple
        student.give_apple_to teacher
        expect{ teacher.eat_apple }.to change { teacher.apples_count }.from(2).to(1)
      end

      it 'should destroy apple core' do
        student.get_next_random_apple
        student.give_apple_to teacher
        apple = teacher.last_apple
        teacher.eat_last_apple
        expect{ teacher.eat_apple }.to change { apple.thrown? }.from(false).to(true)
      end
    end

    it 'will gift different Apple each time'
    it 'can give their apple to the teacher at any time'
  end

  context 'Teacher receives an apple from his student' do

  end

  it 'should be a Class' do
    expect(described_class.is_a? Class).to eq true
  end


end