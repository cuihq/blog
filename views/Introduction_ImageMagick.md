# 简介

ImageMagic 是一个开源的创建、编辑、合成或转换位图的软件集。

* 开源: 采用Apache 2.0 协议，可以免费商用;
* 软件集: 超过10个命令;
* 位图: 超过100种图片格式。

参考资料：

* [ImageMagic官网](http://www.imagemagick.org/)

---------------------------------------------------------------------

# 语言及平台

Ruby程序语言支持: 

[MiniMagick](http://rubyforge.org/projects/mini-magick)

平台支持: 

  * Unix
  * Mac OS X
  * iOS
  * Windows

---------------------------------------------------------------------

# 功能

* 格式转换(convert)：从图像一种格式转换成到另一个（例如 PNG 转 JPEG）;
* 变换：缩放，旋转，裁剪，翻转或修剪图像;
* 图像识别(identify)：描述的格式和图像性能;
* 截取屏幕(import): 在任何可见的窗口上捕获并输出图片文件;
* 比较(compare): 标记两个图片的差异;
* 显示(display): 显示一张图片或者一系列图片；
* 合成(composite): 一张图片覆盖另外一张图片；
* 动画(animate): 利用X server显示动画图片;
* conjure: 解释执行 MSL (Magick Scripting Language) 写的脚本；
* mogirfy: 与convert差不多,改写最初的图像文件;
* montage: 将多个文件合成一张；

----------------------------------------------------------------------

# 图片格式转换

例子:

```shell
convert test.png test.jpg
```

批量转换当前目录下的所有的png格式为jpg

```shell
mogrify -format jpg *.png
```

ImageMagick会从文件后缀名猜测文件格式。

查看你系统中支持的文件格式，请输入：

```shell
identify -list format
```

-----------------------------------------------------------------------

# 图像识别

使用identify命令可以识别图像的名称，格式，尺寸，色域，大小等信息。

例1:

```shell
identify test.jpg
```

> test.jpg JPEG 293x220 293x220+0+0 8-bit sRGB 6.12KB 0.000u 0:00.000

例2,查看图片详情(包括元数据):

```shell
identify -verbose test.png
```

-----------------------------------------------------------------------

# 改变图像尺寸

使用convert或mogrify命令。后面是-scale开关项。

例1:

```shell
convert -scale 50x50 avatar.png avatar_small.png
```

![头像](/avatar.png "头像")
![小头像](/avatar_small.png "小头像")

例2：

```shell
mogrify -scale 100 test.jpg
```

-scale开关项有一个尺寸(geometry)作为参数。 尺寸参数格式如下表：

尺寸（size) | 描述
--------|------
scale% | 高度和宽度按指定的百分比缩放
scale-x%xscale-y%	| 高度和宽度分别按指定的百分缩放比（只需要一个%符号）
width	| 指定宽度，高度根据原比例自动缩放
xheight | 指定高度,宽度根据原比例自动缩放
widthxheight | 指定宽度和高度的最大值,按原比例自动缩放
widthxheight^ | 指定宽度和高度的最小值,按原比例自动缩放
widthxheight! | 根据指定的宽度和高度缩放,忽略原比例
widthxheight> | 缩小图像尺寸到大于相应的宽度和高度参数
widthxheight< | 放大图像尺寸到大于相应的宽度和高度参数
area@	| 调整图像到指定面积的像素区域，保持原比例

---------------------------------------------------------------------------

# 边框

convert(或者 mogrify)命令可以给照片加一个相框。

例如：

```shell
convert -border 2 -bordercolor white avatar_small.png avatar_small_with_frame.png
```

![小头像](/avatar_small.png "小头像")
![有边框的小头像](/avatar_small_with_frame.png "有边框的小头像")

更加绚丽的例子:

```shell
convert -caption "my latest Polaroid" test.png \
-gravity center -background black +polaroid test_polaroid.png
```

----------------------------------------------------------------------------------

# 截屏
import命令是一个截取屏幕的好工具。

例1：

```shell
import window.jpg
```

现在用鼠标点击窗口

例2：

```shell
import -rotate 30 area.png
```

现在用鼠标拖一个矩形

例3，截取全屏：

```shell
sleep 5 ; import -window root all.tiff
```

---------------------------------------------------------------------------------

# 显示图片

显示图片在X server的系统中使用display命令.

例1：

```shell
display test.png
```

例2：

```shell
display http://cuihq.me/cli_text_image.jpg
```

---------------------------------------------------------------------------------

# 拼接图片

要拼接的图片

![向上箭头](/up.png "向上箭头")
![向下箭头](/down.png "向下箭头")
![向左箭头](/left.png "向左箭头")
![向右箭头](/right.png "向右箭头")

纵向拼接上下箭头图片：

```shell
convert up.png down.png -append up_down.jpg
```

拼接效果

> ![上下箭头](/up_down.jpg "上下箭头")

横向拼接当前工作目录所有的png图片(模式匹配符号*的解析依赖于特定的终端)：

```shell
convert *.png +append arrow.jpg
```

或者


```shell
montage *.png -geometry +1+1 -tile 4x1 arrow.png
```

拼接效果

> ![箭头](/arrow.jpg "箭头")

---------------------------------------------------------------------------------

# 合成图片

```shell
composite -gravity center avatar_small_with_frame.png qr_image.png qr_avatar.png
```

要合成的图片

![头像](/avatar_small_with_frame.png "头像")
![二维码](/qr_image.png "二维码")

合成效果

> ![头像二维码](/qr_avatar.png "头像二维码")

---------------------------------------------------------------------------------

# 比较图片

要拼接的图片

![包1](/bag_frame1.gif "包1")
![包2](/bag_frame2.gif "包2")


例1,静态比较：

```shell
compare bag_frame1.gif bag_frame2.gif compare.gif
```

比较效果

> ![静态比较](/compare.gif "静态比较")

例2，动态比较:

```shell
convert -delay 50 bag_frame1.gif bag_frame2.gif -loop 0 flicker_cmp.gif
```

比较效果

> ![动态比较](/flicker_cmp.gif "动态比较")

--------------------------------------------------------------------------

# 剪切图片

从（100，30）坐标剪切150宽度，200高度的尺寸的图片

```shell
convert test.jpg -crop 150x200+100+30 test_crop.png
```

![原图](/test.jpg "原图")
![剪切图](/test_crop.png "剪切图")

--------------------------------------------------------------------------

# 水波纹

振幅X波长

```shell
convert test.jpg -wave 50x250 test_wave.jpg
```

![原图](/test.jpg "原图")
![水波纹效果](/test_wave.jpg "水波纹效果")

---------------------------------------------------------------------------

# 倾斜

沿着X方向或者Y方向的角度

```shell
convert test.jpg -shear 20 test_shear.jpg
```

![原图](/test.jpg "原图")
![倾斜效果](/test_shear.jpg "倾斜效果")

---------------------------------------------------------------------------

# 旋转

将图片旋转一定的角度

向右旋转是正数，向左旋转是负数

```shell
convert up.png -rotate 90 -flip right.png
```

![向上箭头](/up.png "向上箭头")
![向右箭头](/right.png "向右箭头")

---------------------------------------------------------------------------

# 上下翻转

```shell
convert up.png -flip down.png
```

![向上箭头](/up.png "向上箭头")
![向下箭头](/down.png "向下箭头")

---------------------------------------------------------------------------

# 左右翻转

```shell
convert left.png -flop right.png
```

![向左箭头](/left.png "向左箭头")
![向右箭头](/right.png "向右箭头")

---------------------------------------------------------------------------

# 旋涡

以图片的中心作为参照，把图片扭转，形成漩涡的效果

```shell
convert test.jpg -swirl 45 test_swirl.jpg
```

![原图](/test.jpg "原图")
![旋涡效果](/test_swirl.jpg "旋涡效果")

---------------------------------------------------------------------------

# 铅笔画

形成铅笔画的效果

```shell
convert test.jpg -charcoal 2 test_charcoal.jpg
```

![原图](/test.jpg "原图")
![铅笔画效果](/test_charcoal.jpg "铅笔画效果")

---------------------------------------------------------------------------

# 着色

着色是将每个像素的颜色与指定颜色混合的过程。该效果的参数就是要用来混合的颜色。可以用一个百分数（它将分别用于红色、绿色和蓝色），也可以用三个百分数来指定这个参数。也可以提供三个实际值中的一个。要指定三个值，每个值分别代表红色、绿色和蓝色三个采样，使用 red/green/blue 形式的参数。例如， 10/20/30 意味着红色的值是 10、绿色值为 20 而蓝色值为 30。您也可以在这个构造中使用百分数

```shell
convert test.jpg -colorize 255 test_colorize.jpg
```

![原图](/test.jpg "原图")
![着色效果](/test_colorize.jpg "着色效果")

---------------------------------------------------------------------------

# 内爆

内爆效果模拟了您图像的中心被吸入虚拟黑洞的情形。所用的参数是您所期望的内爆效果量。

```shell
convert test.jpg -implode 4 test_implode.jpg
```

![原图](/test.jpg "原图")
![内爆效果](/test_implode.jpg "内爆效果")

---------------------------------------------------------------------------

# 曝光

曝光是在相片冲洗过程中把底片暴露在光线中所发生的效果。这里，输入参数是应用于该效果的亮度，可以指定为绝对值，也可以是可用于像素的最大可能值的百分数。如果像素超过阈值，则对它求反。 

```shell
convert test.jpg -solarize 40% test_solarize.jpg
```

![原图](/test.jpg "原图")
![曝光效果](/test_solarize.jpg "曝光效果")

---------------------------------------------------------------------------

# 毛玻璃

在图像之内以随机的数量移动像素。所用的参数是被移到新选择的位置的像素区域的大小。所以它指定了输出和输入的相似程度

```shell
convert test.jpg -spread 5 test_spread.jpg
```

![原图](/test.jpg "原图")
![毛玻璃效果](/test_spread.jpg "毛玻璃效果")

---------------------------------------------------------------------------

# 单色

将彩色图片变成黑白图片

```shell
convert test.jpg -monochrome test_monochrome.jpg
```

![原图](/test.jpg "原图")
![单色效果](/test_monochrome.jpg "单色效果")

---------------------------------------------------------------------------

# 棕褐色

照片暗室的棕褐色调色效果。
棕褐色调色阈值的范围从0到100%。
80%的阈值，是一个合理的起始点。

```shell
convert test.jpg -sepia-tone 80% test_sepia_tone.jpg
```

![原图](/test.jpg "原图")
![棕褐色效果](/test_sepia_tone.jpg "棕褐色效果")

---------------------------------------------------------------------------

# 反色

形成底片的样子

```shell
convert test.jpg -negate test_negate.jpg
```

![原图](/test.jpg "原图")
![反色效果](/test_negate.jpg "反色效果")

---------------------------------------------------------------------------

# 油画

将图片变成油画

```shell
convert test.jpg -paint 8 test_paint.jpg
```

![原图](/test.jpg "原图")
![油画效果](/test_paint.jpg "油画效果")

---------------------------------------------------------------------------

# 凸凹

用-raise来创建凸边效果, +raise来创建凹边效果

```shell
convert test.jpg -raise 5x5 test_raise.jpg
```

![原图](/test.jpg "原图")
![凸凹效果](/test_raise.jpg "凸凹效果")

---------------------------------------------------------------------------

# 模糊

将图片变得更模糊

```shell
convert test.jpg -blur 0x3 test_blue.jpg
```

![原图](/test.jpg "原图")
![模糊效果](/test_blue.jpg "模糊效果")

---------------------------------------------------------------------------

# 降噪

```shell
convert test.jpg -noise 5 test_noise.jpg
```

![原图](/test.jpg "原图")
![噪音效果](/test_noise.jpg "噪音效果")

---------------------------------------------------------------------------

# 浮雕

浮雕效果

```shell
convert test.jpg -emboss 10 test_emboss.jpg
```

![原图](/test.jpg "原图")
![浮雕效果](/test_emboss.jpg "浮雕效果")

---------------------------------------------------------------------------

# 阴影

```shell
convert test.jpg -shade 12x50 test_shade.jpg
```

![原图](/test.jpg "原图")
![阴影效果](/test_shade.jpg "阴影效果")

---------------------------------------------------------------------------

# 调制

调整亮度,饱和度,色彩

```shell
convert test.jpg -modulate 200,100 test_modulate.jpg
```

![原图](/test.jpg "原图")
![调制效果](/test_modulate.jpg "调制效果")

---------------------------------------------------------------------------

# 边缘锐化

```shell
convert test.jpg -edge 1 test_edge.jpg
```

![原图](/test.jpg "原图")
![边缘锐化效果](/test_edge.jpg "边缘锐化效果")

---------------------------------------------------------------------------

# 锐化

```shell
convert test.jpg -sharpen 3 test_sharpen.jpg
```

![原图](/test.jpg "原图")
![锐化效果](/test_sharpen.jpg "锐化效果")

---------------------------------------------------------------------------

# 图象增强

使用数字滤波器来增强一个噪声图像

```shell
convert test.jpg -enhance test_enhance.jpg
```

![原图](/test.jpg "原图")
![图象增强](/test_enhance.jpg "图象增强")

---------------------------------------------------------------------------

# 色彩均匀

按通道进行图像的直方图均衡化

```shell
convert test.jpg -equalize test_equalize.jpg
```

![原图](/test.jpg "原图")
![色彩均匀](/test_equalize.jpg "色彩均匀")

---------------------------------------------------------------------------

# 素描

```shell
convert test.jpg -sketch 5 test_sketch.jpg
```

![原图](/test.jpg "原图")
![素描](/test_sketch.jpg "素描")











