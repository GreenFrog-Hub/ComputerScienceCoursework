import names as nm

Tnames = open("NNames.txt","w")
for i in range(0,1000):
    fname, sname =nm.get_full_name().split()
    print(fname,sname)

    Tnames.writelines(fname+"\n")
    Tnames.writelines(sname+"\n")
