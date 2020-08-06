#!/usr/bin/python

from ctypes import *

 
# Get Memory Info(Total, Used... Byte)

def get_memory_stat(): 

    mem = {} 

    f = open("/proc/meminfo") 

    lines = f.readlines() 

    f.close() 

    for line in lines: 

        if len(line)< 2:continue 

        name = line.split(':')[0] 

        var = line.split(':')[1].split()[0] 

        mem[name]= long(var)* 1024.0 

    mem['MemUsed']= mem['MemTotal']- mem['MemFree']

    # Return MemroyInfo Object

    return mem

 

# Get Simple Memory Info

def get_memory_info(mem):

    # Byte -> MB

    n=1024* 1024

    used=float(mem['MemUsed'])/ n

    total=float(mem['MemTotal'])/ n

    rate=used/total* 100

    smp={'used':used,'total':total,'rate':rate}

    return smp

 

# Display Current Memory Info

def print_memory_info(mem):

    # Get SimpleMemory Info

    smp=get_memory_info(mem)

    print("Used(MB):%d\tTotal(MB):%d\tUsedRate:%d%%"%(smp['used'], smp['total'], smp['rate']))

   

# Get Rate Of Memory Used To Be Setted(Integer Formate)

def input_memory_used_rate(org_rate):

    # Byte -> MB

    n=1024* 1024

    while(True):

        mem=get_memory_stat()
        print_memory_info(mem)

 

        input_str=raw_input("Input UsedMemory`s Rate or q to exit:")

        if(len(input_str)== 0):

            continue
        if("q"== input_str):

            info={'rate':0,'used':mem['MemUsed']/ n}
            return info
        if("Q"== input_str):

            info={'rate':0,'used':mem['MemUsed']/ n}
            return info

        try:

            rate=float(input_str)

            if((rate>=org_rate)and (rate<=95)):

               info={'rate':rate,'used':mem['MemUsed']/ n}
               return info
            else:

                print("Please inputa valid number(%d%%~95%%)."%(org_rate))

        except:

            print("Please inputa valid number(%d%%~95%%)."%(org_rate))    

 

# Set Rate Of Memory Used

def set_memory_used_rate(new_rate, total, pre_used,list):

    if(new_rate==0):

        return None

    dest_mem=total* new_rate /100.0

    # 10MB

    mb10=10485760

    n_chg=10

    # Free Memory OrAllocate Memory ?

    is_new=dest_mem>pre_used

    cur_used=pre_used

    while(True):

        # To Calc FreeMemory Or Allocate Memory ?

        need_new=dest_mem-n_chg>=pre_used

        need_del=dest_mem+n_chg<=pre_used

       

        # Need To AllocateMemory

        if(is_new):

            if(need_new):

                p=create_string_buffer(mb10)

                list.append(p)

                dest_mem=dest_mem-n_chg

                cur_used=cur_used+n_chg

            else:

                return"end"

        # Need To FreeMemory

        else:

            idx=len(list)-1

            if(need_deland (idx>=0)):

                p=list[idx]

                del list[idx]

                p=None

                dest_mem=dest_mem+n_chg

                cur_used=cur_used-n_chg

            else:

                return"end"

        print("****** MemoryUsed(MB):%d"%(cur_used))

       

# Entry Of Program

 

# List Of Memory Object, 10MB Of One Object

list=[]

# Get Current Memory Info

mem=get_memory_stat()

# Get Simple Memory Info

smp=get_memory_info(mem)

org_rate=smp['rate']

total=smp['total']

 

while(True):

    # Get Rate OfMemory To Be Used

    info=input_memory_used_rate(org_rate)

    new_rate=float(info['rate'])

    pre_used=float(info['used'])

    # Set Rate OfMemory To Be Used

    rtn=set_memory_used_rate(new_rate, total, pre_used, list)

    if(not rtn):

        print("bye!")

        exit()
