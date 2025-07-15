---
title: Fcrackzip中文手册
date: 2025-07-15 21:22:53
tags: 取证Forensic
permalink: /Fcrackzip中文手册/
---

## Fcrackzip 中文教程

## 1. 工具介绍

Fcrackzip 是一个免费、快速的 ZIP 密码破解工具，专门用于破解 ZIP 格式的加密压缩文件。它具有以下特点：

- **快速**: 优化的算法，破解速度快
- **免费**: 开源软件，完全免费使用
- **跨平台**: 支持 Linux、macOS、FreeBSD 等 Unix 系统
- **多模式**: 支持暴力破解和字典破解
- **灵活**: 可自定义字符集、密码长度等参数

## 2. 安装方法

### 2.1 macOS 安装

```bash
# 使用 Homebrew 安装
brew install fcrackzip

# 验证安装
fcrackzip -h
```

### 2.2 Linux 安装

```bash
# Ubuntu/Debian
sudo apt-get install fcrackzip

# CentOS/RHEL
sudo yum install fcrackzip

# Arch Linux
sudo pacman -S fcrackzip
```

### 2.3 源码编译

```bash
# 下载源码
wget http://www.goof.com/pcg/marc/fcrackzip-1.0.tar.gz
tar -xzf fcrackzip-1.0.tar.gz
cd fcrackzip-1.0

# 编译安装
./configure
make
sudo make install
```

## 3. 基本语法

```bash
fcrackzip [选项] 文件名.zip
```

## 4. 参数详解

### 4.1 基本参数

| 参数 | 长参数 | 功能说明 |
|------|--------|----------|
| `-h` | `--help` | 显示帮助信息和版本号 |
| `-v` | `--verbose` | 详细模式，显示更多信息 |
| `-V` | `--validate` | 验证破解算法的基本功能 |
| `-B` | `--benchmark` | 执行性能测试 |
| `--version` | | 显示版本信息 |

### 4.2 破解模式参数

| 参数 | 长参数 | 功能说明 |
|------|--------|----------|
| `-b` | `--brute-force` | 使用暴力破解模式 |
| `-D` | `--dictionary` | 使用字典破解模式 |

### 4.3 字符集参数

| 参数 | 长参数 | 功能说明 |
|------|--------|----------|
| `-c` | `--charset` | 指定字符集 |

**字符集说明：**

