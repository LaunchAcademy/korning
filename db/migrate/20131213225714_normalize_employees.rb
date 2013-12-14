class NormalizeEmployees < ActiveRecord::Migration
  def up
    add_column :sales, :employee_id, :integer

    Sale.reset_column_information
    Sale.find_each do |sale|
      new_employee = format_employee(sale.attributes["employee_name_email"])
      employee = Employee.find_or_create_by(name: "#{new_employee[0]} #{new_employee[1]}", email: new_employee[2])
      sale.employee_id = employee.id
      sale.save
    end

    remove_column :sales, :employee_name_email
  end

  def down
    add_column :sales, :employee_name_email, :string
    Sale.find_each do |sale|
      sale.update(employee_name_email:"#{sale.employee.name} #{sale.employee.email}")
      sale.save
    end
    Employee.delete_all
    remove_column :sales, :employee_id
  end

  def format_employee(string)
    string.gsub(/[()]/, ('')).split(' ')
  end

end
