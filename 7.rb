def read_input
    draws = readline.split(/\,/).map {|s| s.to_i}
    boards = []
    cur_row = 0
    board = []
    while true do
        begin
            s = readline.chomp
        rescue EOFError
            break
        else
            if s == '' 
                next
            end
            if cur_row == 5
                boards << board
                board = []
                board << s.split.map {|s| [s.to_i, 0]}
                cur_row = 1
            else
                board << s.split.map {|s| [s.to_i, 0]}
                cur_row += 1
            end
        end
    end

    if board != [[]]
        boards << board
    end

    [draws, boards]
end

def mark_number(boards, num)
    boards.each do |board|
        board.each do |row|
            row.each do |r|
                if r[0] == num
                    r[1] = 1
                end
            end
        end
    end
end

def find_winnner(boards)
    winner = nil
    boards.each do |board|
        row_sums = (0...5).map {|i| board[i].map {|r| r[1]}.sum}
        col_sums = (0...5).map {|i| board.map {|row| row[i]}.map {|r| r[1]}.sum}

        if (row_sums.any? {|x| x == 5}) or (col_sums.any? {|x| x == 5})
            winner = board
            break
        end
    end

    winner
end

def draw_boards(boards)
    boards.each do |board|
        board.each do |row|
            p(row.map {|r| if r[1] == 1 then "<#{r[0]}>" else "| #{r[0]} |" end})
        end
        puts '-' * 20
        puts
    end
end
   
def find_sum_unmarked(board)
    sum = 0
    (0...5).each do |i|
        (0...5).each do |j|
            if board[i][j][1] != 1
                sum += board[i][j][0]
            end
        end
    end
    sum
end
               
# Part 1

def part1(draws, boards)
    draws.each do |draw|
        mark_number boards, draw
        winner = find_winnner boards
        if not winner.nil?
            p (find_sum_unmarked(winner) * draw)
            break
        end
    end
end


draws, boards = read_input
part1 draws, boards
