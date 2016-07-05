#!/usr/bin/ruby

print "\nRuby loop statements"
print "\n--------------------"
print "\nwhile    : "
$i = 0
while $i < 3
  print " #$i"
  $i +=1
end

print "\nwhile do : "
$i = 0
while $i < 3 do
  print " #$i"
  $i +=1
end

print "\ndo while : "
$i = 0
begin
  print " #$i"
  $i += 1
end while $i < 3

print "\nuntil do : "
$i = 0
until $i > 2 do
  print " #$i"
  $i += 1
end

print "\ndo until : "
$i = 0
begin
  print " #$i"
  $i += 1
end until $i > 2

print "\nfor      : "
for i in 0..2
  print " #{i}"
end

print "\neach     : "
(0..2).each do |i|
  print " #{i}"
end

print "\n--------------------"

print "\nbreak    : "
for i in 0..7
  print " #{i}"
  break if i > 1
end

print "\nnext     : "
for i in 0..3
  next if i == 1
  print " #{i}"
end

print "\nredo     : "
$r=1
for i in 0..1
  print " #{i}"
  $r -= 1
  redo if i == $r
end

print "\nretry    : "
$r=1
begin
  for i in 0..1
    print " #{i}"
    $r -= 1
    raise if i == $r
  end
rescue
  retry
end

puts "\n--------------------"