- `a`: 小写字母 [a-z]
- `A`: 大写字母 [A-Z]
- `1`: 数字 [0-9]
- `!`: 特殊字符 [!:$%&/()=?{[]}+*~#]
- `:`: 冒号后面的字符直接包含在字符集中

**字符集组合示例：**

- `a1`: 小写字母 + 数字
- `aA1`: 小写字母 + 大写字母 + 数字
- `aA1!`: 小写字母 + 大写字母 + 数字 + 特殊字符
- `a1:@#`: 小写字母 + 数字 + @ 符号 + # 符号

### 4.4 密码参数

| 参数 | 长参数 | 功能说明 |
|------|--------|----------|
| `-p` | `--init-password` | 设置初始密码或字典文件路径 |
| `-l` | `--length` | 设置密码长度范围 (min-max) |

### 4.5 高级参数

| 参数 | 长参数 | 功能说明 |
|------|--------|----------|
| `-u` | `--use-unzip` | 使用 unzip 验证密码，过滤假阳性 |
| `-m` | `--method` | 指定破解方法 (0=cpmask, 1=zip1, 2=zip2) |
| `-2` | `--modulo` | 分布式破解支持 (暂未完全实现) |

## 5. 暴力破解模式详解

### 5.1 基本暴力破解

```bash
# 最简单的暴力破解，使用默认字符集
fcrackzip -b test.zip

# 使用详细模式
fcrackzip -b -v test.zip
```

### 5.2 指定字符集的暴力破解

```bash
# 只使用小写字母
fcrackzip -b -c 'a' test.zip

# 使用大小写字母和数字
fcrackzip -b -c 'aA1' test.zip

# 使用所有字符类型
fcrackzip -b -c 'aA1!' test.zip

# 自定义字符集
fcrackzip -b -c 'a1:@#$%' test.zip
```

### 5.3 指定密码长度

```bash
# 破解长度为 6 的密码
fcrackzip -b -l 6 test.zip

# 破解长度为 4-8 的密码
fcrackzip -b -l 4-8 test.zip

# 破解长度为 1-10 的密码，使用大小写字母和数字
fcrackzip -b -c 'aA1' -l 1-10 test.zip
```

### 5.4 使用初始密码

```bash
# 从指定密码开始破解
fcrackzip -b -p 'abc123' test.zip

# 从 'pass' 开始，破解长度为 8 的密码
fcrackzip -b -p 'pass' -l 8 test.zip
```

### 5.5 完整的暴力破解示例

```bash
# 示例1: 破解纯数字密码
fcrackzip -b -c '1' -l 4-6 -v -u test.zip

# 示例2: 破解常见密码格式
fcrackzip -b -c 'aA1' -l 6-10 -v -u test.zip

# 示例3: 从已知前缀开始破解
fcrackzip -b -c 'aA1' -p 'admin' -v -u test.zip

# 示例4: 破解包含特殊字符的密码
fcrackzip -b -c 'aA1!' -l 8-12 -v -u test.zip
```

## 6. 字典破解模式详解

### 6.1 准备字典文件

```bash
# 创建字典文件
cat > password_dict.txt << EOF
123456
password
admin
123456789
qwerty
abc123
password123
admin123
root
guest
EOF
```

### 6.2 基本字典破解

```bash
# 使用字典文件破解
fcrackzip -D -p password_dict.txt test.zip

# 使用详细模式
fcrackzip -D -p password_dict.txt -v test.zip

# 使用 unzip 验证
fcrackzip -D -p password_dict.txt -v -u test.zip
```

### 6.3 常用字典文件

```bash
# 使用系统自带的字典 (Kali Linux)
fcrackzip -D -p /usr/share/wordlists/rockyou.txt test.zip

# 使用自定义字典
fcrackzip -D -p /path/to/custom_dict.txt test.zip
```

### 6.4 创建高质量字典

```bash
# 创建数字字典
for i in {0000..9999}; do echo $i; done > numbers.txt
fcrackzip -D -p numbers.txt test.zip

# 创建日期字典
for year in {1980..2024}; do
    for month in {01..12}; do
        for day in {01..31}; do
            echo "${year}${month}${day}"
        done
    done
done > dates.txt
```

## 7. 高级功能

### 7.1 性能测试

```bash
# 执行性能测试
fcrackzip -B

# 查看不同方法的性能
fcrackzip -B -m 0
fcrackzip -B -m 1
fcrackzip -B -m 2
```

### 7.2 选择破解方法

```bash
# 查看可用方法
fcrackzip -h

# 使用 zip1 方法
fcrackzip -b -m 1 test.zip

# 使用 zip2 方法 (默认)
fcrackzip -b -m 2 test.zip
```

### 7.3 CP Mask 模式

```bash
# 用于破解 CP Mask 加密的图片
fcrackzip -m 0 -c 'A' -p 'AAAA' test.ppm
```

## 8. 实际应用案例

### 8.1 案例1: 破解数字密码

```bash
# 场景：已知密码是 4-6 位数字
fcrackzip -b -c '1' -l 4-6 -v -u document.zip
```

### 8.2 案例2: 破解常见密码

```bash
# 场景：密码可能是常见的字母数字组合
fcrackzip -b -c 'aA1' -l 6-10 -v -u backup.zip
```

### 8.3 案例3: 已知部分密码

```bash
# 场景：已知密码以 "pass" 开头
fcrackzip -b -c 'aA1' -p 'pass' -v -u secret.zip
```

### 8.4 案例4: 使用字典破解

```bash
# 场景：使用常见密码字典
fcrackzip -D -p common_passwords.txt -v -u data.zip
```

## 9. 优化技巧

### 9.1 提高破解效率

1. **使用 -u 参数**: 启用 unzip 验证，减少假阳性
2. **限制密码长度**: 使用 -l 参数缩小搜索范围
3. **选择合适的字符集**: 根据密码特点选择 -c 参数
4. **使用多个文件**: 同时破解多个加密文件提高准确性

### 9.2 并行处理

```bash
# 使用 GNU parallel 并行破解
parallel -j 4 fcrackzip -b -c 'aA1' -l {} test.zip ::: 4 5 6 7
```

### 9.3 分段破解

```bash
# 分段破解长密码
fcrackzip -b -c 'aA1' -l 8-10 -p 'a' test.zip &
fcrackzip -b -c 'aA1' -l 8-10 -p 'b' test.zip &
fcrackzip -b -c 'aA1' -l 8-10 -p 'c' test.zip &
```

## 10. 常见问题解答

### 10.1 为什么破解失败？

1. **密码太复杂**: 密码长度过长或字符集过大
2. **字符集不匹配**: 实际密码包含的字符未在指定字符集中
3. **加密算法不支持**: 使用了不支持的 ZIP 加密算法
4. **文件损坏**: ZIP 文件本身已损坏

### 10.2 如何提高破解成功率？

1. **收集信息**: 了解密码可能的格式和特点
2. **使用字典**: 基于目标的字典攻击更有效
3. **组合攻击**: 字典攻击失败后再尝试暴力破解
4. **多文件验证**: 使用多个加密文件提高准确性

### 10.3 性能优化建议

1. **合理设置参数**: 不要盲目使用最大字符集和长度
2. **使用 -u 参数**: 避免假阳性结果
3. **选择合适的方法**: 根据 ZIP 文件类型选择破解方法
4. **硬件优化**: 使用更快的 CPU 和更多内存

## 11. 参考链接

- [FreeBSD 手册页](https://man.freebsd.org/cgi/man.cgi?query=fcrackzip)
- [常用密码字典](https://github.com/danielmiessler/SecLists)
- [ZIP 加密算法说明](https://en.wikipedia.org/wiki/ZIP_(file_format)#Encryption)
