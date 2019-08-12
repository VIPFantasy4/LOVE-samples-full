--[[--function love.load(arg)
--    if arg[#arg] == "-debug" then
--        require("mobdebug").start()
--    end
--end
--
--function love.draw()
--    love.graphics.setColor(20, 200, 0, 255)
--    love.graphics.print("IIIIIIIIIIIIII", 0, 0, 1)
--    love.graphics.rectangle("fill", 100, 200, 50, 80)
--    love.graphics.setColor(0, 1, 0, 1)
--    love.graphics.print("This is a pretty lame example.", 10, 200)
--    love.graphics.setColor(1, 0, 0, 1)
--    love.graphics.print("This lame example is twice as big.", 10, 250, 0, 2, 2)
--    love.graphics.setColor(0, 0, 1, 1)
--    love.graphics.print("This example is lamely vertical.", 300, 30, math.pi / 2)
--end
--
--function love.load()
--    baseX = 300
--    baseY = 400
--    radius = 200
--    offsetY = radius * .5 * math.sqrt(3)
--    love.graphics.setBackgroundColor(0, 0, 0)
--end
--
--function love.draw()
--    love.graphics.setColor(1, 0, 0, 100)
--    love.graphics.circle('line', baseX, baseY, radius, 50)
--    love.graphics.setColor(0, 1, 0)
--    love.graphics.circle('fill', baseX + radius / 2, baseY - offsetY, radius, 50)
--    love.graphics.setColor(0, 0, 1)
--    love.graphics.circle('fill', baseX + radius, baseY, radius, 50)
--    love.graphics.setColor(1, 0, 0, 1)
--    love.graphics.circle('line', 50, 50, 20, 20)
--
--    love.graphics.setColor(0, 0, 1, 1)
--    love.graphics.circle('fill', 50, 100, 20, 20)
--
--    myColor = { 0, 1, 0, 10 }
--    love.graphics.setColor(myColor)
--    love.graphics.circle('fill', 50, 150, 20, 20)
--    love.graphics.circle('fill', 50, 200, 20, 20)
--    love.graphics.circle('fill', 50, 250, 20, 20)
--    love.graphics.circle('fill', 50, 300, 20, 20)
--
--end
-- Load some default values for our rectangle.
function love.load()
    --x, y, w, h = 20, 20, 60, 20
    --delta = 0
    world = love.physics.newWorld(0, 1000)
    love.physics.setMeter(10) -- set 30 pixels/meter
    car = {}
    car.body = love.physics.newBody(world, 200,  44, "dynamic") -- place the body at pixel coordinates (300,300) or in meter coordinates (10,10)
    car.shape = love.physics.newRectangleShape(120, 44)   --创建一个矩形大小为汽车图片的大小
    car.fixture = love.physics.newFixture(car.body, car.shape)  --把矩形附加到汽车
    --
    --ground = {}
    --ground.body = love.physics.newBody(world, 0, 560)
    --ground.shape = love.physics.newRectangleShape(1200, 44)
    --ground.fixture = love.physics.newFixture(ground.body, ground.shape)
    --ground.fixture:setRestitution(0) --反弹系数,即碰撞反弹后速度为原来的0.3倍
    --print(body:getPosition())
    --love.physics.setMeter(10) -- set 10 pixels/meter
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    --delta = delta + dt
    --if w < 100 then
    --    w = w + 1
    --    h = h + 1
    --end

    --print(body:getPosition()) -- returns pixel coordinates (100,100)

    world:update(dt)
    require('debug/lovebird').update()
end

-- Draw a coloured rectangle.
function love.draw()
    --love.graphics.setColor(0, 0.4, 0.4)
    --love.graphics.print("This is a pretty lame ." .. delta, 10, 200)
    --love.graphics.rectangle("fill", x, y, w, h)
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf("This text is aligned right, and wraps when it gets too big.", 0, 0, 600, "right")
    --love.graphics.rectangle("fill", car.body:getX(), car.body:getY(), 120, 44)
    --love.graphics.setColor(1, 1, 0)
    --love.graphics.rectangle("fill", ground.body:getX(), ground.body:getY(), 1200, 44)
end]]

--[[
--TODO:以后考虑用图都用这种切割形式
img = love.graphics.newImage("mushroom-64x64.png")

-- Let's say we want to display only the top-left
-- 32x32 quadrant of the Image:
top_left = love.graphics.newQuad(0, 0, 32, 32, img:getDimensions())

-- And here is bottom left:
bottom_left = love.graphics.newQuad(0, 32, 32, 32, img:getDimensions())

function love.draw()
    love.graphics.draw(img, top_left, 50, 50)
    love.graphics.draw(img, bottom_left, 50, 200)
    -- v0.8:
    -- love.graphics.drawq(img, top_left, 50, 50)
    -- love.graphics.drawq(img, bottom_left, 50, 200)
end]]

function love.load()
    --love.graphics.setBackgroundColor(104, 136, 248) --设置背景为蓝色
    --love.window.setMode(800, 600) --设置窗口650*650,不全屏,开启垂直同步,全屏抗锯齿缓存0

    --下面是物理引擎的使用
    love.physics.setMeter(10) --设置64px(像素)为1米,box2d使用实际的物理体系单位
    world = love.physics.newWorld(0, 1000, true) --创建一个世界,其水平加速度为0,竖直9.81m/s(即地球)

    objects = {} -- 物理对象table

    --创建地面
    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, 800 / 2, 600 - (150 - 15) / 2)  --创建一个静态物体, 在世界world中的位置是(650/2, 650-50/2)
    objects.ground.shape = love.physics.newRectangleShape(800, 150 - 15)   --创建一个矩形
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)  --把矩形附加到物体

    --创建天花板
    objects.ceiling = {}
    objects.ceiling.body = love.physics.newBody(world, 800 / 2, 15)  --创建一个静态物体, 在世界world中的位置是(650/2, 650-50/2)
    objects.ceiling.shape = love.physics.newRectangleShape(800, 10)   --创建一个矩形ns
    objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape)  --把矩形附加到物体

    --创建一个球
    objects.ball = {}
    objects.ball.body = love.physics.newBody(world, 800 / 2, 600 / 2, "dynamic") --创建一个动态物体
    objects.ball.shape = love.physics.newCircleShape(20) --创建一个圆形
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape) --把圆形附加到物体上,密度为1
    objects.ball.fixture:setRestitution(0.7) --反弹系数,即碰撞反弹后速度为原来的0.7倍

    --创建一些方块
    objects.block1 = {}
    objects.block1.body = love.physics.newBody(world, 200, 501, "dynamic")
    objects.block1.shape = love.physics.newRectangleShape(50, 100)  --竖直的方块
    objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape) --密度比球大,质量更大

    objects.block2 = {}
    objects.block2.body = love.physics.newBody(world, 200, 600 / 2, "dynamic")
    objects.block2.shape = love.physics.newRectangleShape(100, 50)  --水平的方块
    objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

    hamster = love.graphics.newImage("hamster.png")
