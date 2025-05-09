-- 鼠标平滑移动到右侧边缘的宏
function OnEvent(event, arg)
    --OutputLogMessage("event:" .. event .. ",arg:" .. arg .. "\n")
    if event == "MOUSE_BUTTON_PRESSED" and arg == 11 then -- 假设使用侧键5触发
        del_df()
    end
end

-- 三角洲丢东西
function del_df()
    -- 获取当前位置
    local currentX, currentY = GetMousePosition()
    OutputLogMessage("currentX:" .. currentX .. ",currentY:" .. currentY .. "\n")
    PressMouseButton(1)
    -- 移动到屏幕最右边
    Sleep(20)
    SmoothMove()
    Sleep(10)
    ReleaseMouseButton(1)
    Sleep(20)
    -- 移动回来
    MoveMouseTo(currentX, currentY)
end

-- 移动到屏幕最右边
function SmoothMove()
    Sleep(8)
    local num = 0
    --移动过程
    while true and num < 10 do
        num = num + 1
        MoveMouseRelative(2000, 0)
        Sleep(20)
        local currentX, currentY = GetMousePosition() -- 获取当前鼠标位置
        if currentX >= 65000 then
            break
        end
    end
    --移动到最终目标点
    endX = math.random(64390, 64820)
    endY = math.random(32750, 32780)
    MoveMouseTo(endX, endY)
    Sleep(8)
end
