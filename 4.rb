input = 'forward 5
down 5
forward 8
up 3
down 8
forward 2'

commands = input.split(/\n/)

def commands_to_tasks(cmds)
    cmds.map do |c|
        cmd_parts = c.split(/\s+/)
        x = cmd_parts[1].to_i
        if cmd_parts[0] == 'forward'
            lambda {|c| [c[0] + x, c[1] + c[2] * x, c[2]]}
        elsif cmd_parts[0] == 'up'
            lambda {|c| [c[0], c[1], c[2] - x]}
        elsif cmd_parts[0] == 'down'
            lambda {|c| [c[0], c[1], c[2] + x]}
        else
            lambda {|c| c}
        end
    end
end

tasks = commands_to_tasks commands
result = tasks.inject([0, 0, 0]) {|c, task| task.call(c)}
p result[0] * result[1]
