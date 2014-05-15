命令行接口
--------------

## 超链接
一部分终端会自动给形如http://cuihq.me的文本。

效果:

![字符链接](/cli_text_a.jpg "字符链接")

## 字符画
英文字符和标点可使用字符画。

例子:
命令行输出

```shell
artii "chq's blog" -f big
```

ruby代码

```ruby
require 'artii'
puts Artii::CLI.new('chq"s blog','-f','big').output
```

效果:

![字符画效果](/cli_text_image.jpg "字符画效果")

参考:
[artii](https://github.com/miketierney/artii "artii")

## 文本样式
可对文本的颜色、背景进行控制，在不支持文本样式的终端中，会将转义字符一起显示出来。

例子:

显示一个黄色背景先划线的chq文字。

```ruby
puts "\033[0;4;43mchq\033[0m's blog"
```

效果:

![样式效果](/cli_text_style.jpg "样式效果")

格式：ESC字符[CSI字符码

* ESC字符十进制为\033
* CSI字符码：多项由分号分开，SGR控制字符以m结尾
  SGR控制字符 | 含义
  ------|------
  0  | 重置所有属性
  4  | 下划线
  30 | 黑色字体
  31 | 红色字体
  32 | 绿色字体
  33 | 黄色字体
  34 | 蓝色字体
  35 | 紫色字体
  36 | 青色字体
  37 | 黑色字体
  40 | 黑色背景
  41 | 红色背景
  42 | 绿色背景
  43 | 黄色背景
  44 | 蓝色背景
  45 | 紫色背景
  46 | 青色背景
  47 | 黑色背景

参考:

* [ANSI转义码](http://en.wikipedia.org/wiki/ANSI_escape_code "ANSI转义码")
* [colorize](https://github.com/fazibear/colorize, "colorize")

## 其它

* 显示光标: "\\033\[?25l"
* 隐藏光标: "\\033\[?25h"
* 控制光标位置: "\\033\[<m>;<n>H", m和n是行列数
* 清除屏幕: "\\033\[2J"
