-module(snake_game).
-export([start/0, init/0]).
-include_lib("wx/include/wx.hrl").

-define(CELL_SIZE, 20).
-define(WIDTH, 30).
-define(HEIGHT, 20).
-define(GAME_SPEED, 100).

-record(state, {
    frame,
    panel,
    snake,
    food,
    direction,
    timer
}).

start() ->
    wx:new(),
    Frame = wxFrame:new(wx:null(), -1, "Snake Game", [{size, {?WIDTH * ?CELL_SIZE, ?HEIGHT * ?CELL_SIZE}}]),
    Panel = wxPanel:new(Frame),
    wxFrame:show(Frame),
    
    % 初始化蛇的位置（从中心开始）
    InitialSnake = [{?WIDTH div 2, ?HEIGHT div 2}],
    % 随机生成第一个食物的位置
    Food = generate_food(InitialSnake),
    
    % 设置初始方向（向右）
    Direction = right,
    
    % 设置定时器用于游戏循环
    Timer = erlang:send_after(?GAME_SPEED, self(), tick),
    
    % 设置键盘事件处理
    wxPanel:connect(Panel, key_down),
    wxPanel:connect(Panel, paint),
    
    State = #state{
        frame = Frame,
        panel = Panel,
        snake = InitialSnake,
        food = Food,
        direction = Direction,
        timer = Timer
    },
    
    init(),
    game_loop(State).

init() ->
    % 初始化游戏
    ok.

game_loop(State = #state{panel = Panel, snake = Snake, food = Food, direction = Direction}) ->
    receive
        tick ->
            % 移动蛇
            NewSnake = move_snake(Snake, Direction),
            % 检查是否吃到食物
            {UpdatedSnake, UpdatedFood} = check_food(NewSnake, Food),
            % 检查是否撞墙或撞到自己
            case check_collision(UpdatedSnake) of
                true ->
                    % 游戏结束
                    wxFrame:destroy(State#state.frame),
                    ok;
                false ->
                    % 重绘游戏画面
                    redraw(Panel, UpdatedSnake, UpdatedFood),
                    % 设置下一个定时器
                    NewTimer = erlang:send_after(?GAME_SPEED, self(), tick),
                    game_loop(State#state{snake = UpdatedSnake, 
                                         food = UpdatedFood,
                                         timer = NewTimer})
            end;
        #wx{event = #wxKey{keyCode = Code}} ->
            % 处理键盘输入
            NewDirection = case Code of
                ?WXK_LEFT when Direction /= right -> left;
                ?WXK_RIGHT when Direction /= left -> right;
                ?WXK_UP when Direction /= down -> up;
                ?WXK_DOWN when Direction /= up -> down;
                _ -> Direction
            end,
            game_loop(State#state{direction = NewDirection});
        _ ->
            game_loop(State)
    end.

move_snake([{X, Y}|Rest], Direction) ->
    NewHead = case Direction of
        left -> {X - 1, Y};
        right -> {X + 1, Y};
        up -> {X, Y - 1};
        down -> {X, Y + 1}
    end,
    [NewHead|Rest];
move_snake([], _Direction) ->
    % 如果蛇为空，返回初始位置
    [{?WIDTH div 2, ?HEIGHT div 2}].

check_food(Snake = [Head|_], Food) ->
    case Head =:= Food of
        true ->
            % 蛇吃到食物，长度加1
            {Snake, generate_food(Snake)};
        false ->
            % 没吃到食物，移除蛇尾
            {lists:droplast(Snake), Food}
    end.

generate_food(Snake) ->
    % 随机生成一个不在蛇身上的位置
    NewFood = {rand:uniform(?WIDTH) - 1, rand:uniform(?HEIGHT) - 1},
    case lists:member(NewFood, Snake) of
        true -> generate_food(Snake);
        false -> NewFood
    end.

check_collision([]) ->
    false;
check_collision([{X, Y}|Rest]) ->
    % 检查是否撞墙
    if
        X < 0; X >= ?WIDTH; Y < 0; Y >= ?HEIGHT ->
            true;
        true ->
            % 检查是否撞到自己
            lists:member({X, Y}, Rest)
    end.

redraw(Panel, Snake, Food) ->
    DC = wxPaintDC:new(Panel),
    % 清空画布
    wxDC:clear(DC),
    % 绘制蛇
    [draw_cell(DC, X, Y, {0,255,0}) || {X, Y} <- Snake],
    % 绘制食物
    {FoodX, FoodY} = Food,
    draw_cell(DC, FoodX, FoodY, {255,0,0}),
    wxPaintDC:destroy(DC).

draw_cell(DC, X, Y, Color) ->
    Brush = wxBrush:new(Color),
    Pen = wxPen:new(Color),
    wxDC:setBrush(DC, Brush),
    wxDC:setPen(DC, Pen),
    X1 = X * ?CELL_SIZE,
    Y1 = Y * ?CELL_SIZE,
    W = ?CELL_SIZE - 1,
    H = ?CELL_SIZE - 1,
    wxDC:drawRectangle(DC, {X1, Y1, W, H}),
    wxBrush:destroy(Brush),
    wxPen:destroy(Pen).