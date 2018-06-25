# -*- coding: utf-8 -*-
import os
#计算文件行数
def count_file(file_name):
    with open(file_name, 'r', encoding = 'utf-8') as f:
        num = len(f.readlines())
    return num

#统计该路径下文件行数
def count(path, item):
    sum = 0                         #当前路径（目录或文件）内的行数
    if not os.path.isdir(path):
        if os.path.splitext(path)[1] == item:
            sum = count_file(path)
        return sum
        
    else:
        for file_name in os.listdir(path):
            sum += count(os.path.join(path, file_name), item)
    return sum
    
if __name__ == '__main__':
    root = '/Users/zyj/go/src/github.com/airtrip'
    item = '.py'
    total_line = count(root, item)
    print(total_line)