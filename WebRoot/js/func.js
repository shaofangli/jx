/*
 "^\d+$"　　//非负整数（正整数 + 0） 
"^[0-9]*[1-9][0-9]*$"　　//正整数 
"^((-\d+)(0+))$"　　//非正整数（负整数 + 0） 
"^-[0-9]*[1-9][0-9]*$"　　//负整数 
"^-?\d+$"　　　　//整数 
"^\d+(\.\d+)?$"　　//非负浮点数（正浮点数 + 0） 
"^(([0-9]+\.[0-9]*[1-9][0-9]*)([0-9]*[1-9][0-9]*\.[0-9]+)([0-9]*[1-9][0-9]*))$"　　//正浮点数 
"^((-\d+(\.\d+)?)(0+(\.0+)?))$"　　//非正浮点数（负浮点数 + 0） 
"^(-(([0-9]+\.[0-9]*[1-9][0-9]*)([0-9]*[1-9][0-9]*\.[0-9]+)([0-9]*[1-9][0-9]*)))$"　　//负浮点数 
"^(-?\d+)(\.\d+)?$"　　//浮点数 
"^[A-Za-z]+$"　　//由26个英文字母组成的字符串 
"^[A-Z]+$"　　//由26个英文字母的大写组成的字符串 
"^[a-z]+$"　　//由26个英文字母的小写组成的字符串 
"^[A-Za-z0-9]+$"　　//由数字和26个英文字母组成的字符串 
"^\w+$"　　//由数字、26个英文字母或者下划线组成的字符串 
"^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$"　　　　//email地址 
"^[a-zA-z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$"　　//url
/^(d{2}d{4})-((0([1-9]{1}))(1[12]))-(([0-2]([1-9]{1}))(3[01]))$/   //  年-月-日
/^((0([1-9]{1}))(1[12]))/(([0-2]([1-9]{1}))(3[01]))/(d{2}d{4})$/   // 月/日/年
"^([w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)(([w-]+.)+))([a-zA-Z]{2,4}[0-9]{1,3})(]?)$"   //Emil
/^((\+?[0-9]{2,4}\-[0-9]{3,4}\-)([0-9]{3,4}\-))?([0-9]{7,8})(\-[0-9]+)?$/     //电话号码
"^(d{1,2}1dd2[0-4]d25[0-5]).(d{1,2}1dd2[0-4]d25[0-5]).(d{1,2}1dd2[0-4]d25[0-5]).(d{1,2}1dd2[0-4]d25[0-5])$"   //IP地址

匹配中文字符的正则表达式： [\u4e00-\u9fa5]
匹配双字节字符(包括汉字在内)：[^\x00-\xff]
匹配空行的正则表达式：\n[\s ]*\r
匹配HTML标记的正则表达式：/<(.*)>.*<\/\1><(.*) \/>/
匹配首尾空格的正则表达式：(^\s*)(\s*$)
匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
匹配网址URL的正则表达式：^[a-zA-z]+://(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))*(\\?\\S*)?$
匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
匹配国内电话号码：(\d{3}-\d{4}-)?(\d{8}\d{7})?
匹配腾讯QQ号：^[1-9]*[1-9][0-9]*$


元字符及其在正则表达式上下文中的行为： 

\ 将下一个字符标记为一个特殊字符、或一个原义字符、或一个后向引用、或一个八进制转义符。

^ 匹配输入字符串的开始位置。如果设置了 RegExp 对象的Multiline 属性，^ 也匹配 ’\n’ 或 ’\r’ 之后的位置。 

$ 匹配输入字符串的结束位置。如果设置了 RegExp 对象的Multiline 属性，$ 也匹配 ’\n’ 或 ’\r’ 之前的位置。 

* 匹配前面的子表达式零次或多次。 

+ 匹配前面的子表达式一次或多次。+ 等价于 {1,}。 

? 匹配前面的子表达式零次或一次。? 等价于 {0,1}。 

{n} n 是一个非负整数，匹配确定的n 次。

{n,} n 是一个非负整数，至少匹配n 次。 

{n,m} m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次。在逗号和两个数之间不能有空格。

? 当该字符紧跟在任何一个其他限制符 (*, +, ?, {n}, {n,}, {n,m}) 后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。 

. 匹配除 "\n" 之外的任何单个字符。要匹配包括 ’\n’ 在内的任何字符，请使用象 ’[.\n]’ 的模式。 
(pattern) 匹配pattern 并获取这一匹配。 

(?:pattern) 匹配pattern 但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。 

(?=pattern) 正向预查，在任何匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。 

(?!pattern) 负向预查，与(?=pattern)作用相反 

xy 匹配 x 或 y。 

[xyz] 字符集合。 

[^xyz] 负值字符集合。 

[a-z] 字符范围，匹配指定范围内的任意字符。 

[^a-z] 负值字符范围，匹配任何不在指定范围内的任意字符。 

\b 匹配一个单词边界，也就是指单词和空格间的位置。

\B 匹配非单词边界。 

\cx 匹配由x指明的控制字符。 

\d 匹配一个数字字符。等价于 [0-9]。 

\D 匹配一个非数字字符。等价于 [^0-9]。 

\f 匹配一个换页符。等价于 \x0c 和 \cL。 

\n 匹配一个换行符。等价于 \x0a 和 \cJ。 

\r 匹配一个回车符。等价于 \x0d 和 \cM。 

\s 匹配任何空白字符，包括空格、制表符、换页符等等。等价于[ \f\n\r\t\v]。 

\S 匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。 

\t 匹配一个制表符。等价于 \x09 和 \cI。 

\v 匹配一个垂直制表符。等价于 \x0b 和 \cK。 

\w 匹配包括下划线的任何单词字符。等价于’[A-Za-z0-9_]’。 

\W 匹配任何非单词字符。等价于 ’[^A-Za-z0-9_]’。 

\xn 匹配 n，其中 n 为十六进制转义值。十六进制转义值必须为确定的两个数字长。

\num 匹配 num，其中num是一个正整数。对所获取的匹配的引用。 

\n 标识一个八进制转义值或一个后向引用。如果 \n 之前至少 n 个获取的子表达式，则 n 为后向引用。否则，如果 n 为八进制数字 (0-7)，则 n 为一个八进制转义值。 

\nm 标识一个八进制转义值或一个后向引用。如果 \nm 之前至少有is preceded by at least nm 个获取得子表达式，则 nm 为后向引用。如果 \nm 之前至少有 n 个获取，则 n 为一个后跟文字 m 的后向引用。如果前面的条件都不满足，若 n 和 m 均为八进制数字 (0-7)，则 \nm 将匹配八进制转义值 nm。 

\nml 如果 n 为八进制数字 (0-3)，且 m 和 l 均为八进制数字 (0-7)，则匹配八进制转义值 nml。 

\un 匹配 n，其中 n 是一个用四个十六进制数字表示的Unicode字符。

匹配中文字符的正则表达式： [u4e00-u9fa5]

匹配双字节字符(包括汉字在内)：[^x00-xff]

匹配空行的正则表达式：n[s ]*r

匹配HTML标记的正则表达式：/<(.*)>.*</1><(.*) />/ 

匹配首尾空格的正则表达式：(^s*)(s*$)

匹配Email地址的正则表达式：w+([-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*

匹配网址URL的正则表达式：http://([w-]+.)+[w-]+(/[w- ./?%&=]*)?

利用正则表达式限制网页表单里的文本框输入内容：

用正则表达式限制只能输入中文：onkeyup="value=value.replace(/[^u4E00-u9FA5]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^u4E00-u9FA5]/g,''))" 

用正则表达式限制只能输入全角字符： onkeyup="value=value.replace(/[^uFF00-uFFFF]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^uFF00-uFFFF]/g,''))"

用正则表达式限制只能输入数字：onkeyup="value=value.replace(/[^d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^d]/g,''))"

用正则表达式限制只能输入数字和英文：onkeyup="value=value.replace(/[W]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^d]/g,''))"

=========常用正则式



匹配中文字符的正则表达式： [\u4e00-\u9fa5]

匹配双字节字符(包括汉字在内)：[^\x00-\xff]

匹配空行的正则表达式：\n[\s ]*\r

匹配HTML标记的正则表达式：/<(.*)>.*<\/\1><(.*) \/>/ 

匹配首尾空格的正则表达式：(^\s*)(\s*$)

匹配IP地址的正则表达式：/(\d+)\.(\d+)\.(\d+)\.(\d+)/g //

匹配Email地址的正则表达式：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*

匹配网址URL的正则表达式：http://(/[\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?

sql语句：^(selectdropdeletecreateupdateinsert).*$

1、非负整数：^\d+$ 

2、正整数：^[0-9]*[1-9][0-9]*$ 

3、非正整数：^((-\d+)(0+))$ 

4、负整数：^-[0-9]*[1-9][0-9]*$ 

5、整数：^-?\d+$ 

6、非负浮点数：^\d+(\.\d+)?$ 

7、正浮点数：^((0-9)+\.[0-9]*[1-9][0-9]*)([0-9]*[1-9][0-9]*\.[0-9]+)([0-9]*[1-9][0-9]*))$ 

8、非正浮点数：^((-\d+\.\d+)?)(0+(\.0+)?))$ 

9、负浮点数：^(-((正浮点数正则式)))$ 

10、英文字符串：^[A-Za-z]+$ 

11、英文大写串：^[A-Z]+$ 

12、英文小写串：^[a-z]+$ 

13、英文字符数字串：^[A-Za-z0-9]+$ 

14、英数字加下划线串：^\w+$ 

15、E-mail地址：^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$ 

16、URL：^[a-zA-Z]+://(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\s*)?$ 
或：^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$

17、邮政编码：^[1-9]\d{5}$

18、中文：^[\u0391-\uFFE5]+$

19、电话号码：^((\(\d{2,3}\))(\d{3}\-))?(\(0\d{2,3}\)0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$

20、手机号码：^((\(\d{2,3}\))(\d{3}\-))?13\d{9}$ 
			/^(13[0-9]{9})|(15[89][0-9]{8})$/

21、双字节字符(包括汉字在内)：^\x00-\xff

22、匹配首尾空格：(^\s*)(\s*$)（像vbscript那样的trim函数）

23、匹配HTML标记：<(.*)>.*<\/\1><(.*) \/> 

24、匹配空行：\n[\s ]*\r

25、提取信息中的网络链接：(hH)(rR)(eE)(fF) *= *('")?(\w\\\/\.)+('" *>)?

26、提取信息中的邮件地址：\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*

27、提取信息中的图片链接：(sS)(rR)(cC) *= *('")?(\w\\\/\.)+('" *>)?

28、提取信息中的IP地址：(\d+)\.(\d+)\.(\d+)\.(\d+)

29、提取信息中的中国手机号码：(86)*0*13\d{9}

30、提取信息中的中国固定电话号码：(\(\d{3,4}\)\d{3,4}-\s)?\d{8}

31、提取信息中的中国电话号码（包括移动和固定电话）：(\(\d{3,4}\)\d{3,4}-\s)?\d{7,14}

32、提取信息中的中国邮政编码：[1-9]{1}(\d+){5}

33、提取信息中的浮点数（即小数）：(-?\d*)\.?\d+

34、提取信息中的任何数字 ：(-?\d*)(\.\d+)? 

35、IP：(\d+)\.(\d+)\.(\d+)\.(\d+)

36、电话区号：/^0\d{2,3}$/

37、腾讯QQ号：^[1-9]*[1-9][0-9]*$

38、帐号(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$

39、中文、英文、数字及下划线：^[\u4e00-\u9fa5_a-zA-Z0-9]+$
*/

