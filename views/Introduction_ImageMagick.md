# 简介

ImageMagic 是一个开源的创建、编辑、合成或转换位图的软件集。

* 开源: 采用Apache 2.0 协议，可以免费商用;
* 软件集: 超过10个命令;
* 位图: 超过100种图片格式。

参考资料：
[ImageMagic官网](http://www.imagemagick.org/)
[getting started with imagemagick](http://www.slideshare.net/bbbart/getting-started-with-imagemagick)

---------------------------------------------------------------------

# 语言及平台

Ruby程序语言支持: [MiniMagick](http://rubyforge.org/projects/mini-magick)

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
* animate: animates an image or image sequence
* compare: annotates the difference between images
* composite: overlaps one image over another
* conjure: execures scripts in the Magick Scripting Language
* display: displays an image or image sequence
* mogirfy: is like convert but works on the original image file
* montage: creates an image by combining several images

----------------------------------------------------------------------

# 图片格式转换

例子:

```shell
$ convert test.png test.jpg
```

ImageMagick会从文件后缀名猜测文件格式。


-----------------------------------------------------------------------

# 图像识别

例1:

```
$ identify test.jpg
test.jpg JPEG 293x220 293x220+0+0 8-bit sRGB 6.12KB 0.000u 0:00.000
```

例2:

```
$ identify test.png
test.png PNG 293x220 293x220+0+0 8-bit sRGB 36.3KB 0.000u 0:00.000
```

-----------------------------------------------------------------------

# 改变图像尺寸

使用convert或mogrify命令。后面是-scale开关项。

例1:

```shell
$ convert -scale 100x250 test.png test_small.png
```

例2：

```shell
$ mogrify -scale 100 test.jpg
```

-scale开关项有一个尺寸(geometry)作为参数。 尺寸参数格式为 <W>x<h>
  <W> 是宽度;
  <H> 是高度.
其中一个可以省略!

---------------------------------------------------------------------------

# 边框

convert(或者 mogrify)命令可以给照片加一个相框。

例如：

```shell
$ convert -border 2 -bordercolor black test.png test_frame.png
```

更加绚丽的例子:

```shell
$ convert -caption "my latest Polaroid" test.png \
-gravity center -background black +polaroid test_polaroid.png
```

----------------------------------------------------------------------------------

# 截屏
import命令是一个截取屏幕的好工具。

例1：

```shell
$ import window.jpg
# 现在用鼠标点击窗口
```

例2：

```shell
$ import -rotate 30 area.png
# 现在用鼠标拖一个矩形
```

例3，截取全屏：

```shell
$ sleep 5 ; import -window root all.tiff
```

