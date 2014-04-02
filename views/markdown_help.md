see also [markdown syntax](http://daringfireball.net/projects/markdown/syntax)

另见 [markdown语法](http://wowubuntu.com/markdown)

HTML
====
```html
<table>
  <tr>
    <td>表格</td>
  </tr>
</table>
```

特殊字符
========
```markdown
http://images.google.com/images?num=30&q=larry+bird
&copy;
AT&T
4 < 5
```

段落和换行
===
```markdown
这是一个段落，后面有一个空行

这是一行,后面有两个空格  
这是另一行
```
这是一个段落，后面有一个空行

这是一行,后面有两个空格  
这是另一行

标题
====
```markdown
标题 1
==
标题 2
------
# 标题 1 #
## 标题 2
### 标题 3 ######
```

块引用
======
```markdown
> 一段块引用。
> 换行显示
>
> 另一段块引用。
>> 块引用中的块引用

> ## 包含标题的块引用
```

列表
====
无序列表
--------
```markdown
+ 红色
- 绿色
+ 蓝色
* 紫色
- 白色
- 黑色
```
有序列表
--------
```markdown
5. 首先
2. 其次
3. 再次
```

水平线
======
```markdown
* * *
***
*****
- - -
------------
```

超链接
======
```markdown
[一个带标题超链接](http://example.com/ "标题")
[没有标题属性超链接](http://example.com/)
[内部超链接](/robots.txt)
[标记连接的例子][id]。
[id]: http://example.com/  "可选的标题"  
```

图片
====
```markdown
![图片](/favicon.ico)
![图片](/favicon.ico "替代文字")
```

强调
====
```markdown
*强调文字*
_强调文字_
**强调文字**
__强调文字__
```

自动连接
=======
```markdown
<http://example.com/>
<address@example.com>
```

转义字符
=======
```markdown
\\   反斜线
\`   反引号
\*   星号
\_   底线
\{\}  花括号
\[\]  方括号
\(\)  括弧
\#   井字号
\+   加号
\-   减号
\.   英文句点
\!   惊叹号
```

markdown方言
============
表格
----
```markdown
标题1 | 标题2
------|------
内容1 | 内容2
内容3 | 内容4

|标题1|标题2|
|-----+-----|
|内容1|内容2|
|内容3|内容4|
```
标题
----
```markdown
#######
#标题1#
#######
```
上标
----
```markdown
这是^(上标)
```
代码
----
> \`\`\`  
  代码  
  \`\`\`