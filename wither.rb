require 'nokogiri'

def traverse(node, level = 0)
  if node.element?
    id = node[:id] ? '#' + node[:id] : ''
    classes = (node[:class] || "").split(/\s/).map {|c| '.' + c }.join
    puts('  ' * level + node.name + id + classes)
    node.children.each {|n| traverse(n, level + 1) }
  else
    node.children.each {|n| traverse(n, level) }
  end
end

ARGV.each do |fp|
  if ARGV.size > 1
    printf(">>> %s\n", fp)
  end
  open(fp) do |file|
    html = Nokogiri::HTML(file)
    traverse(html)
  end
end
