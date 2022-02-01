maton = [
  [0,0,0],
  [0,0,0],
  [0,0,0]
]

maton2 = [
  [1,0,1],
  [1,1,1],
  [1,0,0]
]

maton3 = [
  [1,0,1,0,1],
  [1,0,1,0,1],
  [1,0,1,0,1],
  [1,0,1,0,1],
  [1,0,1,0,1],
]

maton4 = [
  [0,0,1,1,1],
  [1,0,1,0,1],
  [0,1,0,0,0],
  [1,0,1,1,0],
  [1,0,0,0,1],
]

maton5 = [
  [0,0,1,1,1,0,0],
  [1,0,1,0,1,0,0],
  [0,1,0,1,0,1,0],
  [1,0,1,1,0,1,1],
  [1,0,0,0,1,1,1],
  [1,0,1,0,0,1,1],
  [1,0,1,1,0,1,1],
]

maton6 = [
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,1,1,1,0,0,0,0,0],
  [0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,1,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,1,0,0,1,0,0,0,0,0],
  [0,0,0,0,0,1,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,1,0,0,0,1,0,0,0,0,0],
  [0,0,0,0,0,1,1,1,1,0,0,0,0,0,0],
]

def show(maton)
  image = maton.map do |line|
    line.map do |val|
      val == 0 ? '□' : '■'
    end.join()
  end.join("\n")
  puts image
end

def getNeighborsCount(maton, point) # [1,1]
  count = 0
  neighbor_pos = [
    [point[0]-1, point[1]-1],
    [point[0]-1, point[1]],
    [point[0]-1, point[1]+1],
    [point[0], point[1]-1],
    [point[0], point[1]+1],
    [point[0]+1, point[1]-1],
    [point[0]+1, point[1]],
    [point[0]+1, point[1]+1]
  ]
  neighbor_pos.each do |pos|
    next if pos[0] < 0 || pos[1] < 0

    count += 1 if isAlive(maton, pos)
  end
  count
end

def isAlive(maton, point)
  return unless maton[point[0]]

  maton[point[0]][point[1]] == 1
end

def getNewState(maton, point)
  case getNeighborsCount(maton, point)
  when 0, 1, 4, 5, 6, 7, 8
    0
  when 2
    isAlive(maton, point) ? 1 : 0
  when 3
    1
  end
end

def getNewMatonState(maton)
  new_maton = []
  maton.length.times do |y|
    new_maton << []
    maton[y].length.times do |x|
      new_maton[y][x] = getNewState(maton, [y, x])
    end
  end
  new_maton
end

def start(maton)
  p 'start!'
  show maton
  new_maton = []
  old_maton = maton
  count = 0
  loop do
    count += 1
    p "stage #{count}"
    p 'going next gen...'
    sleep(1)
    new_maton = getNewMatonState(old_maton)
    show new_maton
    break if isSameState(old_maton, new_maton)

    old_maton = new_maton
  end
  p 'finish!'
end

def isSameState(maton1, maton2)
  maton1.length.times do |y|
    maton1[y].length.times do |x|
      return false if !maton1[y] || !maton2[y]
      return false if maton1[y][x] != maton2[y][x]
    end
  end
  true
end