end

function love.keypressed(k)
    if k == 'escape' then
        love.event.push('quit') -- Quit the game.
    end

end

function love.update(dt)
    world:update(dt)
    --print(objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints()))
    print(objects.ceiling.body:isTouching(objects.ball.body))

    if love.keyboard.isDown("right") then
        objects.ball.body:applyForce(4000, 0) --给球(400,0)牛的力,力是矢量,即沿x轴正方向400,y轴正方向0
    elseif love.keyboard.isDown("left") then
        objects.ball.body:applyForce(-4000, 0) --给球(-400,0)牛的力
    elseif love.keyboard.isDown("up") then
        objects.ball.body:applyForce(0, -40000)
    end

    require('debug/lovebird').update()
end

function love.draw()
    love.graphics.setColor(1, 0, 0) -- 红色,用来画天花板
    love.graphics.polygon("fill", objects.ceiling.body:getWorldPoints(objects.ceiling.shape:getPoints()))--使用地面坐标画多边形

    love.graphics.setColor(0, 1, 0) -- 绿色,用来画地面
    local x, y = objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())
    --print(x, y)
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))--使用地面坐标画多边形

    love.graphics.setColor(193, 47, 14) --红色,用来画球
    love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())

    love.graphics.setColor(50, 50, 50) --灰色,用来画方块
    love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
    love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(hamster, 700, 100, math.rad(90), 1, 1, hamster:getWidth() / 2, hamster:getHeight() / 2)
end