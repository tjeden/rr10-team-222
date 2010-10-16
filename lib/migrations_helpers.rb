module MigrationsHelpers
  def add_timestamp_columns(to_table)
    add_column to_table, :created_at, :timestamp
    add_column to_table, :updated_at, :timestamp
  end
  
  def remove_timestamp_columns(from_table)
    remove_column from_table, :created_at
    remove_column from_table, :updated_at
  end
  
  def reset_auto_increment(table)
    execute "alter table #{table} auto_increment=0"
  end
  
  def add_foreign_key(from_table, from_column, to_table, constraint_name = nil, cascade_delete = true, cascade_update = true) 
    constraint_name ||= "fk_#{from_table.to_s}_#{to_table.to_s}"
    suffix = (cascade_delete ? " on delete cascade" : "" ) + (cascade_update ? " on update cascade" : "")
    execute %{alter table #{from_table.to_s} 
              add constraint #{constraint_name} 
              foreign key (#{from_column.to_s}) 
              references #{to_table.to_s}(id)
              #{suffix}} 
  end 
  
  def drop_foreign_key(from_table, to_table, constraint_name = nil) 
    constraint_name ||= "fk_#{from_table.to_s}_#{to_table.to_s}" 
    execute %{alter table #{from_table.to_s} 
              drop foreign key #{constraint_name}}
    execute %{alter table #{from_table.to_s}
              drop key #{constraint_name}}
  end 

  
end
