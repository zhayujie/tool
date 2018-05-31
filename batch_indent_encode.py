# -*- coding: utf-8 -*-
import os, codecs

#计算该行应有的缩进空格（考虑Tab和空格混用的情况）
def count_space(st):
    count = 0
    if st == '\n':
        return 0
    for ch in st:
        if ch == '\t':
            count = count + 4
        elif ch == ' ':                             
            count = count + 1
        else:
            break
    return count    

#处理文件：1.将tab转换成相应个数的空格 2.转化为utf-8编码
def process_file(src_path, dest_path):
    #设置写入的编码方式为utf-8
    #或使用open(dest_path, 'w', encoding = 'utf8')
    with open(src_path, 'r') as fr, codecs.open(dest_path, 'w', 'utf-8') as fw:
        for line in fr.readlines():
            clean_line = line.strip()    
            n_space = count_space(line)
            i = 0
            sp = ''
            while i < n_space:
                sp = sp + ' '
                i = i + 1
            line = sp + clean_line + '\n'
            fw.write(line)

#递归遍历整个目录
def travel(src_path, dest_path, item):
    if not os.path.isdir(src_path):
        if os.path.splitext(src_path)[1] == item:
            process_file(src_path, dest_path)           #直到遇到相应文件，就进行处理
        return

    if not os.path.isdir(dest_path):                    #创建对应的目标目录
        os.mkdir(dest_path)
    #层层深入
    for filename in os.listdir(src_path):
        travel(os.path.join(src_path, filename), os.path.join(dest_path, filename), item)

if __name__ == '__main__':
    src_root = '/Users/zyj/zhayujie/tool'               #接收要处理的文件夹（这里直接指定）
    dest_root = src_root + '-new'                                           
    item = '.sh'                                                             
    travel(src_root, dest_root, item) 