function inverse($f) {
    for ($i = 0; $i < $f.elements.length; $i++) {
        if ($f.elements[$i].type == "checkbox") {
            $f.elements[$i].checked = !$f.elements[$i].checked;
        }
    }
    return false;
}

function checkAll($f) {
    for ($i = 0; $i < $f.elements.length; $i++) {
        if ($f.elements[$i].type == "checkbox") {
            $f.elements[$i].checked = true;
        }
    }
    return false;
}

/**
 * Requires prototype.js (http://prototype.conio.net/)
 */
Ajax.ImgUpdater = Class.create();
Ajax.ImgUpdater.prototype = {
    initialize: function(imgID, timeout, newSrc) {
        this.img = document.getElementById(imgID);
        if (newSrc) {
            this.src = newSrc;
        } else {
            this.src = this.img.src;
        }
        this.timeout = timeout;
        this.start();
    },

    start: function() {
        var now = new Date();
        this.img.src = this.src + '&t=' + now.getTime();
        this.timer = setTimeout(this.start.bind(this), this.timeout * 1000);
    },

    stop: function() {
        if (this.timer) clearTimeout(this.timer);
    }
}

function togglePanel(container, remember_url) {
    if (Element.getStyle(container, "display") == 'none') {
        if (remember_url) {
            new Ajax.Request(remember_url, {method:'get',asynchronous:true, parameters: 'state=on'});
        }
        if (document.getElementById('invisible_' + container)) {
            Element.hide('invisible_' + container);
        }
        if (document.getElementById('visible_' + container)) {
            Element.show('visible_' + container);
        }

        Effect.Grow(container);
    } else {
        if (remember_url) {
            new Ajax.Request(remember_url, {method:'get',asynchronous:true, parameters: 'state=off'});
        }
        if (document.getElementById('visible_' + container)) {
            Element.hide('visible_' + container);
        }
        if (document.getElementById('invisible_' + container)) {
            Element.show('invisible_' + container);
        }
        Effect.Shrink(container);
    }
    return false;
}

