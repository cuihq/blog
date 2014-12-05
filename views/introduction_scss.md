# scss 简介

**scss**是**CSS**的扩展语言。
通过输入scss语言，编译成css语言。  
它兼容csss语法，并允许你使用变量，函数等语法以及嵌套,继承等特性。  
了解更多，请参见[scss官网](http://sass-lang.com/ "scss官网")。

## 安装和使用

安装命令：

```bash
gem install sass
```

将**scss**转换成**CSS**的命令：

```bash
scss input.scss output.css
```

你也可以告诉**scss**文件，每次更新**CSS**时**scss**更改:

```bash
scss --watch input.scss:output.csss
```
或者文件夹:

```bash
scss --watch app/sass:public/stylesheets
```

更多命令，请在命令行中输入`scss --help`

ruby中调用

```ruby
engine = Sass::Engine.new("#main {color: #fff}", syntax: :scss)
engine.render
```

## 输出方式
通过程序中`:style`选项或者命令行中的`--style`来控制,
编译的**CSS**有四种方式输出：

* 嵌套`:nested`
* 展开`:expanded`
* 紧凑`:compact`
* 压缩`:compressed`

### 嵌套输出
这是默认的输出方式，输出的CSS如下：

```css
#main {
  color: #fff;
  background-color: #000; }
  #main p {
    width: 10em; }

.huge {
  font-size: 10em;
  font-weight: bold;
  text-decoration: underline; }
```

### 展开输出

这比较适合人阅读：

```css
#main {
  color: #fff;
  background-color: #000;
}
#main p {
  width: 10em;
}

.huge {
  font-size: 10em;
  font-weight: bold;
  text-decoration: underline;
}
```

### 紧凑输出

这种输出方式节省空间：

```css
#main { color: #fff; background-color: #000; }
#main p { width: 10em; }

.huge { font-size: 10em; font-weight: bold; text-decoration: underline; }
```

### 压缩输出

这种输出方式试用与生产环境：

```css
#main{color:#fff;background-color:#000}#main p{width:10em}.huge{font-size:10em;font-weight:bold;text-decoration:underline}
```

## 语法

* 注释
* 数据类型
* 变量
* 操作符
* 控制指令(判断和循环)
* 函数

### 注释

* 多行注释使用`/*`和`*/`包围
* 单行注释使用`//`开始  

例如：

```scss
// 这是一行注释
/* 这是多行注释
注释第二行
*/
```

### 数据类型

* 数字 (如 1.2, 13, 10px)
* 文本字符串, 可以不用引号 (如 "foo", 'bar', baz)
* 颜色 (如 blue, #04a3f9, rgba(255, 0, 0, 0.5))
* 布尔值 (如 true, false)
* 控制 (如 null)
* 树组, 以空格或者`,`逗号分隔 (如. 1.5em 1em 0 2em, Helvetica, Arial, sans-serif)
* 健值对 (如 (key1: value1, key2: value2))

### 变量
符号`$`为变量符号。
可以将颜色，字体等提取成变量。
不同的主题采用不同的变量值，以方便重用。
**scss**：

```scss
$font-stack:    Helvetica, sans-serif;
$primary-color: #333;
body {
  font: 100% $font-stack;
  color: $primary-color;
}
```

编译并展开的**css**结果：

```css
body {
  font: 100% Helvetica, sans-serif;
  color: #333;
}
```

可以使用`!default`来定义一个默认值,
`null`和没有赋值时,会使用默认值：

```scss
$content: "First content";
$content: "Second content?" !default;
$content1: "First time reference" !default;
$content2: null;
$content2: "Non-null content" !default;

#main {
  content: $content;
  content1: $new_content;
  content2: $content2;
}
```

编译并展开的**css**结果：

```css
#main {
  content: "First content";
  content1: "First time reference";
  content2: "Non-null content";
}
```

### 操作符
**scss**支持`+`，`-`，`*`，`/`和`%`运算操作符，
和`==`，` !=`，`>`，`<`，`>=`，`<=`布尔操作符。

```scss
.container { width: 100%; }

article[role="main"] {
  float: left;
  width: 600px / 960px * 100%;
}

aside[role="complimentary"] {
  float: right;
  width: 300px / 960px * 100%;
}
```

编译并展开后的**css**结果为：

```css
.container {
  width: 100%;
}

article[role="main"] {
  float: left;
  width: 62.5%;
}

aside[role="complimentary"] {
  float: right;
  width: 31.25%;
}
```

### 控制指令

#### 判断分支
`@if`指令用于判断分支

```scss
$type: monster;
p {
  @if $type == ocean {
    color: blue;
  } @else if $type == monster {
    color: red;
  } @else {
    color: black;
  }
}
```

编译并展开的css结果：

```css
p {
  color: red;
}
```

#### 循环分支
`@for`或`@while`指令用于出来循环

```scss
@for $i from 1 through 3 {
  .item-#{$i} { width: 2em * $i; }
}
$i: 6;
@while $i > 0 {
  .item-#{$i} { width: 2em * $i; }
  $i: $i - 2;
}
```

编译并展开的css结果：

```css
.item-1 {
  width: 2em;
}
.item-2 {
  width: 4em;
}
.item-3 {
  width: 6em;
}
```

`@each`指令用于枚举树组或集合

```
@each $animal in puma, sea-slug, egret {
  .#{$animal}-icon {
    background-image: url('/images/#{$animal}.png');
  }
}
@each $header, $size in (h1: 2em, h2: 1.5em) {
  #{$header} {
    font-size: $size;
  }
}
```

编译并展开的css结果：

```
.puma-icon {
  background-image: url('/images/puma.png');
}
.sea-slug-icon {
  background-image: url('/images/sea-slug.png');
}
.egret-icon {
  background-image: url('/images/egret.png');
}
h1 {
 font-size: 2em;
}
h2 {
  font-size: 1.5em;
}
h3 {
  font-size: 1.2em;
}
```

多个值的使用：

```scss
@each $animal, $color, $cursor in (puma, black, default),
(sea-slug, blue, pointer),
(egret, white, move) {
  .#{$animal}-icon {
    background-image: url('/images/#{$animal}.png');
    border: 2px solid $color;
    cursor: $cursor;
  }
}
```

编译并展开的css结果：

```css
.puma-icon {
  background-image: url('/images/puma.png');
  border: 2px solid black;
  cursor: default;
}
.sea-slug-icon {
  background-image: url('/images/sea-slug.png');
  border: 2px solid blue;
  cursor: pointer;
}
.egret-icon {
  background-image: url('/images/egret.png');
  border: 2px solid white;
  cursor: move;
}
```

### 函数
`@function`指令用户创建函数，一个函数必须使用`@return`指定返回值

```scss
$grid-width: 40px;
$gutter-width: 10px;

@function grid-width($n) {
  @return $n * $grid-width + ($n - 1) * $gutter-width;
}

#sidebar { width: grid-width(5); }
```

其中,scss中内置了很多有用的函数,如:

```scss
// 取得几个数中的最大值
max($val1, $val2， 5)
// 取得一个指定透明度颜色的函数
rgba($color, $alpha)
```

更多内置函数请访问[SCSS API](http://sass-lang.com/documentation/Sass/Script/Functions.html)
## 规则
* 嵌套规则
* 导入规则
* 混入规则
* 继承规则

### 嵌套规则
html的节点是一个树形结构。
scss也是一个树形节点,这比css在结构上更直观。
嵌套规则中的`&`代表父节点。  
**scss**：

```scss
#main {
  color: black;
  width: 97%;
  a {
    color: black;
    font-weight: bold;
    &:hover { color: red; }
    body.firefox & { font-weight: normal; }
    &-sidebar { border: 1px solid; }
  }
}
```

编译并展开的**css**结果：

```css
#main {
  color: black;
  width: 97%;
}
#main a {
  color: black;
  font-weight: bold;
}
#main a:hover {
  color: red;
}
body.firefox #main a {
  font-weight: normal;
}
#main a-sidebar {
  border: 1px solid;
}
```

也可以嵌套属性, 例如：

```scss
.funky {
  font: 20px/24px fantasy {
    weight: bold;
  }
}
```

编译并展开的css结果：

```css
.funky {
  font: 20px/24px fantasy;
  font-weight: bold;
}
```

可以使用`@at-root`指令忽略嵌套，如：

```scss
.parent {
  ...
  @at-root {
    .child1 { ... }
    .child2 { ... }
  }
  .step-child { ... }
}
```

编译并展开的**css**结果：

```css
.parent { ... }
.child1 { ... }
.child2 { ... }
.parent .step-child { ... }
```

### 导入规则
与**css**的规则相似，`@import`用于导入外部的文件。  
这样更容易按照模块或功能来进行组织与划分。  
**注意**： 导入的**scss**文件以`_`下划线开始。
例如：有一个*_reset.scss*文件

```scss
// _reset.scss
html,
body,
ul,
ol {
  margin: 0;
  padding: 0;
}
```

被*base.scss*文件导入

```scss
/* base.scss */

@import 'reset'; //或者@import 'reset.scss';

body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```

编译并展开的css的结果为：

```css
html, body, ul, ol {
  margin: 0;
  padding: 0;
}

body {
  font: 100% Helvetica, sans-serif;
  background-color: #efefef;
}
```

`@import`不仅可以引用scss文件，还可以引入css文件。

```scss
@import "foo.css";
@import "foo" screen;
@import "http://foo.com/bar";
@import url(foo);
```

将编译成的css为:

```css
@import "foo.css";
@import "foo" screen;
@import "http://foo.com/bar";
@import url(foo);
```

更多用法如下：

```scss
// 导入多个scss文件
@import "rounded-corners", "text-shadow";
// 导入网络文件
@import "http://foo.com/bar";
// 动态的引入文件
$family: unquote("Droid+Sans");
@import url("http://fonts.googleapis.com/css?family=#{$family}");
//和嵌套规则一起使用
#main {
  @import "example";
}
```

### 混入规则
`@mixin`指令创建一个引入块，`@include`进行混入

```scss
@mixin border-radius($radius) {
  -webkit-border-radius: $radius;
  -moz-border-radius: $radius;
  -ms-border-radius: $radius;
  border-radius: $radius;
}

.box { @include border-radius(10px); }
```

编译并展开后的**css**结果为：

```css
.box {
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  -ms-border-radius: 10px;
  border-radius: 10px;
}
```

混入时可以通过`@content`传入内容块:

```scss
$color: white;
@mixin colors($color: blue) {
  background-color: $color;
  @content;
  border-color: $color;
}
.colors {
  @include colors { color: $color; }
}
```

编译并展开后的**css**结果为：

```css
.colors {
  background-color: blue;
  color: white;
  border-color: blue;
}
```

### 继承规则
使用`@extend`指令继承。

```scss
.message {
  border: 1px solid #ccc;
  padding: 10px;
  color: #333;
}

.success {
  @extend .message;
  border-color: green;
}

.error {
  @extend .message;
  border-color: red;
}

.warning {
  @extend .message;
  border-color: yellow;
}
```

编译并展开后的**css**结果为：

```css
.message, .success, .error, .warning {
  border: 1px solid #cccccc;
  padding: 10px;
  color: #333;
}

.success {
  border-color: green;
}

.error {
  border-color: red;
}

.warning {
  border-color: yellow;
}
```

在继承中可以使用`%`来代替`#`或者`.`选择器，如：

```scss
// 渲染的结果不会包含extreme自己
#context a%extreme {
  color: blue;
  font-weight: bold;
  font-size: 2em;
}
.notice {
  @extend %extreme;
}
```

编译并展开后的**css**结果为：

```css
#context a.notice {
  color: blue;
  font-weight: bold;
  font-size: 2em; }
```
