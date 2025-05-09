# O

- ## 待办

  - [ ] 中转类型13，修改一下，pid无论是否存在都写入到数据库中，如果地图在，直接到地图中执行，地图关闭的时候，把已执行的从数据库删除
  - [ ] 新手流程，关卡返回副本的时候，生成的队伍应该由SceneCopy中保存的队伍来生成
  - [x] 教学地图，玩家手动退出的时候，地图延迟30秒关闭
  - [ ] 教学地图，玩家在地图中，服务器宕机，没有保存到玩家队伍坐标，这个情况下，玩家重新进入教学地图，需要处理玩家队伍状态，因为garray_db中的数据保存的是玩家队伍在外面，但是教学地图数据，没有玩家队伍的坐标。
  - [ ] league_team_scene:quit_copy_1方法里面修改role_map和role_scene是否有必要，单独处理，在scene_db:quit_multi_copy_scene里面也有role_map和role_scene的处理
  - [ ] GM Skill_port护盾显示不出来了，因为改了护盾结构
  - [ ] 很多地方有同步数据到地图内的有判定宗门不同步，新增的小宗门也需要有这个判定。比如map_mod_role:change_equip_weapon/4 方法内就有判定。把这个提成一个方法，方便后面新增地图的时候好加。另外就是同步技能，同步法宝也需要处理，看看还有没有其他需要同步的
  - [ ] .
  - [ ] .
  - [ ] .
  - [ ] .


- ## 记录

  - 常用代码


      ```erlang
      加载
      rr("../plugin/game/*/*").
      rr("../plugin/game/*/*/*").
      rr("../plugin/game/*/*/*/*").
      rr("../plugin/game/*/*/*/*/*").
      rr("../plugin/game_gm/*/*/*"). 

      启服
      cd d:
      cd D:\SVN\zt\server\intranet\code\zt_server\trunk\int\boot
      .\start.bat

      连接node
      //-name attach@127.0.0.1 这个节点名称是固定的，不能修改
      werl -hidden -setcookie Uz1aeIQ -name attach@127.0.0.1 -remsh node@192.168.191.1

      王森林发的进入地图的lua代码
      local tab = _G.NetManagerInst:GetProtoTable(10327)
      tab.map_type = 6
      tab.map_sid = 1201
      _G.NetManagerInst:Send(tab)

      客户端副本结束
      local tab = _G.NetManagerInst:GetProtoTable(10353)
      tab.map_sid = 1201
      tab.pass_bool = 1
      _G.NetManagerInst:Send(tab)
      

      ```

  - github

      ```github
      1.ssh访问仓库：
      ssh-keygen -t rsa -b 4096 -C "269932361"

      2.访问异常，考虑DNS问题，可以在hosts(C:\Windows\System32\drivers\etc\hosts)文件中增加
      140.82.116.4 github.com

      ```

  - 坠龙禁地压测，GM批量创建账号100个、区分地图、带仙盟，仙盟40人，然后手动创建一个账号，与创建的账号互换UID，登录之后打下坠龙禁地的传送门，然后调用  </br>  `test_lib:pressure_test(1,100,ai_bhv_test_zljd_dup_fight).`

  - erlang编译erl文件，使用erlc命令 </br>  `erlc -I ./头文件路径 test.erl`
  
  - .
  - .
  - .
  - .
  - 

---

# 示例

- ##  代码块

  ```erlang
  test:fun1(A).
  test:fun1(A).
  test:fun1(A).
  ```

- ##  行内代码块

  `print("hello world!").`

- ## 表格
  
  | 表头   | 表头   |
  | ------ | ------ |
  | 单元格 | 单元格 |
  | 单元格 | 单元格 |
  
- ## 超链接

  [百度](www.baidu.com)
  
- ## 待办事项

  - [ ] 写作业

- ## 已办事项  

  - [x] 打游戏

- ## ~~删除线~~
  
  >格式说明： 两边各两个~

- ## 引用
  
  >格式说明：>开头
  
- ## 有序列表
  
  >（格式说明：数字小数点空格）

  1. 序列1
  2. 序列2

- ## 斜体、粗体

  _斜体1_
  _斜体2_
  **粗体**

- ## 换行
  
  >格式说明：< /br> 一个斜杠/，或者不用斜杠< br>，（删除空格)

  测试</br>测试</br>测试

- ## 空心点和实现点
  
  >说明： -用作点，在第一级的时候是是实心点，第二级的时候为空心点，后面为实心正方形
  - a
    - b
      - c
        - d
  - e
  - f