function scaleImage(v, min, max) {
    var images = document.getElementsByClassName('scale-image');
    w = (max - min) * v + min;
    for (i = 0; i < images.length; i++) {
        images[i].style.width = w + 'px';
    }
}

function toggleAndReloadPanel(container, url) {
    if (Element.getStyle(container, "display") == 'none') {
        new Ajax.Updater(container, url);
        Effect.BlindDown(container);
    } else {
        Effect.Shrink(container);
    }
}

function getWindowHeight() {
    var myHeight = 0;
    if (typeof( window.innerHeight ) == 'number') {
        //Non-IE
        myHeight = window.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight) {
        //IE 6+ in 'standards compliant mode'
        myHeight = document.documentElement.clientHeight;
    } else if (document.body && document.body.clientHeight) {
        //IE 4 compatible
        myHeight = document.body.clientHeight;
    }
    return myHeight;
}

function getWindowWidth() {
    var myWidth = 0;
    if (typeof( window.innerWidth ) == 'number') {
        //Non-IE
        myWidth = window.innerWidth;
    } else if (document.documentElement && document.documentElement.clientWidth) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
    } else if (document.body && document.body.clientWidth) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
    }
    return myWidth;
}

var helpTimerID;

function setupHelpToggle(url) {
    rules = {
        'li#abbreviations': function(element) {
            element.onclick = function() {
                help_container = 'help';
                if (Element.getStyle(help_container, "display") == 'none') {
                    new Ajax.Updater(help_container, url);
                }
                Effect.toggle(help_container, 'appear');
                if (helpTimerID) clearTimeout(helpTimerID)
                helpTimerID = setTimeout('Effect.Fade("' + help_container + '")', 15000);
                return false;
            }
        }
    }
    Behaviour.register(rules);
}

function addAjaxTooltip(activator, tooltip, url) {
    Tooltip.closeText = null;
    Tooltip.autoHideTimeout = null;
    Tooltip.showMethod = function(e) {
        Effect.Appear(e, {to: 0.9});
    }

    Tooltip.add(activator, tooltip);
    tt_container = $$('#' + tooltip + ' .tt_content')[0];
    Event.observe(activator, 'click', function(e) {

        t_title = $('tt_title');

        if (t_title) t_title.hide();

        tt_container.style.width = '300px';

        tt_container.innerHTML = '<div class="ajax_activity">&nbsp;</div>';
        new Ajax.Updater(tt_container, url, {method: 'get'}).onComplete = function () {
            tt_container.style.width = null;
            the_title = $('tooltip_title');
            t_title = $('tt_title');

            if (the_title && t_title) {
                the_title.hide();
                t_title.innerHTML = the_title.innerHTML;
                t_title.show();
            }
        };
    });
}
