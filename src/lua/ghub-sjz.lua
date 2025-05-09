-- 鼠标平滑移动到右侧边缘的宏
function OnEvent(event, arg)
    OutputLogMessage("event:" .. event .. ",arg:" .. arg .. "\n")
    if event == "MOUSE_BUTTON_PRESSED" and arg == 11 then -- 假设使用侧键5触发
        del_df()
    end
end

-- 三角洲丢东西
function del_df()
    -- 获取当前位置
    local currentX, currentY = GetMousePosition()
    -- 移动到屏幕最右边
    SmoothMove()
    Sleep(10)
    -- 移动回来
    MoveMouseTo(currentX, currentY)
end

-- 移动到屏幕最右边
function SmoothMove()
    local num = 0
    --移动过程
    while true and num < 10 do
        num = num + 1
        MoveMouseRelative(800, 0)
        Sleep(10)
        local currentX, currentY = GetMousePosition() -- 获取当前鼠标位置
        if currentX >= 65535 then
            break
        end
    end
    --移动到最终目标点
    MoveMouseTo(65535, 32767)
    Sleep(10)
end
