def get_directory_size(directories_structure, current_directory, directories_sizes = {})
  return 0 unless directories_structure[current_directory]

  directory_size = 0

  directories_structure[current_directory].each do |type, name, file_size|
    if type == :directory
      new_directory = current_directory + name + "/"
      new_directory_size = get_directory_size(directories_structure, new_directory, directories_sizes)
      directory_size += new_directory_size

      directories_sizes[new_directory] = new_directory_size
    else
      directory_size += file_size
    end

    directories_sizes[current_directory] = 0 unless directories_sizes[current_directory]
    directories_sizes[current_directory] = directory_size
  end

  directory_size
end

lines = File.readlines("day7.input")

current_directory = "/"
directories_structure = {}

lines.each do |line|
  tokens = line.split

  if tokens[0] == "$"
    if tokens[1] == "cd"
      if tokens[2] == ".."
        current_directory = current_directory.split("/")[0..-2].join("/") + "/"
      elsif tokens[2] == "/"
        current_directory = "/"
      else
        current_directory += tokens[2] + "/"
      end
    end
  else
    directories_structure[current_directory] = [] unless directories_structure[current_directory]

    if tokens[0] == "dir"
      directory_name = tokens[1]
      directories_structure[current_directory].push [:directory, directory_name]
    else
      filename = tokens[1]
      size = tokens[0].to_i
      directories_structure[current_directory].push [:file, filename, size]
    end
  end
end

directories_sizes = {}
get_directory_size(directories_structure, "/", directories_sizes)
max_size = 100000

p directories_sizes.select { |_, v| v <= max_size }.sum { |_, v| v }

space_at_least = 30000000
total_disk_space = 70000000
available_disk_space = total_disk_space - directories_sizes["/"]

p directories_sizes.select { |_, v| v >= space_at_least - available_disk_space }.map { |_, v| v }.sort.first
