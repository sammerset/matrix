#!/usr/bin/env ruby

class App

  def initialize
      loop do
        puts "Insert your data: "
        in_string = gets.chomp
        if in_string =~ /^\d+$/
          if number(in_string)[1] == 0
            get_array(number(in_string)[0].to_i).each{|x| puts x.reverse.join("  ")}
          else
            puts "You may insert only square numbers (number in n degree)!"
          end
        else
          puts "You may insert only numbers (empty field or float numbers is too bad)!"
        end
        puts "push any button to continie or use next command for exit: 'exit' or 'quit'"
        in_string = gets.chomp
        if in_string =~ /^(quit|exit)$/
          break
        end
      end
  end

  def number str
      Math.sqrt(str.to_i).divmod(1)
  end

  def get_array num
      a = Array.new
      result = Array.new
      num.times{|i| result[i] = (0..num-1).to_a }
      i=0
      spiral(num) { |x, y|
          a[i] = [x,y]
          i+=1
      }
      begin
        a.each_with_index do |ar,y|
          f = a.max[1].abs-ar[1]
          s = a.min[0].abs-ar[0]
          result[f][s] = y+1 unless result[f][s].eql? nil
        end
          rescue
      end
      return result
  end

  def spiral(xDim)
     sx = xDim / 2
     cx = cy = 0

     direction = distance = 1

     yield(cx,cy)
     while(cx.abs <= sx || cy.abs <= sx)
       distance.times { cx += direction; yield(cx,cy) if(cx.abs <= sx && cy.abs <= sx); } 
       distance.times { cy += direction; yield(cx,cy) if(cx.abs <= sx && cy.abs <= sx); } 
       distance += 1
       direction *= -1
     end
   end
  
end

App.new