网页的图标
==========
网页中图标是图片的一种，但有标识含义，且尺寸较小。
效果如下：

> ![图标](/favicon.ico "替代文字")文字

--------------------------------------------------

## 使用方法
1. html
2. css
3. inline image
4. sprite image
5. icon fonts
6. 其它

--------------------------------------------------

## 1. html
这是最简单的一种形式。

优点|缺点
----|----
简单、直接、粗暴|不符合表现与内容分开的原则

例子：

```html
<img src="/favicon.ico">文字
```

----------------------------------------------------

## 2. CSS
这是最常用的一种形式。

优点|缺点
----|----
可控制图标的更多的显示样式|不够直观

例子：

```html
<span class='icon'></span>文字
```

```css
.icon {
  display: inline-block;
  background: url(/favicon.ico) no-repeat;
  width: 32px;
  height: 32px;
}
```

--------------------------------------------------------

## 3. inline image
根据[RFC 2397](http://tools.ietf.org/html/rfc2397)标准，inline image的格式如下:
> data:\[\<mediatype\>\]\[;base64\],\<data\>

优点|缺点
----|----
减少HTTP请求|可维护性，可读性，兼容性差


例1:

```html
<img src="data:image/x-icon;base64,AAABAAEAICA..." />
```

例2：

```css
.icon {
  width:32px;
  height:32px;
  background-image: url(data:image/x-icon;base64,AAABAAEAICA...);
}
```

### 资源和工具

[websemantics](http://websemantics.co.uk/online_tools/image_to_data_uri_convertor/), 免费在线图片转换

----------------------------------------------------------------------------------------

## 4. sprint image
将多个图标合成一个图片，并用CSS控制。

优点|缺点
----|----
减少HTTP请求|放大光标失真

---------------------------------------------------

### 例子：

```css
.icons-adduser, .icons-delete {
  background: url('/icons.png') no-repeat;
}

.icons-adduser {
  background-position: 0 0;
}

.icons-delete {
  background-position: 0 -16px;
}
```

合成图标如下:
> ![合成图标](/icons.png "合成图标")


### 资源和工具

[compass](http://compass-style.org/help/tutorials/spriting/), 进行合成图片的一种方法

--------------------------------------------------------------

## 5. icon fonts
将图标编码成字体，并使用CSS进行控制。

优点|缺点
----|----
灵活，方便，减少HTTP请求|不支持彩色图片

---------------------------------------------

### 例子：

```css
@font-face {
  font-family: "font-icon";
  src: url("/font-icon.woff");
}
.search:before {
  content: "s";
  display: block;
  font-family: font-icon;
}
```

```html
<div class="search">搜索</div>
```

### 资源和工具：

[fontsquirrel](http://www.fontsquirrel.com/)，有一些免费字体图标

[FontCreator](http://www.high-logic.com/)，可制作自定义字体图标

-------------------------------------------------------

## 6. 其它

+ 图标的形式还有很多，如CSS图标
+ 没有最好的图标，只有最适用的图标
+ 如需转载，请注明出处，并格式化相关代码与注释

