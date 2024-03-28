require 'date'

class Task

	# attr_accessor :id, :title, :description, :due_date, :status

	@@last_id = 0

	def initialize(title, description, due_date, status)
		@id  = @@last_id + 1
		@title = title
		@description = description
		@due_date = due_date
		@status = status

		@@last_id +=1
	end

	def id
		@id
	end

	def title
		@title
	end

	def description
		@description
	end

	def due_date
		@due_date
	end

	def status
		@status
	end

	def status=(status)
		@status = status
	end

	def due_date=(due_date)
		@due_date = due_date
	end

	def displayTaskDetails
		puts "Task id: #{id}"
		puts "Title: #{title}"
		puts "Desc: #{description}"
		puts "Due Date: #{due_date}"
		puts "Status: #{status}"
	end
end

class TaskManager

	# attr_accessor :tasks

	# def getTasks
	# 	@tasks
	# end

	def initialize
		@tasks = []
	end

	def newTask(task)
		if @tasks.any? {|i| (i.id == task.id.to_i)}
			puts "Task with this id:#{task.id} already exist. use different id:"
		else
			@tasks.push(task)
			puts "Task with ID #{task.id} added successfully."
		end
	end

	def displayTask
		if @tasks.empty?
			puts "Tasks List Empty!!!!!"
		else
			@tasks.sort_by! {|i| i.due_date}
			@tasks.each do |i|
				i.displayTaskDetails
			end
		end
	end

	def markTask(task_ID)
		if @tasks.empty?
			puts "Tasks List Empty!!!!!"
		else
			@tasks.each do |i|
				if i.id != task_ID.to_i
					puts "No Task found with id: #{task_ID}. Enter correct id:"
				else
					i.status = 'done'
					# i.setStatus("Done")
					puts "Status of #{task_ID} is set to Done"
				end
			end
		end
	end


	def updateDueDate(task_ID,update_date)
		if @tasks.empty?
			puts "Tasks List Empty!!!!!"
		else
			@tasks.each do |i|
				if i.id != task_ID.to_i
					puts "No Task found with id: #{task_ID}. Enter correct id:"
				else
					puts "Funcation called"
					i.due_date = update_date
					# i.due_date(update_date)
					puts "Date of #{task_ID} is Changed to #{update_date}"
				end
			end
		end
	end

	def deleteTask(task_ID)
		if @tasks.empty?
			puts "Tasks List Empty!!!!!"
		else
			if @tasks.reject! {|i| i.id == task_ID.to_i}
				puts "Task with id :#{task_ID} is Deleted"			
			else
				puts "No Task found with id: #{task_ID}. Enter correct id:"
			end
		end
	end
	end

# object for Taskmanager Class
taskmanager = TaskManager.new

while true
	puts "**************************************************"
	puts "***********Task  Manager  Application*************"
	puts "**************************************************"
	puts "**            1. Add a new task                 **"
	puts "**            2. Display all tasks              **"
	puts "**            3. Mark a task as complete        **"
	puts "**            4. Update Due Date                **"
	puts "**            5. Delete a task                  **"
	puts "**            0. 0 to Exit the program          **"
	puts "**************************************************"
	puts "**************************************************"
	puts "**************************************************"
	begin
		print "      Enter your choice (1-5) | 0 to EXIT: "
		choice = Integer(gets.chomp)
		if(choice == 1)
			puts "Enter your Task Details"
			# print "Enter your id:"
			# id = gets.chomp
			# while id !~ /\A\d+\z/
			# 	print "Invlaid ID. Please enter a valid id:"
			# 	id = gets.chomp
			# end
			# id = taskmanager.generatenextid

			print "Enter your Task Title:"
			title = gets.chomp.to_s
			while title.length < 1
				if(title != '/^[A-Z]{1,25}$/')
					print "Maximam length of title exceded. E
					nter your title again:"
					title = gets.chomp.to_s
				end
			end

			print "Enter Description for your Task(min 50):"
			description = gets.chomp.to_s
			while description.length < 50
				if(description != '/^[A-Z]{50,200}$/')
					print "Length of description(50-200). Enter your description again:"
					description = gets.chomp.to_s
				end
			end


			flag = true
			while flag
				begin
					print "Enter due date (YYYY-MM-DD):"
					due_date = gets.chomp.to_s
					due_date = Date.parse(due_date)
					while true
						if (due_date < Date.today)
							print "Invalid date or date is in the past. Please enter a valid date (YYYY-MM-DD):"
							due_date = gets.chomp.to_s
							due_date = Date.parse(due_date)
						else
							break
						end
					end
					flag = false
				rescue => ex
					puts ex.message
				end
			end
			
			print "Enter status of Task:"
			status = gets.chomp
			while status.length < 1 || status =~ /[^a-zA-Z]/
				print "Status not valid"
				status = gets.chomp
			end

			task = Task.new(title,description,due_date,status)
			taskmanager.newTask(task)

		elsif(choice == 2)
			taskmanager.displayTask()

		elsif(choice == 3)
			print "Enter id of task which status you want to be changed:"
			markdone = gets.chomp
			puts markdone
			taskmanager.markTask(markdone)


		elsif(choice == 4)
			flag = true
			print "Enter id of task which Date you want to be change:"
			task_id = gets.chomp


			while flag
				begin
					print "Enter the updated Date (YYYY-MM-DD):"
					due_date = gets.chomp.to_s
					due_date = Date.parse(due_date)
					while true
						if (due_date < Date.today)
							print "Invalid date or date is in the past. Please enter a valid date (YYYY-MM-DD):"
							due_date = gets.chomp.to_s
							due_date = Date.parse(due_date)
						else
							taskmanager.updateDueDate(task_id,due_date)
							break
						end
					end
					flag = false
				rescue => ex
					puts ex.message
				end
			end


		elsif(choice == 5)
			print "Enter id of task you want to Delete:"
			delete = gets.chomp
			puts delete
			taskmanager.deleteTask(delete)

		elsif (choice == 0)
			exit

		else
			puts "Invalid Choice"
		end

	rescue ArgumentError
		puts "ERROR!!!!Choice can be from 1 - 5 | 0 to EXIT PROGRAM"
	end
end