module AutoFormat

# package code goes here

# minimal function export list
export format

# main format function
function format(input::String, output::String, tab_width::Int)
  result = String[]
  layer = 1
  block_start = ["^if" "^while" "^for" " begin " "^try" "^function" "^type" "^let" "^macro" "quote" " do " "^immutable"]
  block_other = ["^else\$", "^elseif "]
  open(input, "r") do file
    for line in eachline(file)
      line = rstrip(lstrip(line))
      line = replace(line, "print\(", "#print\(")
      if sum(check_block_keyword(line, block_start))>0
        line = process_line(line)
        line = " "^(tab_width*(layer-1))*line
        layer = layer+1
      elseif sum(check_block_keyword(line, block_other))>0
        layer = layer-1
        line = process_line(line)
        line = " "^(tab_width*(layer-1))*line
        layer = layer+1
      elseif ismatch(r"^end$", line)
        layer = layer-1
        line = process_line(line)
        line = " "^(tab_width*(layer-1))*line
      elseif ismatch(r"#print\(", line) || ismatch(r"^#", line)
        line = line
        line = " "^(tab_width*(layer-1))*line
      else
        line = process_line(line)
        line = " "^(tab_width*(layer-1))*line
      end
      line = replace(line, "#print\(", "print\(")
      result = push!(result, line*"\n")
    end
    file_output = open(output, "w+")
    write(file_output, result)
    close(file_output)
  end
end

#add space (, = -= +=)
function add_space(line::String)
  line = replace(line, r"\s+", " ")
  line = replace(line, "-=", "MaSkEdMiNuS")
  line = replace(line, "+=", "MaSkEdPlUs")
  line = replace(line, r"\s=\s|=\s|\s=|=", " = ")
  line = replace(line, r"\s,\s|,\s|\s,|,", ", ")
  line = replace(line, r"\sMaSkEdPlUs\s|MaSkEdPlUs\s|\sMaSkEdPlUs|MaSkEdPlUs", " += ")
  line = replace(line, r"\sMaSkEdMiNuS\s|MaSkEdMiNuS\s|\sMaSkEdMiNuS|MaSkEdMiNuS", " -= ")
  return line
end

# format file line by line
function process_line(line::String)
  block_count = [1:length(split(line, "\""))]
  temp = split(line, "\"")
  temp[block_count[map(isodd, block_count)]] = map(add_space, temp[block_count[map(isodd, block_count)]])
  templine = join(temp, "\"")
  if ismatch(r";",templine) && !ismatch(r"\";\"",templine)
    line = join(map(lstrip,map(rstrip, split(templine,";"))), "\n")*"\n"
  end
  return line
end

# check whether contain a block keyword
function check_block_keyword(line::String, list::Array)
  block_count = [1:length(split(line, "\""))]
  temp = split(line, "\"")
  templine = join(temp[block_count[map(isodd, block_count)]], "\"")
  return map((x)->ismatch(Regex(list[x]), templine), 1:length(list))
end


end # module
