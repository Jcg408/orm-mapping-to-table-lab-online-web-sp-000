class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table 
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade REAL
        )
        SQL
        
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create (attributes)
   
    attributes.each {|key, value|self.send(("#{key}"), value)}
    
    
    self.save
    self

  end
 
 
 
end
