# coding: utf-8
RSpec::Support.require_rspec_core "formatters/base_text_formatter"
module RSpec 
  module Core
    module Formatters 

      class Dots < BaseTextFormatter

        Formatters.register self, :example_passed, :example_pending, :example_started,
              :example_failed, :start
        
        attr_accessor :passes, :fails, :runs, :pendings

        def initialize(output)
          @passes = 0
          @fails = 0 
          @runs = 0
          @pendings = 0
          #@example_count = 0
          super(output)
        end

        def example_started(example)
          print_progress(example)
        end

        def start(notification)
          super(notification)
          output.puts #new line
        end

        def example_pending(example)
          @runs += 1
          @pendings += 1
          print_progress(example, true)
        end

        def example_passed(example)
          @runs += 1
          @passes += 1
          print_progress(example, true)
        end
        
        def example_failed(example)
          @fails += 1
          @runs += 1
          print_progress(example, true)
        end


        def dump_summary(summary)
          output.puts
          output.puts
          output.puts "Finished in #{Helpers.format_duration summary.duration}"
          output.puts
          if @fails == 0
            output.puts ConsoleCodes.wrap("┌" +  "--------------" + "-".ljust(20,"-") + "┐", :success)
            output.puts ConsoleCodes.wrap("│" +  "　(＾ヽ--△<＾)" + " ".ljust(20) + "│", :success)
            output.puts ConsoleCodes.wrap("│" +  " /　　　　　~▽" + " ".ljust(20) + "│", :success)
            output.puts ConsoleCodes.wrap("│" +  "士　0　o　0 士" + " #{summary.example_count} test#{summary.example_count > 1? 's' : ' '}".ljust(20) + "│", :success)
            output.puts ConsoleCodes.wrap("│" +  " メ ＿＿＿ メ " + " ".ljust(20) + "│",:success)
            output.puts ConsoleCodes.wrap("│" +  "　　/ へ`-L、 " + " No failures.".ljust(20) + "│", :success)
            output.puts ConsoleCodes.wrap("│" +  " (~(　し′｜ ）" + " ".ljust(20) + "│", :success)
            output.puts ConsoleCodes.wrap("└" +  "--------------" + "-".ljust(20,"-") + "┘", :success)
          else
            output.puts ConsoleCodes.wrap("┌" + "-".ljust(50,"-")  + "┐", :failure)
            output.puts ConsoleCodes.wrap("│   #{summary.example_count} test#{summary.example_count > 1? 's' : ' '}, #{@fails} failure#{@fails > 1? 's' : ' '}".ljust(50) + " │", :failure)
            output.puts ConsoleCodes.wrap("└" + "-".ljust(50,"-")  + "┘", :failure)
            super
          end
        end

        def print_progress(example, finished = false)
          if @fails > 0
            output.print ConsoleCodes.wrap("\r   #{@runs - @fails}-#{@fails} / #{@example_count}. #{@pendings + '. pending.' if @pendings > 0}. Now running: #{example.example.description.ljust(140)}\r #{'✓' if finished}", :failure)
          elsif @pendings > 0
            output.print ConsoleCodes.wrap("\r   #{@runs - @fails}-0 / #{@example_count}. #{@pendings} pending. Now running: #{example.example.description.ljust(140)}\r #{'✓' if finished}", :pending)
          else
            output.print ConsoleCodes.wrap("\r   #{@runs - @fails}-0 / #{@example_count}. Now running: #{example.example.full_description.ljust(140)}\r #{'✓' if finished}", :success)
          end

        end

      end
    end
  end
end
