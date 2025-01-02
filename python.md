# python

- ## 命名方式

    ```python
    clase MyClase               //类，驼峰
    my_variable = 1             //变量，小写加下划线
    my_fun()                    //方法，小写加下划线，动词优先，动词写在前面，send_mail
    MY_CONSTANT                 //常量，大写加下划线
    _my_protected_var           //受保护的实例属性应该以单个下划线开头
    _my_private_var             //私有变量，单下划线开头的变量
    __my_private_var            //私有变量，双下划线前缀，对于类中的私有变量，使用双下划线开头可以触发名称改写，使得这些变量在类外部不可访问。
    __init__, __str__           //特殊方法，双下划线前后缀，特殊方法（也称为魔术方法）应该以双下划线开头和结尾
    ValueError                  //异常名，Error结尾。
    ```
